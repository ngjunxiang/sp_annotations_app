import 'package:flutter/foundation.dart';
import 'package:sp_annotations_app/utilities/geolocation_table_helper.dart';

import '../models/geolocation.dart';
import '../utilities/database_helper.dart';

class RecordsProvider with ChangeNotifier {
  GeolocationTableHelper _geolocationTableHelper = GeolocationTableHelper();
  List<Geolocation> _recordsList;

  List<Geolocation> get records {
    return [..._recordsList];
  }

  Future<void> fetchRecords() async {
    try {
      final fetchedRecords = await _geolocationTableHelper.getGeolocationsList();
      _recordsList = fetchedRecords;
      notifyListeners();
    } catch (error) {
      // error handling
    }
  }

  Future<void> addRecord(Geolocation record) async {
    try {
      final result = await _geolocationTableHelper.insertGeolocation(record);

      if (result == 0) {
        // error handling
      }
      notifyListeners();
    } catch (error) {
      // error handling
    }
  }
}
