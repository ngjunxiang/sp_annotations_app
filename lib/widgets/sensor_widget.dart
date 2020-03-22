import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SensorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Platform.isIOS
            ? CupertinoTheme.of(context).primaryColor
            : Theme.of(context).primaryColor;
    final primaryContrastingColor = Platform.isIOS
            ? CupertinoTheme.of(context).primaryContrastingColor
            : Theme.of(context).accentColor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          color: primaryContrastingColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            child: const Text('Sensor'),
          ),
        )
      ],
    );
  }
}
