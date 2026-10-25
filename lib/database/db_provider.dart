import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/calculation.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDB();

    return _database!;
  }

  Future<Database> _initDB() async {
    final directory = await getDatabasesPath();
    final path = join(directory, 'calculations.db');

    final exists = await databaseExists(path);

    if (exists) {
      return await openDatabase(
        path,
        version: 1,
      );
    }

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(
    Database db,
    int version,
  ) async {
    await db.execute('''
      CREATE TABLE calculations (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        a INTEGER NOT NULL,
        b INTEGER NOT NULL,
        result INTEGER NOT NULL,
        date TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertCalculation(
    Calculation calculation,
  ) async {
    final db = await database;

    return await db.insert(
      'calculations',
      calculation.toMap(),
    );
  }

  Future<List<Calculation>> getAllCalculations() async {
    final db = await database;

    final data = await db.query(
      'calculations',
      orderBy: 'id DESC',
    );

    return data
        .map((item) => Calculation.fromMap(item))
        .toList();
  }

  Future<int> deleteCalculation(int id) async {
    final db = await database;

    return await db.delete(
      'calculations',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}