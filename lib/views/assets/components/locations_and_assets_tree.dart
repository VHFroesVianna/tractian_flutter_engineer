import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractian_test/controllers/data/data_controller.dart';
import 'package:tractian_test/models/asset/asset.dart';
import 'package:tractian_test/models/location/location.dart';
import 'package:tractian_test/views/assets/components/shimmer_loading_tree.dart';
import 'component_tile.dart';
import 'empty_location_tile.dart';
import 'location_expansion_tile.dart';

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
        if (dataController.isLoading.value) return const ShimmerLoadingTree();
        final List<Location> locations = dataController.locations;
        final List<Asset> unlinkedAssets = dataController.unlinkedAssets;
        const childrenPadding = 7.0;
        return ListView(
          children: [
            ...locations.map((location) => location.isEmpty
                ? EmptyLocationTile(location: location)
                : LocationExpansionTile(
                    location: location,
                    childrenPadding: childrenPadding,
                  )),
            ...unlinkedAssets.map(
                (unlinkedAsset) => ComponentTile(component: unlinkedAsset)),
          ],
        );
      },
    );
  }
}
