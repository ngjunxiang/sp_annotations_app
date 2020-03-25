import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../utilities/geolocation_table_helper.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initialiseDatabase();
    }
    return _database;
  }

  Future<Database> initialiseDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'records.db';

    // Open/create the database at a given path
    var recordsDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return recordsDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(GeolocationTableHelper().createQuery);
  }
}
