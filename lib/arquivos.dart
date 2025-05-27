    import 'package:flutter/material.dart';



    class arquivos extends StatelessWidget {
      const arquivos ({super.key});

      @override
    @override
    Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.black,
    appBar: AppBar(
        backgroundColor: Colors.grey[900],
        flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.grey[850]!, Colors.grey[900]!],
                ),
            ),
        ),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
            onPressed: () => Navigator.pop(context),
        ),
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
