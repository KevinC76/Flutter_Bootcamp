import 'package:flutter/material.dart';
import 'package:friviaa/pages/game_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Friviaa',
      theme: ThemeData(
        fontFamily: "ArchitectsDaughter",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        scaffoldBackgroundColor: Color.fromRGBO(
          31,
          31,
          1,
          1.0,
        ),
        useMaterial3: true,
      ),
      home: GamePage(),
    );
  }
}


