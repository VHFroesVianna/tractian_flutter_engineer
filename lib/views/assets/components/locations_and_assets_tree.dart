import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractian_test/controllers/data/data_controller.dart';
import 'package:tractian_test/models/asset/asset.dart';
import 'package:tractian_test/models/location/location.dart';

class LocationsAndAssetsTree extends StatelessWidget {
  final String? unitName;

  const LocationsAndAssetsTree({super.key, this.unitName});

  @override
  Widget build(BuildContext context) {
    final path = unitName?.split(' ').first.trim().toLowerCase();
    final DataController dataController = Get.put(DataController(
      locationsPath: 'assets/json/$path/locations.json',
      assetsPath: 'assets/json/$path/assets.json',
    ));

    return Obx(
      () {
        if (dataController.isLoading.value) return Container();
        final List<Location> locations = dataController.locations;
        final List<Asset> unlinkedAssets = dataController.unlinkedAssets;
        return ListView(
          children: [
            ...locations
                .map((location) => LocationExpansionTile(location: location)),
          ],
        );
      },
    );
  }
}

class LocationExpansionTile extends StatelessWidget {
  final Location location;

  const LocationExpansionTile({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(location.name),
      tilePadding: const EdgeInsets.only(left: 0),
      childrenPadding: const EdgeInsets.only(left: 10),
      controlAffinity: ListTileControlAffinity.leading,
      expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ...location.sublocations
            .map((subLocation) => LocationExpansionTile(location: subLocation)),
        ...location.assets.map((asset) => AssetExpansionTile(asset: asset)),
      ],
    );
  }
}

class AssetExpansionTile extends StatelessWidget {
  final Asset asset;
  const AssetExpansionTile({super.key, required this.asset});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(asset.name),
      tilePadding: const EdgeInsets.only(left: 0),
      childrenPadding: const EdgeInsets.only(left: 10),
      controlAffinity: ListTileControlAffinity.leading,
      expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ...asset.assets.map((asset) => AssetExpansionTile(asset: asset)),
      ],
    );
  }
}
