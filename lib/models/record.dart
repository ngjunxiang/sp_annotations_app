import 'package:flutter/foundation.dart';

class Record {
  final String phoneId;
  final DateTime timestamp;
  final String tag;
  final String annotation;

  Record({
    @required this.phoneId,
    @required this.timestamp,
    @required this.tag,
    @required this.annotation,
  });
}
