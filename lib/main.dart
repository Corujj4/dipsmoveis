import 'package:flutter/material.dart';
import 'inicio.dart';
void main() {
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

