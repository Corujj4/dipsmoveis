import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:aaaaa/models/concurso.dart';

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

    return await openDatabase(path, version: 1, onCreate: _createDB);
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

}
