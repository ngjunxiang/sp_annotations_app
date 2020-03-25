import 'package:flutter/foundation.dart';

import '../models/record.dart';
import '../utilities/database_helper.dart';

class RecordsProvider with ChangeNotifier {
  DatabaseHelper _databaseHelper = DatabaseHelper();
  List<Record> _recordsList;

  List<Record> get records {
    return [..._recordsList];
  }

  Future<void> fetchRecords() async {
    try {
      final fetchedRecords = await _databaseHelper.getRecordsList();
      _recordsList = fetchedRecords;
      notifyListeners();
    } catch (error) {
      // error handling
    }
  }

  Future<void> addRecord(Record record) async {
    try {
      final result = await _databaseHelper.insertRecord(record);

      if (result == 0) {
          // error handling
      }
      notifyListeners();
    } catch (error) {
        // error handling
    }
  }
}
