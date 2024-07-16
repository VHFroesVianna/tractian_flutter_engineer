import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:tractian_test/models/asset/asset.dart';
import 'package:tractian_test/theme/app_colors.dart';
import 'package:tractian_test/views/assets/components/lines_painter.dart';
import 'component_tile.dart';

class AssetExpansionTile extends StatelessWidget {
  final Asset asset;
  final double childrenPadding;
  const AssetExpansionTile(
      {super.key, required this.asset, required this.childrenPadding});

  @override
  Widget build(BuildContext context) {
    return asset.isEmpty
        ? ListTile(
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PhosphorIcon(
                  PhosphorIcons.cube(),
                  color: AppColors.primary,
                ),
                const SizedBox(width: 5),
                Text(asset.name),
              ],
            ),
          )
        : CustomPaint(
            painter: LinesPainter(childrenPadding),
            child: ExpansionTile(
              title: ListTile(
                selectedColor: AppColors.primary,
                leading: PhosphorIcon(
                  PhosphorIcons.cube(),
                  color: AppColors.primary,
                ),
                title: Text(asset.name),
              ),
              iconColor: AppColors.primary,
              tilePadding: const EdgeInsets.all(0),
              childrenPadding: EdgeInsets.all(childrenPadding),
              controlAffinity: ListTileControlAffinity.leading,
              children: [
                ...asset.assets.map((asset) => asset.isComponent
                    ? ComponentTile(component: asset)
                    : AssetExpansionTile(
                        asset: asset, childrenPadding: childrenPadding)),
              ],
            ),
          );
  }
}
