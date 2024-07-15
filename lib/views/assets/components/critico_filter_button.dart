import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:tractian_test/views/assets/components/filter_button.dart';

class CriticoFilterButton extends FilterButton {
  final BuildContext context;

  const CriticoFilterButton(this.context, {super.key});

  @override
  IconData get icon => PhosphorIcons.warningCircle(PhosphorIconsStyle.regular);

  @override
  String get text => 'Crítico';

  @override
  double get width => MediaQuery.sizeOf(context).width * .36;
}
