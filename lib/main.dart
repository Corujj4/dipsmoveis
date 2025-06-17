import 'package:aaaaa/services/image_picker_widget.dart';
import 'package:flutter/material.dart';
import 'screens/inicio.dart';
import 'package:aaaaa/concursodatabase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ConcursoDatabase.instance.database;

  runApp(const MinhaWidget());
}

class MinhaWidget extends StatelessWidget {
  const MinhaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Concursos',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ImagePickerWidget(),
    );
  }
}
