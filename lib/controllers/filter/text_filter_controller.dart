import 'package:get/get.dart';
import 'package:tractian_test/controllers/data/data_controller.dart';
import 'package:tractian_test/models/asset/asset.dart';
import 'package:tractian_test/models/location/location.dart';

class TextFilterController extends GetxController {
  final DataController _dataController;

  final input = ''.obs;
  set setInput(String value) {
    _filterLocations(value);
    _filterComponents(value);
  }

  var filteredLocations = <Location>[];
  var filteredUnlinkedAssets = <Asset>[];

  TextFilterController({required DataController dataController})
      : _dataController = dataController;

  void _filterLocations(String value) {
    input(value);
    final allLocations = _dataController.locations;
    final filtered = <Location>[];

    for (var location in allLocations) {
      final filteredLocation = _filterLocationTree(location);
      if (filteredLocation != null) {
        filtered.add(filteredLocation);
      }
    }

    filteredLocations.assignAll(filtered);
  }

  void _filterComponents(String value) {
    final allUnlinkedAssets = _dataController.unlinkedAssets.toList();
    final filtered = allUnlinkedAssets
        .where((unlinkedAsset) =>
            unlinkedAsset.name.toLowerCase().contains(value.toLowerCase()))
        .toList();
    filteredUnlinkedAssets.assignAll(filtered);
  }

  Location? _filterLocationTree(Location location) {
    final matchesLocation =
        location.name.toLowerCase().contains(input.value.toLowerCase());

    final filteredSublocations = location.sublocations
        .map(_filterLocationTree)
        .where((sublocation) => sublocation != null)
        .toList();

    final filteredAssets = location.assets
        .map(_filterAssetTree)
        .where((asset) => asset != null)
        .toList();

    if (matchesLocation ||
        filteredSublocations.isNotEmpty ||
        filteredAssets.isNotEmpty) {
      return Location(
        name: location.name,
        id: location.id,
        parentId: location.parentId,
        sublocations: filteredSublocations.cast<Location>(),
        assets: filteredAssets.cast<Asset>(),
      );
    }

    return null;
  }

  Asset? _filterAssetTree(Asset asset) {
    final matchesAsset =
        asset.name.toLowerCase().contains(input.value.toLowerCase());

    final filteredSubassets = asset.assets
        .map(_filterAssetTree)
        .where((subasset) => subasset != null)
        .toList();

    if (matchesAsset || filteredSubassets.isNotEmpty) {
      return Asset(
        name: asset.name,
        id: asset.id,
        locationId: asset.locationId,
        parentId: asset.parentId,
        sensorType: asset.sensorType,
        status: asset.status,
        assets: filteredSubassets.cast<Asset>(),
      );
    }

    return null;
  }
}
