import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:tractian_test/models/location/location.dart';
import 'package:tractian_test/theme/app_colors.dart';

class EmptyLocationTile extends StatelessWidget {
  final Location location;

  const EmptyLocationTile({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Row(
      children: [
        PhosphorIcon(
          PhosphorIcons.mapPin(),
          color: AppColors.primary,
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Text(
            location.name,
            overflow: TextOverflow.visible,
          ),
        ),
      ],
    ));
  }
}
