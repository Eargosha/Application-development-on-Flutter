import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

// Класс БД для приложения на паттерне "Одиночка"
class DatabaseProvider {
  // Конструктор
  DatabaseProvider._init();

  // Статический - будет только один экземпляр
  // Provider - "прослойка" между приложением и БД
  static final DatabaseProvider db = DatabaseProvider._init();

  // Сама БД
  static Database? _database;

  // Геттер БД, если есть - возвращает ее, а если нет - инициализирует
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('calculations.db');
    return _database!;
  }

  // Инициализация БД
  Future<Database> _initDB(String filePath) async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + filePath;
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // Создание БД
  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Calculations (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        initialSpeed REAL NOT NULL,
        finalSpeed REAL NOT NULL,
        time REAL NOT NULL,
        acceleration REAL NOT NULL,
        timestamp TEXT NOT NULL
      )
    ''');
  }

  // Добавляет обьект вычислений в БД и возвращает id добавленного, если все пошло плохо, то вернет 0
  Future<int> addCalculation(Map<String, dynamic> calculation) async {
    Database db = await database;
    return await db.insert('Calculations', calculation);
  }

  // Возвращает все обьекты вычислений из БД
  Future<List<Map<String, dynamic>>> getAllCalculations() async {
    Database db = await database;
    final List<Map<String, dynamic>> data = await db.query('Calculations');
    return data;
  }

  // Возвращает все обьекты вычислений из БД по совпавшему id
  Future<List<Map<String, dynamic>>> getCalculationById(int id) async {
    Database db = await database;
    final List<Map<String, dynamic>> data = await db.query(
      'Calculations',
      where: "id = ?",
      whereArgs: [id],
    );
    return data;
  }

  // Удаляет обьект Calculation с БД, возвращает номер строки БД, где удалили запись
  Future<int> deleteCalculation(int id) async {
    Database db = await database;
    return await db.delete("Calculations", where: "id = ?", whereArgs: [id]);
  }

  // Обновляет обьект Calculation с БД, возвращает номер произведенных изменений
  Future<int> updateCalculation(
    Map<String, dynamic> calculation,
    int id,
  ) async {
    Database db = await database;
    return await db.update(
      "Calculations",
      calculation,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  // Удаление всех записей из БД
  Future<void> clearAllCalculations() async {
    Database db = await database;
    await db.delete("Calculations");
  }

  // Закрытие соединения с БД
  Future<void> close() async {
    final db = await database;
    db.close();
  }
}
