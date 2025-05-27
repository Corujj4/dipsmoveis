import 'package:flutter/material.dart';
import 'inicio.dart';
import 'package:aaaaa/concursodatabase.dart'
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await concursodatabase().database;

  runApp(const MinhaWidget());
}

class MinhaWidget extends StatelessWidget {
  const MinhaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: PaginaPrincipal(),
    );
  }
}