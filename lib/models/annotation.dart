import 'dart:convert';

class Annotation {
  String _id;
  DateTime _timestamp;
  String _tag;
  String _status;
  List<String> _conditions;
  String _additionalInputs;

  Annotation(
    this._id,
    this._timestamp,
    this._tag,
    this._status,
    this._conditions,
    this._additionalInputs,
  );

  String get id => _id;

  String get timestamp => _timestamp.toIso8601String();

  String get tag => _tag;

  String get status => _status;

  List<String> get conditions => _conditions;

  String get additionalInputs => _additionalInputs;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['timestamp'] = timestamp;
    map['tag'] = tag;
    map['status'] = status;
    map['conditions'] = jsonEncode(conditions);
    map['additionalInputs'] = additionalInputs;

    return map;
  }

  Annotation.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._timestamp = DateTime.parse(map['timestamp']);
    this._tag  = map['tag'];
    this._status  = map['status'];
    this._conditions  = jsonDecode(map['conditions']) as List<String>;
    this._additionalInputs  = map['additionalInputs'];
  }
}
