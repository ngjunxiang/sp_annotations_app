import 'package:geolocator/geolocator.dart';

class GeolocatorHelper {
  // once a second
  static Future<Position> get currentLocation async {
    return await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
}
