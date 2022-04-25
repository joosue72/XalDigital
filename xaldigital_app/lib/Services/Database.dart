import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:xaldigital_app/Model/Search_history.dart';




class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  //Si no existe esta variable, creara una nueva
  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "historial.db");
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db
        .execute('CREATE TABLE Historial (id INTEGER PRIMARY KEY, name TEXT)');
  }

  Future<List<HistoySearch>> getHistorial() async {
    Database db = await instance.database;
    var historial = await db.query("Historial", orderBy: "name");
    List<HistoySearch> hisorialList = historial.isNotEmpty
  ? historial.map((c) => HistoySearch.fromMap(c)).toList() :[];
    return hisorialList;
  }

  Future<int> add(HistoySearch histoySearch) async {
    Database db = await instance.database;
    return await db.insert("Historial", histoySearch.toMap());
  }

    Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete('Historial', where: 'id = ?', whereArgs: [id]);
  }
}
