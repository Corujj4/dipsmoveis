class Anotacao {
  final int? id;
  final int concursoId;
  final String texto;

  Anotacao({
    this.id,
    required this.concursoId,
    required this.texto,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'concursoId': concursoId,
      'texto': texto,
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  factory Anotacao.fromMap(Map<String, dynamic> map) {
    return Anotacao(
      id: map['id'],
      concursoId: map['concursoId'],
      texto: map['texto'],
    );
  }
}
