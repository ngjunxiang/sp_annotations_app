import 'dart:io';
import 'dart:convert';

class Image {
  String _id;
  DateTime _timestamp;
  String _tag;
  String _image;

  Image(
    this._id,
    this._timestamp,
    this._tag,
    File image,
  ) {
    List<int> imageBytes = image.readAsBytesSync();
    _image = base64Encode(imageBytes);
  }

  String get id => _id;

  String get timestamp => _timestamp.toIso8601String();

  String get tag => _tag;

  String get image => _image;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['timestamp'] = timestamp;
    map['tag'] = tag;
    map['image'] = image;

    return map;
  }

  Image.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._timestamp = DateTime.parse(map['timestamp']);
    this._tag = map['tag'];
    this._image = map['image'];
  }
}
