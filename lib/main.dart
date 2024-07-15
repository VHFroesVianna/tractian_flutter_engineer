import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:tractian_test/views/assets/assets_page.dart';
import 'views/home/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (_) => const HomePage(),
        '/assets': (_) => const AssetsPage(),
      },
      theme: ThemeData(useMaterial3: true),
      home: const HomePage(),
    );
  }
}
