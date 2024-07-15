import 'package:flutter/material.dart';
import 'components/all_units.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(23, 25, 45, 1),
        title: Center(
          child: SizedBox(
              width: 200, child: Image.asset('assets/images/logo.png')),
        ),
      ),
      body: const Center(
        child: AllUnits(),
      ),
    );
  }
}
