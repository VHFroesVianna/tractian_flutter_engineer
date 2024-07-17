import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:tractian_test/controllers/filter/text_filter_controller.dart';

class SearchAtivoOuLocalField extends StatelessWidget {
  final _controller = TextEditingController();

  SearchAtivoOuLocalField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TextFilterController textFilterController =
        Get.find<TextFilterController>();
    return TextFormField(
      controller: _controller,
      onChanged: (value) => textFilterController.setInput = value,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        hintText: 'Buscar Ativo ou Local',
        hintStyle: TextStyle(color: Colors.grey[400]),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
