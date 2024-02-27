import 'package:flutter/material.dart';
import 'base_layout.dart';

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
      home: const BaseLayout(), // Using the custom BaseLayout as the home widget replacing the appbar.
    );
  }
}
