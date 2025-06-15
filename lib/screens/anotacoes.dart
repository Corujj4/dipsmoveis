import 'package:flutter/material.dart';
import 'package:aaaaa/concursodatabase.dart';
import 'package:aaaaa/models/anotacao.dart';

class TelaAnotacoes extends StatefulWidget {
  final int concursoId;

  const TelaAnotacoes({super.key, required this.concursoId});

  @override
  State<TelaAnotacoes> createState() => _TelaAnotacoesState();
}

class _TelaAnotacoesState extends State<TelaAnotacoes> {
  final TextEditingController _anotacoesController = TextEditingController();
  late Future<List<Anotacao>> _anotacoesFuture;

  @override
  void initState() {
    super.initState();
    _carregarAnotacoes();
  }

  void _carregarAnotacoes() {
    _anotacoesFuture = ConcursoDatabase.instance.listarAnotacoes(widget.concursoId);
  }

  Future<void> _salvarAnotacao() async {
    final texto = _anotacoesController.text.trim();
    if (texto.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Digite uma anotação.'), backgroundColor: Colors.red),
      );
      return;
    }

    final novaAnotacao = Anotacao(concursoId: widget.concursoId, texto: texto);
    await ConcursoDatabase.instance.inserirAnotacao(novaAnotacao);
    _anotacoesController.clear();
    _carregarAnotacoes();
    setState(() {});
  }

  Future<void> _excluirAnotacao(int id) async {
    await ConcursoDatabase.instance.excluirAnotacao(id);
    _carregarAnotacoes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        centerTitle: true,
        title: const Text(
          'ANOTAÇÕES',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Courier',
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _anotacoesController,
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Digite sua anotação...',
                hintStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.grey[800],
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _salvarAnotacao,
              icon: const Icon(Icons.save, color: Colors.black),
              label: const Text('Salvar', style: TextStyle(color: Colors.black)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            ),
            const SizedBox(height: 20),
            const Divider(color: Colors.white24),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Anotações salvas:', style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<List<Anotacao>>(
                future: _anotacoesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(color: Colors.orange));
                  } else if (snapshot.hasError) {
                    return Text('Erro: ${snapshot.error}', style: const TextStyle(color: Colors.red));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('Nenhuma anotação ainda.', style: TextStyle(color: Colors.white70));
                  }

                  final anotacoes = snapshot.data!;
                  return ListView.separated(
                    itemCount: anotacoes.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final anotacao = anotacoes[index];
                      return Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[850],
                          border: Border.all(color: Colors.white24),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                anotacao.texto,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.redAccent),
                              onPressed: () => _excluirAnotacao(anotacao.id!),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
