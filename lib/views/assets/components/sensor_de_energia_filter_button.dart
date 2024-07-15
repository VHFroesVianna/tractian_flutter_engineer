import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:tractian_test/views/assets/components/filter_button.dart';

class SensorDeEnergiaFilterButton extends FilterButton {
  final BuildContext context;

  const SensorDeEnergiaFilterButton(this.context, {super.key});

  @override
  IconData get icon => PhosphorIcons.lightning(PhosphorIconsStyle.regular);

  @override
  String get text => 'Sensor de Energia';

  @override
  double get width => MediaQuery.sizeOf(context).width * .5;
}
