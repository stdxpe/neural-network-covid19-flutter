import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  Paint.enableDithering = true;
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yasin Bilgin YSA Proje',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Montserrat',
      ),
      home: SplashScreen(),
    );
  }
}
