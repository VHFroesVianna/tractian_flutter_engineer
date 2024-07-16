import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:tractian_test/models/asset/asset.dart';
import 'package:tractian_test/theme/app_colors.dart';

class ComponentTile extends StatelessWidget {
  final Asset component;

  const ComponentTile({super.key, required this.component});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/component.png'),
          const SizedBox(width: 10),
          Text(component.name),
          const SizedBox(width: 5),
          component.sensorType?.toLowerCase() == 'energy'
              ? PhosphorIcon(
                  PhosphorIcons.lightning(PhosphorIconsStyle.fill),
                  color: AppColors.energySensor,
                  size: 15,
                )
              : PhosphorIcon(
                  PhosphorIcons.circle(PhosphorIconsStyle.fill),
                  color: AppColors.vibrationSensor,
                  size: 15,
                ),
        ],
      ),
    );
  }
}
