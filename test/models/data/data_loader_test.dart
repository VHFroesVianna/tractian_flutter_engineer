import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:tractian_test/models/asset/asset.dart';
import 'package:tractian_test/models/location/location.dart';
import 'package:tractian_test/models/data/data_loader.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'data_loader_test.mocks.dart';

@GenerateMocks([DataLoader])
void main() {
  late MockDataLoader mockDataLoader;

  setUp(() {
    mockDataLoader = MockDataLoader();
  });

  group('DataLoader', () {
    const assetJson = '''[
      {"name": "Asset 1", "id": "1", "locationId": "loc1", "sensorType": "sensor1"},
      {"name": "Asset 2", "id": "2"}
    ]''';

    const locationJson = '''[
      {"name": "Location 1", "id": "loc1"},
      {"name": "Location 2", "id": "loc2", "parentId": "loc1"}
    ]''';

    test('loadUnlinkedAssets returns only unlinked assets', () async {
      when(mockDataLoader.loadUnlinkedAssets(any)).thenAnswer((_) async {
        final jsonList = json.decode(assetJson) as List;
        return jsonList
            .map((json) => Asset.fromJson(json as Map<String, dynamic>))
            .where((asset) => asset.isUnlinked)
            .toList();
      });

      final assets = await mockDataLoader.loadUnlinkedAssets('assets.json');
      expect(assets.length, 1);
      expect(assets.first.name, 'Asset 2');
    });

    test('loadAndOrganizeData returns organized data', () async {
      when(mockDataLoader.loadAndOrganizeData(any, any)).thenAnswer((_) async {
        final assetsJsonList = json.decode(assetJson) as List;
        final locationsJsonList = json.decode(locationJson) as List;

        final assets = assetsJsonList
            .map((json) => Asset.fromJson(json as Map<String, dynamic>))
            .toList();
        final locations = locationsJsonList
            .map((json) => Location.fromJson(json as Map<String, dynamic>))
            .toList();

        final assetsMap = {for (var asset in assets) asset.id: asset};
        final locationsMap = {
          for (var location in locations) location.id: location
        };

        for (var asset in assets) {
          if (!asset.isUnlinked) {
            if (asset.parentId != null) {
              final parentAsset = assetsMap[asset.parentId];
              if (parentAsset != null) {
                parentAsset.assets = [...parentAsset.assets, asset];
              }
            } else if (asset.locationId != null) {
              final parentLocation = locationsMap[asset.locationId];
              if (parentLocation != null) {
                parentLocation.assets = [...parentLocation.assets, asset];
              }
            }
          }
        }

        final List<Location> organizedLocations = [];
        for (var location in locations) {
          if (location.isTopLocation) {
            organizedLocations.add(location);
          } else {
            final parentLocation = locationsMap[location.parentId];
            if (parentLocation != null) {
              parentLocation.sublocations = [
                ...parentLocation.sublocations,
                location
              ];
              organizedLocations
                  .removeWhere((element) => element.id == location.id);
            }
          }
        }

        return organizedLocations;
      });

      final organizedData = await mockDataLoader.loadAndOrganizeData(
          'locations.json', 'assets.json');

      expect(organizedData.length, 1);
      expect(organizedData.first.name, 'Location 1');
      expect(organizedData.first.sublocations.length, 1);
      expect(organizedData.first.sublocations.first.name, 'Location 2');
      expect(organizedData.first.assets.length, 1);
      expect(organizedData.first.assets.first.name, 'Asset 1');
    });
  });
}
