import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractian_test/controllers/data/data_controller.dart';
import 'package:tractian_test/controllers/filter/button_filter_controller.dart';
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
    final dataController = Get.find<DataController>();
    final textFilterController = Get.find<TextFilterController>();
    final buttonFilterController = Get.find<ButtonFilterController>();

    return Obx(
      () {
        if (dataController.isLoading.value) return const ShimmerLoadingTree();
        final List<Location> locations = dataController.locations;
        final List<Asset> unlinkedAssets = dataController.unlinkedAssets;
        const childrenPadding = 7.0;

        List<Location> filteredLocations = locations;
        List<Asset> filteredUnlinkedAssets = unlinkedAssets;

        if (textFilterController.input.value.isNotEmpty) {
          filteredLocations = textFilterController.filteredLocations;
          filteredUnlinkedAssets = textFilterController.filteredUnlinkedAssets;
        } else if (buttonFilterController.isEnergyFilterActive.value ||
            buttonFilterController.isAlertFilterActive.value) {
          filteredLocations = buttonFilterController.filteredLocations;
          filteredUnlinkedAssets =
              buttonFilterController.filteredUnlinkedAssets;
        }

        return ListView(
          children: [
            ...filteredLocations.map((location) => location.isEmpty
                ? EmptyLocationTile(location: location)
                : LocationExpansionTile(
                    location: location,
                    childrenPadding: childrenPadding,
                  )),
            ...filteredUnlinkedAssets.map(
                (unlinkedAsset) => ComponentTile(component: unlinkedAsset)),
          ],
        );
      },
    );
  }
}
