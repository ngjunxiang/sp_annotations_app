import 'package:location/location.dart';
import 'package:sp_annotations_app/models/geolocation.dart';

class LocationHelper {
  static final Location location = Location();

  // once a second
  static Future<bool> init() async {
    return checkForPermissions();
  }

  static Future<bool> checkForPermissions() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return false;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.DENIED) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.GRANTED) {
        return false;
      }
    }

    return true;
  }

  static Future<Geolocation> getGeolocation() async {
    LocationData locationData = await location.getLocation();

    return Geolocation(
      '123',
      DateTime.fromMillisecondsSinceEpoch(locationData.time.toInt()),
      '123',
      locationData.latitude,
      locationData.longitude,
      locationData.accuracy,
      locationData.altitude,
      locationData.speed,
    );
  }
}
