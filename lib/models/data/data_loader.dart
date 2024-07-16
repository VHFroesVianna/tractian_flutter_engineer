import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:tractian_test/models/asset/asset.dart';
import 'package:tractian_test/models/location/location.dart';

class DataLoader {
  Future<String> _readJsonFile(String path) async =>
      await rootBundle.loadString(path);

  Future<List<Map<String, dynamic>>> _decodeJson(String jsonString) async =>
      List<Map<String, dynamic>>.from(json.decode(jsonString));

  Future<List<Map<String, dynamic>>> _decodedList(String path) async {
    final jsonString = await _readJsonFile(path);
    return await _decodeJson(jsonString);
  }

  Future<List<Asset>> _parseAssets(List<Map<String, dynamic>> jsonList) async =>
      Future.value(jsonList.map((json) => Asset.fromJson(json)).toList());

  Map<String, Asset> _mapAssets(List<Asset> assets) {
    final Map<String, Asset> assetMap = {
      for (var asset in assets) asset.id: asset
    };
    return assetMap;
  }

  Future<Map<String, Asset>> _loadAssets(String path) async {
    final jsonList = await _decodedList(path);
    final allAssets = await _parseAssets(jsonList);
    return _mapAssets(allAssets);
  }

  Future<List<Asset>> loadUnlinkedAssets(String path) async {
    final jsonList = await _decodedList(path);
    return await _parseAssets(jsonList)
        .then((value) => value.where((asset) => asset.isUnlinked).toList());
  }

  Future<List<Location>> _parseLocations(
          List<Map<String, dynamic>> jsonList) async =>
      Future.value(jsonList.map((json) => Location.fromJson(json)).toList());

  Map<String, Location> _mapLocations(List<Location> locations) {
    final Map<String, Location> locationMap = {
      for (var location in locations) location.id: location
    };
    return locationMap;
  }

  Future<Map<String, Location>> _loadLocations(String path) async {
    final jsonList = await _decodedList(path);
    final allLocations = await _parseLocations(jsonList);
    return _mapLocations(allLocations);
  }

  Map<String, Location> _organizeAssetsToParents(
      Map<String, Asset> assets, Map<String, Location> locationsMap) {
    for (var asset in assets.values) {
      if (!asset.isUnlinked) {
        if (asset.parentId != null) {
          final parentAsset = assets[asset.parentId];
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
    final assetsToLocations = locationsMap;
    return assetsToLocations;
  }

  List<Location> _organizeLocationsToParents(
    Map<String, Location> locations,
  ) {
    final List<Location> organizedLocations = [];
    for (var location in locations.values) {
      if (location.isTopLocation) {
        organizedLocations.add(location);
      } else {
        final parentLocation = locations[location.parentId];
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
  }

  Future<List<Location>> loadAndOrganizeData(
    String locationsPath,
    String assetsPath,
  ) async {
    final locationsMap = await _loadLocations(locationsPath);
    final assetsMap = await _loadAssets(assetsPath);

    final organizedAssetsToLocations =
        _organizeAssetsToParents(assetsMap, locationsMap);
    final organizedLocations =
        _organizeLocationsToParents(organizedAssetsToLocations);

    return organizedLocations;
  }
}
