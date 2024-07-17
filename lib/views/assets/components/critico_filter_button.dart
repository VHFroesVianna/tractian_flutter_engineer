import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:tractian_test/controllers/filter/button_filter_controller.dart';
import 'package:tractian_test/views/assets/components/filter_button.dart';

class CriticoFilterButton extends FilterButton {
  final BuildContext context;

  final ButtonFilterController _buttonFilterController =
      Get.find<ButtonFilterController>();

  CriticoFilterButton(this.context, {super.key});

  @override
  IconData get icon => PhosphorIcons.warningCircle(PhosphorIconsStyle.regular);

  @override
  String get text => 'Crítico';

  @override
  double get width => MediaQuery.sizeOf(context).width * .30;

  @override
  void filter(bool selected) =>
      _buttonFilterController.filterTree(alertFilterActive: selected);
}
