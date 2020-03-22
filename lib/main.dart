import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './providers/records_provider.dart';
import './screens/main_screen.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(AnnotationsApp());
}

class AnnotationsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: RecordsProvider(),
        ),
      ],
      child: Platform.isIOS
          ? CupertinoApp(
              title: 'Annotations',
              theme: CupertinoThemeData(
                barBackgroundColor: Colors.green,
                primaryColor: Colors.green,
                primaryContrastingColor: Colors.lightGreen,
                textTheme: CupertinoTextThemeData(),
//                textTheme: CupertinoTextThemeData().copyWith(
//                  textStyle: const TextStyle(
//                    fontFamily: 'RobotoCondensed',
//                    fontSize: 18,
//                    fontWeight: FontWeight.bold,
//                  ),
//                  actionTextStyle: const TextStyle(
//                    color: Colors.black,
//                  ),
//                ),
              ),
              home: MainScreen(),
            )
          : MaterialApp(
              title: 'Annotations',
              theme: ThemeData(
                primarySwatch: Colors.green,
                accentColor: Colors.lightGreen,
                fontFamily: 'RobotoCondensed',
                textTheme: ThemeData.light().textTheme.copyWith(
                      title: const TextStyle(
                        fontFamily: 'RobotoCondensed',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      button: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                appBarTheme: AppBarTheme(
                  textTheme: ThemeData.light().textTheme.copyWith(
                        title: const TextStyle(
                          fontFamily: 'RobotoCondensed',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                ),
              ),
              home: MainScreen(),
            ),
    );
  }
}
