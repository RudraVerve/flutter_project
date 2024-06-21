import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class db_helper {
  static final db_name = 'my_database.db';
  static final db_version = 1;
  static final t_name = 'My_table';

  static final c_id = 'Id';
  static final c_name = 'name';
  static final c_email = 'email';
  static final c_pass = 'password';
  static final c_address = 'address';
  static final c_mobile = 'mobile';
  static final c_gender = 'gender';
  static final c_facbook = 'facbook';
  static final c_insta = 'insta';
  static final c_tuiter = 'tuiter';

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
    await db.execute(
        '''
      CREATE TABLE $t_name(
        $c_id INTEGER PRIMARY KEY,
        $c_name TEXT NOT NULL,
        $c_email TEXT NOT NULL,
        $c_pass TEXT NOT NULL,
        $c_address TEXT NOT NULL,
        $c_mobile TEXT UNIQUE,
        $c_gender TEXT NOT NULL,
        $c_facbook TEXT NOT NULL,
        $c_insta TEXT NOT NULL,
        $c_tuiter TEXT NOT NULL
      )
      '''
    );
  }

  Future<int> insert(Map<String, dynamic> row) async {
    try {
      // Database db = await instance.database;
      Database db = await instance.database;
      return await db.insert(t_name, row);
    } catch (e) {
      print("Error inserting data: $e");
      return -1;
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

  Future<int> deleteDatabaseAlldata() async {
      Database db = await instance.database;
      if(t_name.isNotEmpty){
        var deletee= await db.delete(t_name);
        return deletee;
      }
      else{
        print("table is not exist");
        return -1;
      }
  }

  Future<int> deleteSpacific(int id) async {
    // Database db = await instance.database;
    Database db = await instance.database;
    try {
      if (t_name.isNotEmpty) {
        var deletedRowCount = await db.delete(
          "$t_name",
          where: "$c_id = ?",
          whereArgs: [id],
        );
        if (deletedRowCount > 0) {
          print("Deleted $deletedRowCount row(s) from $t_name where $c_id = $id");
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

  Future<int> updateSpacific(int id, String email, String name, String Address, String Mob) async {
    Database db = await instance.database;
    if(t_name.isNotEmpty){
      var update = await db.update(t_name, {"$c_name":"$name", "$c_email":"$email", "$c_address":"$Address", "$c_mobile":"$Mob"}, where: "id = ?",whereArgs: [id] );
      return update;
    }
    else{
      print("table is not exist");
      return -1;
    }
  }
}