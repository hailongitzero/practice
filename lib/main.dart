import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice/src/pages/home.dart';
import 'package:practice/src/pages/navigator.dart';
import 'package:practice/src/pages/login.dart';
import 'package:practice/src/pages/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fluuter Practice App',
      theme: ThemeData(
        // Use the green theme for Material widgets.
        primarySwatch: Colors.green,
      ),
      darkTheme: ThemeData.dark(),
      builder: (context, child) {
        return CupertinoTheme(
          // Instead of letting Cupertino widgets auto-adapt to the Material
          // theme (which is green), this app will use a different theme
          // for Cupertino (which is blue by default).
          data: const CupertinoThemeData(),
          child: Material(child: child),
        );
      },
      home: SplashScreen(),
    );
  }
}
