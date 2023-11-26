import 'package:curdopration_api/screen/home%20/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeScreen(),
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
         border: OutlineInputBorder(),
        )
      ),
    );
  }
}


