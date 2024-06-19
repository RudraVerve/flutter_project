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
        $c_mobile TEXT NOT NULL,
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

  Future<void> deleteDatabaseFile() async {
    try {
      if (_dbPath != null) {
        File dbFile = File(_dbPath!);
        if (await dbFile.exists()) {
          await dbFile.delete();
          _database = null; // Reset the _database instance to ensure it’s recreated
          print("Database deleted successfully");
        } else {
          print("Database does not exist");
        }
      } else {
        print("Database path is null");
      }
    } catch (e) {
      print("Error deleting database: $e");
    }
  }
}