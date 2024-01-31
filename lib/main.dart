import 'package:bio_catalogo/pages/home.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const MainApp());
}
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  static const String title = 'Bio Catálogo';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 0,
        ),
      ),
      home: const HomePage(),
    );
  }
}
