class Geolocation {
  String _id;
  DateTime _timestamp;
  String _tag;
  double _latitude;
  double _longitude;
  double _accuracy;
  double _altitude;
  double _speed;

  Geolocation(
    this._id,
    this._timestamp,
    this._tag,
    this._latitude,
    this._longitude,
    this._accuracy,
    this._altitude,
    this._speed,
  );

  String get id => _id;

  String get timestamp => _timestamp.toIso8601String();

  String get tag => _tag;

  double get latitude => _latitude;

  double get longitude => _longitude;

  double get accuracy => _accuracy;

  double get altitude => _altitude;

  double get speed => _speed;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['timestamp'] = timestamp;
    map['tag'] = tag;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['accuracy'] = accuracy;
    map['altitude'] = altitude;
    map['speed'] = speed;

    return map;
  }

  Geolocation.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._timestamp = DateTime.parse(map['timestamp']);
    this._tag = map['tag'];
    this._latitude = map['latitude'];
    this._longitude = map['longitude'];
    this._accuracy = map['accuracy'];
    this._altitude = map['altitude'];
    this._speed = map['speed'];
  }
}
