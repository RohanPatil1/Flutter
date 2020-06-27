import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final String tableName = 'posts';
  static final String columnLike = "like";

  static final String columnId = 'id';
  static final String columnImgUrl = 'imgUrl';

  static final _databaseName = "posts.db";
  static final _databaseVersion = 1;

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    print("==========INITAITING DATABSE===================");
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    print("==========OnCREATE DATABSE===================");
    await db.execute('''
              CREATE TABLE $tableName (
                $columnId INTEGER PRIMARY KEY,
                $columnLike TEXT,
                $columnImgUrl TEXT
                  )
              ''');
  }

  Future<int> insertPost(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryPosts() async {
    Database db = await instance.database;
    return await db.query(tableName);
  }

  //To Update Like Status
  Future<int> updatePost(Map<String, dynamic> row, int id) async {
    Database db = await instance.database;

    return await db
        .update(tableName, row, where: '$columnId = ?', whereArgs: [id]);
  }
}
