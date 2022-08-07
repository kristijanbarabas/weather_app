import 'package:clima_app/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'screens/loading_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(secondaryHeaderColor: Colors.white),
      home: const LoadingScreen(),
    );
  }
}
