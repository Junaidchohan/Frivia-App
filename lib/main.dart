import 'package:flutter/material.dart';
import 'package:frivia_app/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Frivia',
      theme: ThemeData(
        fontFamily: 'ArchitectsDaughter',
        scaffoldBackgroundColor: Color.fromRGBO(31, 31, 31, 1.0),
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomePage(),
    );
  }
}
