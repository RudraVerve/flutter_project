import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'insert_data.dart';

class db_helper {
  static final db_name = 'Id_db.db';
  static final db_version = 1;
  static final t_name = 'Student_info';

  //COLUMNS
  static final s_Id = 'id';
  static final s_info = 'info';
  static final columnImage = 'image';
  static final columnImageQr = 'QrImage';

  static Database? _database;
  static String? _dbPath;

  db_helper._privateConstructor(); //use for no conflict. single instance is create.
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
        $s_Id TEXT PRIMARY KEY,
        $columnImage BLOB NOT NULL,
        $columnImageQr BLOB NOT NULL,
        $s_info TEXT
      )
    ''');
  }

  Future<int> insert(insert_data data, String Id, Uint8List image, Uint8List imageQr) async {
    try {
      Database db = await instance.database;
      Map<String, dynamic> row = {
        s_info: data.toJsonString(),
        s_Id:Id,
        columnImage: image,
        columnImageQr:imageQr
      };
      return await db.insert(t_name, row);
    } catch (e) {
      print("Error inserting data: $e");
      return -1;
    }
  }

  Future<List<Map<String, dynamic>>> querySpacific(String Id) async {
    try {
      Database db = await instance.database;
      List<Map<String, dynamic>> results = await db.query(
        "$t_name",
        where: "$s_Id = ?",
        whereArgs: [Id],
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
          where: "$s_Id = ?",
          whereArgs: [id],
        );
        if (deletedRowCount > 0) {
          print("Deleted $deletedRowCount row(s) from $t_name where $s_Id = $id");
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

  Future<Uint8List?> getImage(String id) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(t_name,
        columns: [columnImage],
        where: '$s_Id = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return maps.first[columnImage];
    }
    return null;
  }

  Future<Uint8List?> getImageQr(String id) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(t_name,
        columns: [columnImageQr],
        where: '$s_Id = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return maps.first[columnImageQr];
    }
    return null;
  }

  Future<int> updateSpacific(String Id, insert_data obj) async {
    Database db = await instance.database;
    if(t_name.isNotEmpty){
      var update = await db.update(t_name, {"$s_Id":"$Id", "$s_info":obj.toJsonString()}, where: "$s_Id = ?",whereArgs: [Id] );
      return update;
    }
    else{
      print("table is not exist");
      return -1;
    }
  }

}
