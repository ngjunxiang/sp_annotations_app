import 'dart:async';

import 'package:location/location.dart';

import '../models/geolocation.dart';
import '../models/preferences.dart';
import '../utilities/device_helper.dart';

class LocationHelper {
  static final Location location = Location();

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
    String deviceUUID = await DeviceHelper.getDeviceUUID();

    return Geolocation(
      deviceUUID,
      DateTime.fromMillisecondsSinceEpoch(locationData.time.toInt()),
      Preferences.tag,
      locationData.latitude,
      locationData.longitude,
      locationData.accuracy,
      locationData.altitude,
      locationData.speed,
    );
  }
}
