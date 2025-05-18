import 'package:aaaaa/anotacoes.dart';
import 'package:aaaaa/arquivos.dart';
import 'package:flutter/material.dart';


class DetalhesConcurso extends StatefulWidget {
  const DetalhesConcurso({super.key});

  @override
  State<DetalhesConcurso> createState() => _DetalhesConcursoState();
}

class _DetalhesConcursoState extends State<DetalhesConcurso> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _localController = TextEditingController();

  DateTime? _dataInscricao;
  DateTime? _dataRealizacao;
  bool _pagamentoEfetuado = false;

  Future<void> _selecionarData(BuildContext context, Function(DateTime) onDateSelected) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'DETALHES DO CONCURSO',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Courier',
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [


            TextField(
              controller: _nomeController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Nome do Concurso',
                labelStyle: const TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.orange),
                ),
              ),
            ),
            const SizedBox(height: 20),


            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Data Final de Inscrição',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () => _selecionarData(context, (data) {
                    setState(() => _dataInscricao = data);
                  }),
                  child: Row(
                    children: [
                      Text(
                        _dataInscricao != null
                            ? '${_dataInscricao!.day}/${_dataInscricao!.month}/${_dataInscricao!.year}'
                            : 'Selecionar',
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(width: 5),
                      const Icon(Icons.calendar_today, color: Colors.white),
                    ],
                  ),
                ),
              ],
            ),


            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Data de Realização',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () => _selecionarData(context, (data) {
                    setState(() => _dataRealizacao = data);
                  }),
                  child: Row(
                    children: [
                      Text(
                        _dataRealizacao != null
                            ? '${_dataRealizacao!.day}/${_dataRealizacao!.month}/${_dataRealizacao!.year}'
                            : 'Selecionar',
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(width: 5),
                      const Icon(Icons.calendar_today, color: Colors.white),
                    ],
                  ),
                ),
              ],
            ),


            Row(
              children: [
                Checkbox(
                  value: _pagamentoEfetuado,
                  onChanged: (value) {
                    setState(() => _pagamentoEfetuado = value ?? false);
                  },
                  checkColor: Colors.black,
                  activeColor: Colors.white,
                ),
                const Text('Pagamento Efetuado', style: TextStyle(color: Colors.white)),
              ],
            ),


            const SizedBox(height: 10),
            const Text('Local de Prova', style: TextStyle(color: Colors.white)),
            const SizedBox(height: 5),
            TextField(
              controller: _localController,
              maxLines: 3,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Ex: Rua dos Bandeiras exemplo 1',
                hintStyle: const TextStyle(color: Colors.white70),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.orange),
                ),
              ),
            ),

            const SizedBox(height: 20),


            OutlinedButton.icon(
              onPressed: () {

                Navigator.push(context, MaterialPageRoute(builder: (_) => const TelaAnotacoes()));
              },
              icon: const Icon(Icons.edit, color: Colors.white),
              label: const Text('Anotações', style: TextStyle(color: Colors.white)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.white),
              ),
            ),

            const SizedBox(height: 20),


            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const arquivos()));
              },
              icon: const Icon(Icons.attach_file, color: Colors.black),
              label: const Text('Arquivos Anexos', style: TextStyle(color: Colors.black)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
            ),

            const SizedBox(height: 20),


            ElevatedButton.icon(
              onPressed: () {

              },
              icon: const Icon(Icons.delete, color: Colors.white),
              label: const Text('Excluir Concurso', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[800],
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
