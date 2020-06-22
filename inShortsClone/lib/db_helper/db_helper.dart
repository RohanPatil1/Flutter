import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
//  static final String columnAuthor = 'author';
  static final String tableName = 'inshorts';
  static final String columnTitle = 'title';
  static final String columnDescrip = 'descrip';
  static final String columnUrl = 'url';
  static final String columnUrlToImage = 'urlToimage';
  static final String columnPublishedAt = 'publishedAt';
  static final String columnContent = 'content';
  static final String columnName = 'name';
  static final String columnId = 'id';

  static final _databaseName = "inShorts.db";
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
                $columnContent TEXT,
                $columnDescrip TEXT NOT NULL,
                $columnName TEXT NOT NULL,
                $columnPublishedAt TEXT NOT NULL,
                $columnTitle TEXT NOT NULL,
                $columnUrl TEXT NOT NULL,
                $columnUrlToImage TEXT NOT NULL
              )
              ''');
  }

  Future<int> insertNews(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryNews() async {
    Database db = await instance.database;
    return await db.query(tableName);
  }

  Future<int> deleteNews(int id) async {
    Database db = await instance.database;
    return await db.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}
