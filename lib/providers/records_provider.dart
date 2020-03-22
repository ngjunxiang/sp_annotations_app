import 'package:flutter/foundation.dart';

import '../models/record.dart';

class RecordsProvider with ChangeNotifier {
    List<Record> recordsList = [];
}