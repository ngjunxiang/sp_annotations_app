import 'package:sqflite/sqflite.dart';

import '../models/annotation.dart';
import '../utilities/database_helper.dart';

class AnnotationTableHelper {
  static DatabaseHelper _databaseHelper = DatabaseHelper();
  String annotationsTable = 'annotation_table';
  String colId = 'id';
  String colTimestamp = 'timestamp';
  String colTag = 'tag';
  String colStatus = 'status';
  String colConditions = 'conditions';
  String colAdditionalInputs = 'additionalInputs';

  String get createQuery {
    return 'CREATE TABLE $annotationsTable($colId TEXT PRIMARY KEY, $colTimestamp TEXT, $colTag TEXT, '
        '$colStatus TEXT, $colConditions TEXT, $colAdditionalInputs TEXT)';
  }

  Future<List<Map<String, dynamic>>> getAnnotationsMapList() async {
    Database db = await _databaseHelper.database;

    var result = await db.query(annotationsTable, orderBy: '$colTimestamp ASC');
    return result;
  }

  Future<int> insertAnnotation(Annotation annotation) async {
    Database db = await _databaseHelper.database;
    var result = await db.insert(annotationsTable, annotation.toMap());
    return result;
  }

//  Future<int> updateAnnotation(Annotation annotation) async {
//    var db = await _databaseHelper.database;
//    var result = await db.update(annotationsTable, annotation.toMap(),
//        where: '$colId = ?', whereArgs: [annotation.id]);
//    return result;
//  }

//  Future<int> deleteAnnotation(int id) async {
//    var db = await _databaseHelper.database;
//    int result =
//        await db.rawDelete('DELETE FROM $annotationsTable WHERE $colId = $id');
//    return result;
//  }

  Future<int> deleteAllAnnotations() async {
    var db = await _databaseHelper.database;
    int result = await db.rawDelete('DELETE * FROM $annotationsTable');
    return result;
  }

//  Future<int> getCount() async {
//    Database db = await _databaseHelper.database;
//    List<Map<String, dynamic>> x =
//        await db.rawQuery('SELECT COUNT (*) from $annotationsTable');
//    int result = Sqflite.firstIntValue(x);
//    return result;
//  }

  Future<List<Annotation>> getAnnotationsList() async {
    var annotationsMapList =
        await getAnnotationsMapList(); // Get 'Map List' from database
    int count = annotationsMapList
        .length; // Count the number of map entries in db table

    List<Annotation> annotationsList = List<Annotation>();
    for (int i = 0; i < count; i++) {
      annotationsList.add(Annotation.fromMapObject(annotationsMapList[i]));
    }

    return annotationsList;
  }
}
