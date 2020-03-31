import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:location/location.dart';

import '../models/error_exception.dart';
import '../models/geolocation.dart';
import '../models/preferences.dart';
import '../utilities/device_helper.dart';
import '../utilities/geolocation_table_helper.dart';
import '../utilities/location_helper.dart';

class GeolocationProvider with ChangeNotifier {
  Timer timer;
  var _started = false;
  var _geolocationTableHelper = GeolocationTableHelper();
  List<Geolocation> _geolocationsList;
  StreamSubscription<LocationData> _locationSubscription;

  bool get started => _started;

  List<Geolocation> get geolocations => [..._geolocationsList];

  Future<void> fetchGeolocations() async {
    final fetchedGeolocations =
        await _geolocationTableHelper.getGeolocationsList();
    _geolocationsList = fetchedGeolocations;
    notifyListeners();
  }

  void startRecordingGeolocation() async {
    var hasPermissions = await LocationHelper.checkForPermissions();

    if (!hasPermissions) {
      throw ErrorException(
          'Please ensure location service is enabled and permission is granted');
    }

    _started = true;
    print(_started);

    _listenGeolocation();

    notifyListeners();
  }

  void stopRecordingGeolocation(bool isPaused) async {
    if (!isPaused) {
      _started = false;
      print('recording stopped');
    } else {
      print('recording paused');
    }
    print('Cancel all tasks completed');
    // timer.cancel();

    _stopListen();
    notifyListeners();
  }

  Future<void> _listenGeolocation() async {
    LocationData locationData = await LocationHelper.location.getLocation();
    String deviceUUID = await DeviceHelper.getDeviceUUID();

    _locationSubscription =
        LocationHelper.location.onLocationChanged().handleError((dynamic err) {
      _locationSubscription.cancel();
      throw ErrorException(
          'Failed to listen to location with error ${err.code}');
    }).listen((LocationData currentLocation) {
      _addGeolocation(Geolocation(
        deviceUUID,
        DateTime.fromMillisecondsSinceEpoch(locationData.time.toInt()),
        Preferences.tag,
        locationData.latitude,
        locationData.longitude,
        locationData.accuracy,
        locationData.altitude,
        locationData.speed,
      ));
    });
  }

  Future<void> _stopListen() async {
    _locationSubscription.cancel();
  }

//   Future<bool> startScheduler() async {
//     print('started');
// //    Workmanager.executeTask((task, inputData) {
//     timer = Timer.periodic(Duration(seconds: 10), (Timer t) async {
//       print('Recorded at ${DateTime.now().toString()}');
// //        Geolocation currentGeolocation = await LocationHelper.getGeolocation();
// //        _addGeolocation(currentGeolocation);
// //        print('Inserted geolocation $currentGeolocation');
//     });
//     return Future.value(true);
// //    });
//   }

  Future<void> _addGeolocation(Geolocation geolocation) async {
    final result = await _geolocationTableHelper.insertGeolocation(geolocation);

    if (result == 0) {
      throw ErrorException('Failed to record geolocation');
    }
  }
}
