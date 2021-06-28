import 'package:currency_converter/views/splashscreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: kDebugMode,
      title: 'Currency Converter',
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blueGrey,
          accentColor: Colors.deepOrange,
        ).copyWith(
          secondary: Colors.deepOrange
        ),
        primarySwatch: Colors.blueGrey,
        accentColor: Colors.deepOrange,
        appBarTheme: AppBarTheme(
            actionsIconTheme: IconThemeData(
              color: Colors.white,
            ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen()
    );
  }
}