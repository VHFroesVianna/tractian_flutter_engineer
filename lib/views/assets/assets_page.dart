import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractian_test/views/assets/components/locations_and_assets_tree.dart';
import 'components/buttons_filter_row.dart';
import 'components/search_ativo_ou_local_field.dart';

class AssetsPage extends StatelessWidget {
  final String? unitName;
  const AssetsPage({super.key, this.unitName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(23, 25, 45, 1),
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
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
            Expanded(
              child: LocationsAndAssetsTree(unitName: unitName),
            )
          ],
        ),
      ),
    );
  }
}
