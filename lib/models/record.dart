class Record {
  String _id;
  DateTime _timestamp;
  String _tag;
  String _annotation;

  Record(
    this._id,
    this._timestamp,
    this._tag,
    this._annotation,
  );

  String get id => _id;

  String get timestamp => _timestamp.toIso8601String();

  String get tag => _tag;

  String get annotation => _annotation;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['timestamp'] = timestamp;
    map['tag'] = tag;
    map['annotation'] = annotation;

    return map;
  }

  Record.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._timestamp = DateTime.parse(map['timestamp']);
    this._tag = map['tag'];
    this._annotation = map['annotation'];
  }
}
