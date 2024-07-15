import 'package:flutter/material.dart';
import 'package:tractian_test/views/assets/components/critico_filter_button.dart';
import 'package:tractian_test/views/assets/components/sensor_de_energia_filter_button.dart';

class ButtonsFilterRow extends StatelessWidget {
  const ButtonsFilterRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SensorDeEnergiaFilterButton(context),
        CriticoFilterButton(context),
      ],
    );
  }
}
