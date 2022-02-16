import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:expenses/models/transaction.dart';

class DB {
  DB._();
  static final DB instance = DB._();
  static Database? _database;

  Future<Database> get database async {
    return _database ??= await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'transactions.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE transactions(
          id REAL PRIMARY KEY,
          title TEXT,
          value REAL,
          date INTEGER
      );
      ''');
  }

  Future<void> addList(Transactions transactions) async {
    final db = await instance.database;
    await db.insert(
      'transactions',
      transactions.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Transactions>> getList() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> queryResult = await db.query(
      'transactions',
      orderBy: 'date DESC',
    );
    return queryResult.map((e) {
      return Transactions.fromMap(e);
    }).toList();
  }

  Future<void> removeList(double id) async {
    final db = await instance.database;
    await db.delete(
      'transactions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
