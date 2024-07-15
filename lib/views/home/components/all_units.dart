import 'package:flutter/material.dart';
import 'package:tractian_test/views/home/components/unit_item.dart';

class AllUnits extends StatelessWidget {
  const AllUnits({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          UnitItem(text: 'Jaguar Unit'),
          SizedBox(height: 50),
          UnitItem(text: 'Tobias Unit'),
          SizedBox(height: 50),
          UnitItem(text: 'Apex Unit'),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
