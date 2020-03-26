import 'package:sqflite/sqflite.dart';

import '../models/image.dart';
import '../utilities/database_helper.dart';

class ImageTableHelper {
  static DatabaseHelper _databaseHelper = DatabaseHelper();
  String imagesTable = 'image_table';
  String colId = 'id';
  String colTimestamp = 'timestamp';
  String colTag = 'tag';
  String colImage = 'image';

  String get createQuery {
    return 'CREATE TABLE $imagesTable($colId TEXT PRIMARY KEY, $colTimestamp TEXT, $colTag TEXT, $colImage TEXT)';
  }

  Future<List<Map<String, dynamic>>> getImagesMapList() async {
    Database db = await _databaseHelper.database;

    var result = await db.query(imagesTable, orderBy: '$colTimestamp ASC');
    return result;
  }

  Future<int> insertImage(Image image) async {
    Database db = await _databaseHelper.database;
    var result = await db.insert(imagesTable, image.toMap());
    return result;
  }

//  Future<int> updateImage(Image image) async {
//    var db = await _databaseHelper.database;
//    var result = await db.update(imagesTable, image.toMap(),
//        where: '$colId = ?', whereArgs: [image.id]);
//    return result;
//  }

//  Future<int> deleteImage(int id) async {
//    var db = await _databaseHelper.database;
//    int result =
//        await db.rawDelete('DELETE FROM $imagesTable WHERE $colId = $id');
//    return result;
//  }

  Future<int> deleteAllImages() async {
    var db = await _databaseHelper.database;
    int result = await db.rawDelete('DELETE * FROM $imagesTable');
    return result;
  }

//  Future<int> getCount() async {
//    Database db = await _databaseHelper.database;
//    List<Map<String, dynamic>> x =
//        await db.rawQuery('SELECT COUNT (*) from $imagesTable');
//    int result = Sqflite.firstIntValue(x);
//    return result;
//  }

  Future<List<Image>> getImagesList() async {
    var imagesMapList =
        await getImagesMapList(); // Get 'Map List' from database
    int count =
        imagesMapList.length; // Count the number of map entries in db table

    List<Image> imagesList = List<Image>();
    for (int i = 0; i < count; i++) {
      imagesList.add(Image.fromMapObject(imagesMapList[i]));
    }

    return imagesList;
  }
}
