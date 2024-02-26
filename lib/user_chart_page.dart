import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'data_service.dart';
import 'user.dart';

class UserChartPage extends StatefulWidget {
  const UserChartPage({Key? key}) : super(key: key);

  @override
  _UserChartPageState createState() => _UserChartPageState();
}

class _UserChartPageState extends State<UserChartPage> {
  final DataService _dataService = DataService();
  List<User> _users = [];

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  void _fetchUsers() async {
    List<User> users = await _dataService.fetchUsers();
    setState(() {
      _users = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Determine the min and max values for age and temperature
    double minX = _users.isNotEmpty ? _users.map((user) => user.age.toDouble()).reduce(min) - 1 : 0;
    double maxX = _users.isNotEmpty ? _users.map((user) => user.age.toDouble()).reduce(max) + 1 : 100;
    double minY = _users.isNotEmpty ? _users.map((user) => user.temperature).reduce(min) - 5 : 0;
    double maxY = _users.isNotEmpty ? _users.map((user) => user.temperature).reduce(max) + 5 : 100;

    return Scaffold(
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'User Age vs. Temperature Scatter Plot',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const RotatedBox(
                    quarterTurns: -1,
                    child: Text('Temperature (°C)', style: TextStyle(fontSize: 16), textAlign: TextAlign.center),
                  ),
                  Expanded(
                    child: ScatterChart(
                      ScatterChartData(
                        scatterSpots: _users.map((user) => ScatterSpot(user.age.toDouble(), user.temperature)).toList(),
                        minX: minX,
                        maxX: maxX,
                        minY: minY,
                        maxY: maxY,
                        titlesData: FlTitlesData(
                          bottomTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 22,
                            getTitles: (value) => value.toInt().toString(),
                          ),
                          leftTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 28,
                            getTitles: (value) => value.toInt().toString(),
                          ),
                        ),
                        borderData: FlBorderData(show: true),
                        gridData: FlGridData(show: true),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Text('Age (Years)', style: TextStyle(fontSize: 16)),
          ),
          const Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'This scatter plot shows the relationship between age and temperature of users. Each point represents a user\'s age on the x-axis and their temperature on the y-axis.',
                textAlign: TextAlign.justify,
              ),
            ),
          ),
        ],
      ),
    );
  }
  }

