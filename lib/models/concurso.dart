class Concurso {
  int? id;
  final String nome;
  final String local;
  final DateTime dataInscricao;
  final DateTime dataRealizacao;
  final bool pagamentoEfetuado;

  Concurso({
    this.id,
    required this.nome,
    required this.local,
    required this.dataInscricao,
    required this.dataRealizacao,
    this.pagamentoEfetuado = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'local': local,
      'dataInscricao': dataInscricao.toIso8601String(),
      'dataRealizacao': dataRealizacao.toIso8601String(),
      'pagamentoEfetuado': pagamentoEfetuado ? 1 : 0,
    };
  }

  factory Concurso.fromMap(Map<String, dynamic> map) {
    return Concurso(
      id: map['id'],
      nome: map['nome'],
      local: map['local'],
      dataInscricao: DateTime.parse(map['dataInscricao']),
      dataRealizacao: DateTime.parse(map['dataRealizacao']),
      pagamentoEfetuado: map['pagamentoEfetuado'] == 1,
    );
  }
}