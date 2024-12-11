import 'package:flutter/material.dart';
import 'package:sandy_calculates/calscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sandy Calculates',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: const CalculatorScreen(),
    );
  }
}
