import 'package:bio_catalogo/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await requestPermissions();
  runApp(const MainApp());
}

Future<void> requestPermissions() async {
  // Solicita permissão de câmera
  await Permission.camera.request();
  // Solicita permissão de leitura de dados
  await Permission.storage.request();
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

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
