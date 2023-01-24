import 'package:hangman/storagemodel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String tablename = 'scores';

class dbHelper {
  static final dbHelper instance = dbHelper._init();
  static Database? _database;
  dbHelper._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDB('score.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createdb);
  }

  Future _createdb(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $tablename(id INTEGER NOT NULL PRIMARY KEY, score INTEGER NOT NULL, date TEXT NOT NULL)',
    );
  }

  Future<void> create(scoremodel scor) async {
    final db = await instance.database;
    await db.insert(tablename, scor.toMap());
  }

  Future<List<scoremodel>> readAllTodo() async {
    final db = await instance.database;
    final order = 'score DESC, date ASC';
    final result = await db.query(tablename, orderBy: order);
    return result.map((ele) => scoremodel.fromMap(ele)).toList();
  }

  Future<void> delete(int id) async {
    final db = await instance.database;
    await db.delete(
      tablename,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
