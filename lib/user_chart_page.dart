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
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ScatterChart(
                ScatterChartData(
                  scatterSpots: _users.map((user) => ScatterSpot(user.age.toDouble(), user.temperature)).toList(),
                  titlesData: FlTitlesData(
                    bottomTitles: SideTitles(showTitles: true, getTitles: (value) => value.toInt().toString(),),
                    leftTitles: SideTitles(showTitles: true, getTitles: (value) => value.toInt().toString(),),
                  ),
                  borderData: FlBorderData(show: true),
                  gridData: FlGridData(show: false),
                ),
              ),
            ),
            flex: 1, // Takes half of the space
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'This scatter plot shows the relationship between age and temperature of users. Each point represents a user\'s age on the x-axis and their temperature on the y-axis.',
                textAlign: TextAlign.justify,
              ),
            ),
            flex: 1, // Takes the other half of the space
          ),
        ],
      ),
    );
  }
}
