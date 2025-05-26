import 'package:flutter/material.dart';


class formulario extends StatefulWidget {
  const formulario({super.key});

  @override
  formularioState createState() {
    return formularioState();
  }
}

class formularioState extends State<formulario> {
 final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: const Column(
          children: <Widget>[
            TextF

          ],
        )
    );
  }
}
