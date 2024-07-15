import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:tractian_test/views/assets/assets_page.dart';

class UnitItem extends StatelessWidget {
  final String text;

  const UnitItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: () async => await Get.to(() => AssetsPage(unitName: text)),
      child: Container(
        padding: const EdgeInsets.only(left: 20),
        width: size.width * .75,
        height: size.height * .15,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(33, 136, 255, 1),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PhosphorIcon(
              PhosphorIcons.diamondsFour(),
              color: Colors.white,
              size: 30,
            ),
            const SizedBox(height: 10, width: 10),
            Text(
              text,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
