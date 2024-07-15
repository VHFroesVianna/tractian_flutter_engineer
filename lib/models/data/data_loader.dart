import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:tractian_test/models/asset/asset.dart';
import 'package:tractian_test/models/location/location.dart';

class DataLoader {
  // Method to read a JSON file asynchronously from assets
  Future<String> _readJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  // Method to decode a JSON string asynchronously
  Future<List<Map<String, dynamic>>> _decodeJson(String jsonString) async {
    return List<Map<String, dynamic>>.from(json.decode(jsonString));
  }

  // Method to parse JSON list into Location objects asynchronously
  Future<List<Location>> _parseLocations(
      List<Map<String, dynamic>> jsonList) async {
    return Future.value(
        jsonList.map((json) => Location.fromJson(json)).toList());
  }

  // Method to parse JSON list into Asset objects asynchronously
  Future<List<Asset>> _parseAssets(List<Map<String, dynamic>> jsonList) async {
    return Future.value(jsonList.map((json) => Asset.fromJson(json)).toList());
  }

  // Public method to load and parse Location data from a JSON file
  Future<List<Location>> loadLocations(String path) async {
    final jsonString = await _readJsonFile(path);
    final jsonList = await _decodeJson(jsonString);
    final allLocations = await _parseLocations(jsonList);
    return _organizeLocations(allLocations);
  }

  // Public method to load and parse Asset data from a JSON file
  Future<List<Asset>> _loadAssets(String path) async {
    final jsonString = await _readJsonFile(path);
    final jsonList = await _decodeJson(jsonString);
    final allAssets = await _parseAssets(jsonList);
    return allAssets; // This method should return allAssets directly
  }

  Future<List<Asset>> loadUnlinkedAssets(String path) async =>
      await _loadAssets(path)
          .then((value) => value.where((asset) => asset.isUnlinked).toList());

  // Method to organize locations into a hierarchical structure
  List<Location> _organizeLocations(List<Location> locations) {
    final Map<String, Location> locationMap = {
      for (var location in locations) location.id: location
    };
    final List<Location> organizedLocations = [];
    for (var location in locations) {
      if (location.isTopLocation) {
        organizedLocations.add(location);
      } else {
        final parentLocation = locationMap[location.parentId];
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

  // Method to organize assets into a hierarchical structure and assign them to locations
  List<Asset> _organizeAssets(
      List<Asset> assets, Map<String, Location> locationMap) {
    final Map<String, Asset> assetMap = {
      for (var asset in assets) asset.id: asset
    };
    final List<Asset> organizedAssets = [];
    for (var asset in assets) {
      organizedAssets.add(asset);
      if (!asset.isUnlinked) {
        if (asset.parentId != null) {
          final parentAsset = assetMap[asset.parentId];
          if (parentAsset != null) {
            parentAsset.assets = [...parentAsset.assets, asset];
            organizedAssets.removeWhere((element) => element.id == asset.id);
          }
        } else if (asset.locationId != null) {
          final parentLocation = locationMap[asset.locationId];
          if (parentLocation != null) {
            parentLocation.assets = [...parentLocation.assets, asset];
            organizedAssets.removeWhere((element) => element.id == asset.id);
          }
        }
      }
    }
    return organizedAssets;
  }

  // Method to load and organize locations and assets together
  Future<List<Location>> loadAndOrganizeData(
      String locationsPath, String assetsPath) async {
    final locations = await loadLocations(locationsPath);
    final jsonString = await _readJsonFile(assetsPath);
    final jsonList = await _decodeJson(jsonString);
    final allAssets = await _parseAssets(jsonList);

    // Create a map of organized locations for quick lookup
    final Map<String, Location> locationMap = {
      for (var location in locations) location.id: location
    };

    _organizeAssets(allAssets, locationMap);

    return locations;
  }
}
