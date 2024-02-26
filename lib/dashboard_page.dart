import 'package:flutter/material.dart';
import 'user_list_page.dart';
import 'user_chart_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('ThermStats Menu'),
            ),
            ListTile(
              title: const Text('User List'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/userList');
              },
            ),
            ListTile(
              title: const Text('User Chart'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/userChart');
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('Welcome to ThermStats Dashboard!'),
      ),
    );
  }
}
