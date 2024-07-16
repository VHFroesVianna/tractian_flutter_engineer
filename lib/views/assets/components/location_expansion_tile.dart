import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:tractian_test/models/location/location.dart';
import 'package:tractian_test/theme/app_colors.dart';
import 'package:tractian_test/views/assets/components/empty_location_tile.dart';
import 'package:tractian_test/views/assets/components/lines_painter.dart';
import 'asset_expansion_tile.dart';
import 'component_tile.dart';

class LocationExpansionTile extends StatelessWidget {
  final Location location;
  final double childrenPadding;

  const LocationExpansionTile({
    super.key,
    required this.location,
    required this.childrenPadding,
  });

  @override
  Widget build(BuildContext context) {
    final icon = PhosphorIcon(
      PhosphorIcons.mapPin(),
      color: AppColors.primary,
    );

    return CustomPaint(
      painter: LinesPainter(childrenPadding),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Row(
            children: [
              icon,
              const SizedBox(width: 1),
              Flexible(
                  child: Text(location.name, overflow: TextOverflow.visible))
            ],
          ),
          iconColor: AppColors.primary,
          tilePadding: const EdgeInsets.all(0),
          childrenPadding: EdgeInsets.all(childrenPadding),
          controlAffinity: ListTileControlAffinity.leading,
          children: [
            ...location.sublocations.map((subLocation) => subLocation.isEmpty
                ? EmptyLocationTile(location: subLocation)
                : LocationExpansionTile(
                    location: subLocation, childrenPadding: childrenPadding)),
            ...location.assets.map((asset) => asset.isComponent
                ? ComponentTile(component: asset)
                : AssetExpansionTile(
                    asset: asset, childrenPadding: childrenPadding)),
          ],
        ),
      ),
    );
  }
}
