import 'package:flutter_test/flutter_test.dart';
import 'package:tractian_test/models/asset/asset.dart';
import 'package:tractian_test/models/location/location.dart';

void main() {
  group('Location Model tests:', () {
    test('Location creation and property', () {
      final location = Location(
        name: 'Location 1',
        id: 'loc1',
        parentId: 'parent1',
      );

      expect(location.name, 'Location 1');
      expect(location.id, 'loc1');
      expect(location.parentId, 'parent1');
      expect(location.sublocations, isEmpty);
      expect(location.assets, isEmpty);
    });

    test('Location.isTopLocation', () {
      final topLocation = Location(
        name: 'Location 1',
        id: 'loc1',
      );

      final subLocation = Location(
        name: 'Location 2',
        id: 'loc2',
        parentId: 'loc1',
      );

      expect(topLocation.isTopLocation, isTrue);
      expect(subLocation.isTopLocation, isFalse);
    });

    test('Location.isEmpty', () {
      final emptyLocation = Location(
        name: 'Location 1',
        id: 'loc1',
      );

      final locationWithSublocations = Location(
        name: 'Location 2',
        id: 'loc2',
        sublocations: [Location(name: 'SubLocation 1', id: 'sub1')],
      );

      final locationWithAssets = Location(
        name: 'Location 3',
        id: 'loc3',
        assets: [Asset(name: 'Asset 1', id: 'asset1')],
      );

      expect(emptyLocation.isEmpty, isTrue);
      expect(locationWithSublocations.isEmpty, isFalse);
      expect(locationWithAssets.isEmpty, isFalse);
    });
  });
}
