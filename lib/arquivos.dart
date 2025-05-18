    import 'package:flutter/material.dart';



    class arquivos extends StatelessWidget {
      const arquivos ({super.key});

      @override
    @override
    Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.black,
    appBar: AppBar(
    backgroundColor: Colors.black,
    centerTitle: true,
    title: const Text(
    'Arquivos anexados',
    style: TextStyle(
    color: Colors.white,
    fontFamily: 'Courier',
    fontSize: 40,
    fontWeight: FontWeight.bold,
    ),
    ),
    ),

      body : Center (
        child: ElevatedButton.icon(
        onPressed: () {

        },

        icon: const Icon(Icons.attach_file, color: Colors.black),
        label: const Text('Arquivos Anexos', style: TextStyle(color: Colors.black)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
        ),
      ),
        )
    );
    }
    }
