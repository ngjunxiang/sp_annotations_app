import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:device_info/device_info.dart';

import '../models/error_exception.dart';

class DeviceHelper {
  static Future<String> getDeviceUUID() async {
    String identifier;
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        identifier = build.androidId; //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        identifier = data.identifierForVendor; //UUID for iOS
      }
    } on PlatformException {
      throw ErrorException('Failed to get device details');
    }

    return identifier;
  }
}
