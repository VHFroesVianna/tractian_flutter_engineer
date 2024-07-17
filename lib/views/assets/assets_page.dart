import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractian_test/controllers/data/data_controller.dart';
import 'package:tractian_test/controllers/filter/text_filter_controller.dart';
import 'package:tractian_test/theme/app_colors.dart';
import 'package:tractian_test/views/assets/components/locations_and_assets_tree.dart';
import 'components/buttons_filter_row.dart';
import 'components/search_ativo_ou_local_field.dart';

class AssetsPage extends StatelessWidget {
  final String? unitName;
  const AssetsPage({super.key, this.unitName});

  @override
  Widget build(BuildContext context) {
    final path = unitName?.split(' ').first.trim().toLowerCase();
    final DataController dataController = Get.put(DataController(
      locationsPath: 'assets/json/$path/locations.json',
      assetsPath: 'assets/json/$path/assets.json',
    ));
    Get.lazyPut(() => TextFilterController(dataController: dataController));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.background,
            )),
        title: const Text(
          'Assets',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SearchAtivoOuLocalField(),
            const SizedBox(height: 15),
            const ButtonsFilterRow(),
            const SizedBox(height: 15),
            Divider(color: Colors.grey[300], thickness: 2),
            const Expanded(child: LocationsAndAssetsTree()),
          ],
        ),
      ),
    );
  }
}
