import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class SQLHelper {
  //create database
  static Future<Database> initializeDatabase() async {
    final sqlDBpath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(sqlDBpath, "place.db"),
        onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE user_places(id TEXT PRIMARY KEY,title TEXT,image TEXT,loc_lat REAL,loc_lng REAL,address TEXT)");
    }, version: 1);
  }

//inserting data to db

  static Future<void> insert(
      String tableName, Map<String, dynamic> data) async {
//
    final db = await SQLHelper.initializeDatabase();

    await db.insert(tableName, data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

//fetching data from db

  static Future<List<Map<String, dynamic>>> fetchData(String tableName) async {
    final db = await SQLHelper.initializeDatabase();
    return db.query(tableName);
  }

  ////////////
}
