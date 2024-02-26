import 'package:flutter/material.dart';
import 'dart:async';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  double _height = 50; // Initial height of the animated container
  Color _color = Colors.blue; // Initial color

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        // Toggle height to simulate animation
        _height = _height == 50 ? 150 : 50;
        // Change color based on height
        _color = _height == 150 ? Colors.red : Colors.blue;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to ThermStats!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Select an option from the drawer menu to get started.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            AnimatedContainer(
              duration: const Duration(seconds: 2),
              height: _height,
              width: 50,
              decoration: BoxDecoration(
                color: _color, // Apply animated color
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Center(
                child: Text(
                  'Temp',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
