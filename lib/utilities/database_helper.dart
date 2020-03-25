import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/record.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  String recordsTable = 'records_table';
  String colId = 'id';
  String colTimestamp = 'timestamp';
  String colTag = 'tag';
  String colAnnotation = 'annotation';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper
          ._createInstance();
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
    await db.execute(
        'CREATE TABLE $recordsTable($colId TEXT PRIMARY KEY, $colTimestamp TEXT, '
        '$colTag TEXT, $colAnnotation TEXT)');
  }

  Future<List<Map<String, dynamic>>> getRecordsMapList() async {
    Database db = await this.database;

    var result = await db.query(recordsTable, orderBy: '$colTimestamp ASC');
    return result;
  }

  Future<int> insertRecord(Record record) async {
    Database db = await this.database;
    var result = await db.insert(recordsTable, record.toMap());
    return result;
  }

  Future<int> updateRecord(Record record) async {
    var db = await this.database;
    var result = await db.update(recordsTable, record.toMap(),
        where: '$colId = ?', whereArgs: [record.id]);
    return result;
  }

  Future<int> deleteRecord(int id) async {
    var db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $recordsTable WHERE $colId = $id');
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $recordsTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Record>> getRecordsList() async {
    var recordsMapList =
        await getRecordsMapList(); // Get 'Map List' from database
    int count =
        recordsMapList.length; // Count the number of map entries in db table

    List<Record> recordsList = List<Record>();
    for (int i = 0; i < count; i++) {
      recordsList.add(Record.fromMapObject(recordsMapList[i]));
    }

    return recordsList;
  }
}
