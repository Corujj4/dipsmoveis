import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:aaaaa/models/concurso.dart';
import 'package:aaaaa/models/anotacao.dart';

class ConcursoDatabase {
  static final ConcursoDatabase instance = ConcursoDatabase._init();
  static Database? _database;

  ConcursoDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('concursos.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 2,
      onCreate: _createDB,
      onUpgrade: _onUpgrade,
    );
  }

  Future _createDB(Database db, int version) async {

    await db.execute('''
      CREATE TABLE concursos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        local TEXT NOT NULL,
        dataInscricao TEXT NOT NULL,
        dataRealizacao TEXT NOT NULL,
        pagamentoEfetuado INTEGER NOT NULL
      )
    ''');


    await db.execute('''
      CREATE TABLE anotacoes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        concursoId INTEGER NOT NULL,
        texto TEXT NOT NULL,
        FOREIGN KEY (concursoId) REFERENCES concursos(id) ON DELETE CASCADE
      )
    ''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {

      await db.execute('''
        CREATE TABLE anotacoes (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          concursoId INTEGER NOT NULL,
          texto TEXT NOT NULL,
          FOREIGN KEY (concursoId) REFERENCES concursos(id) ON DELETE CASCADE
        )
      ''');
    }
  }

  Future<int> inserirConcurso(Concurso concurso) async {
    final db = await instance.database;
    return await db.insert('concursos', concurso.toMap());
  }

  Future<List<Concurso>> listarConcursos() async {
    final db = await instance.database;
    final result = await db.query('concursos');
    return result.map((map) => Concurso.fromMap(map)).toList();
  }

  Future<int> deletarConcurso(int id) async {
    final db = await instance.database;
    return await db.delete('concursos', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> atualizarConcurso(Concurso concurso) async {
    final db = await instance.database;
    return await db.update(
      'concursos',
      concurso.toMap(),
      where: 'id = ?',
      whereArgs: [concurso.id],
    );
  }

  Future<int> inserirAnotacao(Anotacao anotacao) async {
    final db = await instance.database;
    return await db.insert('anotacoes', anotacao.toMap());
  }

  Future<List<Anotacao>> listarAnotacoes(int concursoId) async {
    final db = await instance.database;
    final result = await db.query(
      'anotacoes',
      where: 'concursoId = ?',
      whereArgs: [concursoId],
    );
    return result.map((map) => Anotacao.fromMap(map)).toList();
  }

  Future<int> excluirAnotacao(int id) async {
    final db = await instance.database;
    return await db.delete('anotacoes', where: 'id = ?', whereArgs: [id]);
  }
}
