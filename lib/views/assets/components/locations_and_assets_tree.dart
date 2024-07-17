import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractian_test/controllers/data/data_controller.dart';
import 'package:tractian_test/controllers/filter/text_filter_controller.dart';
import 'package:tractian_test/models/asset/asset.dart';
import 'package:tractian_test/models/location/location.dart';
import 'package:tractian_test/views/assets/components/shimmer_loading_tree.dart';
import 'component_tile.dart';
import 'empty_location_tile.dart';
import 'location_expansion_tile.dart';

class LocationsAndAssetsTree extends StatelessWidget {
  const LocationsAndAssetsTree({super.key});

  @override
  Widget build(BuildContext context) {
    final DataController dataController = Get.find<DataController>();
    final TextFilterController textFilterController =
        Get.find<TextFilterController>();

    return Obx(
      () {
        if (dataController.isLoading.value) return const ShimmerLoadingTree();
        final List<Location> locations = dataController.locations;
        final List<Asset> unlinkedAssets = dataController.unlinkedAssets;
        const childrenPadding = 7.0;
        return ListView(
            children: textFilterController.input.value == ''
                ? [
                    ...locations.map((location) => location.isEmpty
                        ? EmptyLocationTile(location: location)
                        : LocationExpansionTile(
                            location: location,
                            childrenPadding: childrenPadding,
                          )),
                    ...unlinkedAssets.map((unlinkedAsset) =>
                        ComponentTile(component: unlinkedAsset)),
                  ]
                : [
                    ...textFilterController.filteredLocations
                        .map((location) => location.isEmpty
                            ? EmptyLocationTile(location: location)
                            : LocationExpansionTile(
                                location: location,
                                childrenPadding: childrenPadding,
                              )),
                    ...textFilterController.filteredUnlinkedAssets.map(
                        (unlinkedAsset) =>
                            ComponentTile(component: unlinkedAsset)),
                  ]);
      },
    );
  }
}
