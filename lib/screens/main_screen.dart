import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../widgets/annotations_widget.dart';
import '../widgets/sensor_widget.dart';

class MainScreen extends StatelessWidget {
  PreferredSizeWidget _buildAppBar() {
    return Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text(
              'Annotations',
            ),
          )
        : AppBar(
            title: const Text(
              'Annotations',
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final PreferredSizeWidget appBar = _buildAppBar();

    final sensorWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top -
              mediaQuery.padding.bottom) *
          0.4,
      child: SensorWidget(),
    );

    final annotationsWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top -
              mediaQuery.padding.bottom) *
          0.6,
      child: AnnotationsWidget(),
    );

    final pageBody = SafeArea(
//      child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          sensorWidget,
          annotationsWidget,
        ],
//        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar,
            child: pageBody,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
          );
  }
}
