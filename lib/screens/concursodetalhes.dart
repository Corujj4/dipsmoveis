import 'package:flutter/material.dart';
import 'package:aaaaa/concursodatabase.dart';
import 'package:aaaaa/models/concurso.dart';
import 'package:aaaaa/screens/anotacoes.dart';


class DetalhesConcurso extends StatefulWidget {
  final Concurso? concurso;

  const DetalhesConcurso({super.key, this.concurso});

  @override
  State<DetalhesConcurso> createState() => _DetalhesConcursoState();
}

class _DetalhesConcursoState extends State<DetalhesConcurso> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _localController = TextEditingController();

  DateTime? _dataInscricao;
  DateTime? _dataRealizacao;
  bool _pagamentoEfetuado = false;

  @override
  void initState() {
    super.initState();
    if (widget.concurso != null) {
      _nomeController.text = widget.concurso!.nome;
      _localController.text = widget.concurso!.local;
      _dataInscricao = widget.concurso!.dataInscricao;
      _dataRealizacao = widget.concurso!.dataRealizacao;
      _pagamentoEfetuado = widget.concurso!.pagamentoEfetuado;
    }
  }

  String _formatarData(DateTime? data) {
    return data != null ? '${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year}' : 'Selecionar';
  }

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

  bool _camposValidos() {
    return _nomeController.text.isNotEmpty &&
        _localController.text.isNotEmpty &&
        _dataInscricao != null &&
        _dataRealizacao != null;
  }

  void _salvarConcurso() async {
    if (!_camposValidos()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha todos os campos obrigatórios!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final concursoParaSalvar = Concurso(
      id: widget.concurso?.id,
      nome: _nomeController.text,
      local: _localController.text,
      dataInscricao: _dataInscricao!,
      dataRealizacao: _dataRealizacao!,
      pagamentoEfetuado: _pagamentoEfetuado,
    );

    if (widget.concurso == null) {
      await ConcursoDatabase.instance.inserirConcurso(concursoParaSalvar);
    } else {
      await ConcursoDatabase.instance.atualizarConcurso(concursoParaSalvar);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(widget.concurso == null ? 'Concurso salvo com sucesso!' : 'Concurso atualizado com sucesso!'),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pop(context);
  }

  void _excluirConcurso() async {
    if (widget.concurso != null) {
      await ConcursoDatabase.instance.deletarConcurso(widget.concurso!.id!);
      Navigator.pop(context);
    }
  }

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
          'DETALHES DO CONCURSO',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Courier',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        toolbarHeight: 80,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Nome do Concurso *',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Expanded(
                  child: Text('Data Final de Inscrição *', style: TextStyle(color: Colors.white)),
                ),
                TextButton(
                  onPressed: () => _selecionarData(context, (data) => setState(() => _dataInscricao = data)),
                  child: Row(
                    children: [
                      Text(_formatarData(_dataInscricao), style: const TextStyle(color: Colors.white)),
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
                  child: Text('Data de Realização *', style: TextStyle(color: Colors.white)),
                ),
                TextButton(
                  onPressed: () => _selecionarData(context, (data) => setState(() => _dataRealizacao = data)),
                  child: Row(
                    children: [
                      Text(_formatarData(_dataRealizacao), style: const TextStyle(color: Colors.white)),
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
                  onChanged: (value) => setState(() => _pagamentoEfetuado = value ?? false),
                  checkColor: Colors.black,
                  activeColor: Colors.white,
                ),
                const Text('Pagamento Efetuado', style: TextStyle(color: Colors.white)),
              ],
            ),
            const SizedBox(height: 10),
            const Text('Local de Prova *', style: TextStyle(color: Colors.white)),
            const SizedBox(height: 5),
            TextField(
              controller: _localController,
              maxLines: 3,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Ex: Rua dos Bandeiras exemplo 1',
                hintStyle: TextStyle(color: Colors.white70),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
              ),
            ),
            const SizedBox(height: 20),
            if (widget.concurso != null)
              OutlinedButton.icon(
              onPressed: () {
                if (widget.concurso?.id != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TelaAnotacoes(concursoId: widget.concurso!.id!),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Salve o concurso antes de adicionar anotações.'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              icon: const Icon(Icons.edit, color: Colors.white),
              label: const Text('Anotações', style: TextStyle(color: Colors.white)),
              style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.white)),
            ),
            const SizedBox(height: 20),



           /* ElevatedButton.icon(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const arquivos())),
              icon: const Icon(Icons.attach_file, color: Colors.black),
              label: const Text('Arquivos Anexos', style: TextStyle(color: Colors.black)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            ),
            const SizedBox(height: 20),*/




            ElevatedButton.icon(
              onPressed: _salvarConcurso,
              icon: const Icon(Icons.save, color: Colors.white),
              label: const Text('Salvar', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[800],
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
            const SizedBox(height: 20),
            if (widget.concurso != null)
              ElevatedButton.icon(
                onPressed: _excluirConcurso,
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
