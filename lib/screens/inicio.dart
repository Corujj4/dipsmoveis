import 'package:flutter/material.dart';
import 'concursodetalhes.dart';
import 'package:aaaaa/concursodatabase.dart';
import 'package:aaaaa/models/concurso.dart';

class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({super.key});

  @override
  State<PaginaPrincipal> createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  late Future<List<Concurso>> _concursosFuture;

  @override
  void initState() {
    super.initState();
    _carregarConcursos();
  }

  void _carregarConcursos() {
    _concursosFuture = ConcursoDatabase.instance.listarConcursos();
  }

  void _refresh() {
    setState(() {
      _carregarConcursos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'Concursos',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Courier',
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: FutureBuilder<List<Concurso>>(
          future: _concursosFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: Colors.orange));
            } else if (snapshot.hasError) {
              return Center(child: Text('Erro: ${snapshot.error}', style: TextStyle(color: Colors.red)));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'Nenhum concurso cadastrado.',
                  style: TextStyle(color: Colors.white70),
                ),
              );
            }

            final concursos = snapshot.data!;
            return ListView.builder(
              itemCount: concursos.length,
              itemBuilder: (context, index) {
                final concurso = concursos[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[850],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: ListTile(
                      title: Text(
                        concurso.nome,
                        style: const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      subtitle: Text(
                        '${concurso.local} | Realização: ${concurso.dataRealizacao.toLocal().toString().split(' ')[0]}',
                        style: const TextStyle(color: Colors.white70),
                      ),
                      trailing: Icon(
                        concurso.pagamentoEfetuado ? Icons.check_circle : Icons.cancel,
                        color: concurso.pagamentoEfetuado ? Colors.green : Colors.red,
                      ),
                      onTap: () {



                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () async {

          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const DetalhesConcurso()),
          );
          _refresh();
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
