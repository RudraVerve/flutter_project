import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'insert_data.dart';

class db_helper {
  static final db_name = 'Id_db.db';
  static final db_version = 1;
  static final t_name = 'Student_info';

  static final s_roll = 'roll';
  static final s_info = 'info';

  static Database? _database;
  static String? _dbPath;

  db_helper._privateConstructor();
  static final db_helper instance = db_helper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    _dbPath = join(documentDirectory.path, db_name);
    return await openDatabase(_dbPath!, version: db_version, onCreate: _oncreate);
  }

  Future _oncreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $t_name(
        $s_roll TEXT PRIMARY KEY,
        $s_info TEXT
      )
    ''');
  }

  Future<int> insert(insert_data data, String roll) async {
    try {
      Database db = await instance.database;
      Map<String, dynamic> row = {
        s_info: data.toJsonString(),
        s_roll:roll
      };
      return await db.insert(t_name, row);
    } catch (e) {
      print("Error inserting data: $e");
      return -1;
    }
  }

  Future<List<Map<String, dynamic>>> querySpacific(String roll) async {
    try {
      Database db = await instance.database;
      List<Map<String, dynamic>> results = await db.query(
        "$t_name",
        where: "$s_roll = ?",
        whereArgs: [roll],
      );
      return results;
    } catch (e) {
      print("Error querying data: $e");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> queryall() async {
    try {
      Database db = await instance.database;
      return await db.query(t_name);
    } catch (e) {
      print("Error querying data: $e");
      return [];
    }
  }

  Future<int> deleteSpacific(String id) async {
    Database db = await instance.database;
    try {
      if (t_name.isNotEmpty) {
        var deletedRowCount = await db.delete(
          "$t_name",
          where: "$s_roll = ?",
          whereArgs: [id],
        );
        if (deletedRowCount > 0) {
          print("Deleted $deletedRowCount row(s) from $t_name where $s_roll = $id");
        } else {
          print("No rows deleted. No match for id = $id.");
        }

        return deletedRowCount;
      } else {
        print("Table name is empty. Unable to delete.");
        return -1;
      }
    } catch (e) {
      print("Error deleting specific row: $e");
      return -1;
    }
  }

}
