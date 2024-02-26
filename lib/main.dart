import 'package:flutter/material.dart';
import 'base_layout.dart'; // Ensure you have imported BaseLayout correctly.

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ThermStats',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BaseLayout(), // Use BaseLayout as the home widget.
    );
  }
}
