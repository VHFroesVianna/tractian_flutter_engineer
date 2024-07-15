import 'package:flutter/material.dart';

class SearchAtivoOuLocalField extends StatelessWidget {
  final _controller = TextEditingController();

  SearchAtivoOuLocalField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
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
