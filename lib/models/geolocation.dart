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
    map['latitude'] = latitude.toString();
    map['longitude'] = longitude.toString();
    map['accuracy'] = accuracy.toString();
    map['altitude'] = altitude.toString();
    map['speed'] = speed.toString();

    return map;
  }

  Geolocation.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._timestamp = DateTime.parse(map['timestamp']);
    this._tag = map['tag'];
    this._latitude = double.parse(map['latitude']);
    this._longitude = double.parse(map['longitude']);
    this._accuracy = double.parse(map['accuracy']);
    this._altitude = double.parse(map['altitude']);
    this._speed = double.parse(map['speed']);
  }
}
