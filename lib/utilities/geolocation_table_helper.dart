import 'package:sp_annotations_app/utilities/database_helper.dart';
import 'package:sqflite/sqflite.dart';

import '../models/geolocation.dart';

class GeolocationTableHelper {
  static DatabaseHelper _databaseHelper = DatabaseHelper();
  String geolocationsTable = 'geolocation_table';
  String colId = 'id';
  String colTimestamp = 'timestamp';
  String colTag = 'tag';
  String colLatitude = 'latitude';
  String colLongitude = 'longitude';
  String colAccuracy = 'accuracy';
  String colAltitude = 'altitude';
  String colSpeed = 'speed';

  String get createQuery {
    return 'CREATE TABLE $geolocationsTable($colId TEXT PRIMARY KEY, $colTimestamp TEXT, $colTag TEXT, '
        '$colLatitude TEXT, $colLongitude TEXT, $colAccuracy TEXT, $colAltitude TEXT, $colSpeed TEXT)';
  }

  Future<List<Map<String, dynamic>>> getGeolocationsMapList() async {
    Database db = await _databaseHelper.database;

    var result =
        await db.query(geolocationsTable, orderBy: '$colTimestamp ASC');
    return result;
  }

  Future<int> insertGeolocation(Geolocation geolocation) async {
    Database db = await _databaseHelper.database;
    var result = await db.insert(geolocationsTable, geolocation.toMap());
    return result;
  }

//  Future<int> updateGeolocation(Geolocation geolocation) async {
//    var db = await _databaseHelper.database;
//    var result = await db.update(geolocationsTable, geolocation.toMap(),
//        where: '$colId = ?', whereArgs: [geolocation.id]);
//    return result;
//  }

//  Future<int> deleteGeolocation(int id) async {
//    var db = await _databaseHelper.database;
//    int result =
//        await db.rawDelete('DELETE FROM $geolocationsTable WHERE $colId = $id');
//    return result;
//  }

  Future<int> deleteAllGeolocations() async {
    var db = await _databaseHelper.database;
    int result = await db.rawDelete('DELETE * FROM $geolocationsTable');
    return result;
  }

//  Future<int> getCount() async {
//    Database db = await _databaseHelper.database;
//    List<Map<String, dynamic>> x =
//        await db.rawQuery('SELECT COUNT (*) from $geolocationsTable');
//    int result = Sqflite.firstIntValue(x);
//    return result;
//  }

  Future<List<Geolocation>> getGeolocationsList() async {
    var geolocationsMapList =
        await getGeolocationsMapList(); // Get 'Map List' from database
    int count = geolocationsMapList
        .length; // Count the number of map entries in db table

    List<Geolocation> geolocationsList = List<Geolocation>();
    for (int i = 0; i < count; i++) {
      geolocationsList.add(Geolocation.fromMapObject(geolocationsMapList[i]));
    }

    return geolocationsList;
  }
}
