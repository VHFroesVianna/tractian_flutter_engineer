import 'package:get/get.dart';
import 'package:tractian_test/controllers/data/data_controller.dart';
import 'package:tractian_test/models/asset/asset.dart';
import 'package:tractian_test/models/location/location.dart';

class ButtonFilterController extends GetxController {
  final DataController _dataController;

  final isEnergyFilterActive = false.obs;
  final isAlertFilterActive = false.obs;

  final filteredLocations = <Location>[].obs;
  final filteredUnlinkedAssets = <Asset>[].obs;

  ButtonFilterController({required DataController dataController})
      : _dataController = dataController;

  void filterTree({bool? energyFilterActive, bool? alertFilterActive}) {
    if (energyFilterActive != null) {
      isEnergyFilterActive(energyFilterActive);
    }
    if (alertFilterActive != null) {
      isAlertFilterActive(alertFilterActive);
    }

    if (isEnergyFilterActive.value || isAlertFilterActive.value) {
      _filterLocations();
      _filterUnlinkedAssets();
    }
  }

  void _filterLocations() {
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

  void _filterUnlinkedAssets() {
    final allUnlinkedAssets = _dataController.unlinkedAssets.toList();
    final filtered = allUnlinkedAssets.where((unlinkedAsset) {
      final matchesEnergy = isEnergyFilterActive.value &&
          unlinkedAsset.sensorType?.toLowerCase() == 'energy';
      final matchesAlert = isAlertFilterActive.value &&
          unlinkedAsset.status?.toLowerCase() == 'alert';
      return matchesEnergy || matchesAlert;
    }).toList();

    filteredUnlinkedAssets.assignAll(filtered);
  }

  Location? _filterLocationTree(Location location) {
    final filteredSublocations = location.sublocations
        .map(_filterLocationTree)
        .where((sublocation) => sublocation != null)
        .toList();

    final filteredAssets = location.assets
        .map(_filterAssetTree)
        .where((asset) => asset != null)
        .toList();

    if (filteredSublocations.isNotEmpty || filteredAssets.isNotEmpty) {
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
    final matchesEnergy =
        isEnergyFilterActive.value && asset.sensorType?.toLowerCase() == 'energy';
    final matchesAlert =
        isAlertFilterActive.value && asset.status?.toLowerCase() == 'alert';

    final filteredSubassets = asset.assets
        .map(_filterAssetTree)
        .where((subasset) => subasset != null)
        .toList();

    if (matchesEnergy || matchesAlert || filteredSubassets.isNotEmpty) {
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