import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './providers/geolocation_provider.dart';
import './screens/main_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(AnnotationsApp());
}

class AnnotationsApp extends StatelessWidget {
  Widget _buildApp() {
    return MaterialApp(
      title: 'Annotations',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.grey[200],
        fontFamily: 'RobotoCondensed',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: const TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              button: const TextStyle(
                color: Colors.white,
                fontFamily: 'RobotoCondensed',
                fontSize: 18,
              ),
              headline: const TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: 30,
                fontWeight: FontWeight.bold,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: GeolocationProvider(),
        ),
      ],
      child: _buildApp(),
    );
  }
}
