import 'package:flutter/material.dart';
import 'package:therm_stats/Views/user_chart_page.dart';
import 'package:therm_stats/Views/user_list_page.dart';
import '../Views/dashboard_page.dart';

class BaseLayout extends StatefulWidget {
  const BaseLayout({Key? key}) : super(key: key);

  @override
  State<BaseLayout> createState() => _BaseLayoutState();
}

class _BaseLayoutState extends State<BaseLayout> {
  int _selectedIndex = 0; // 0 for dashboard, 1 for user list, 2 for user chart

  // Manages the selected page index and updates the UI accordingly.
  void _selectPage(int index) {
    Navigator.of(context).pop(); // Close the drawer on page selection otherwise it stays open
    setState(() {
      _selectedIndex = index;
    });
  }

  // Builds the scaffold with a drawer and IndexedStack for page navigation. Replaces Appbar with Drawer.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0 ? 'Dashboard' : _selectedIndex == 1 ? 'User Temperatures' : 'User Chart'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            const UserAccountsDrawerHeader(
              accountName: Text("ThermStats"),
              accountEmail: Text("info@thermstats.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  "TS",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            // Drawer menu items that highlight the selected page
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              selected: _selectedIndex == 0,
              onTap: () => _selectPage(0),
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('User List'),
              selected: _selectedIndex == 1,
              onTap: () => _selectPage(1),
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text('User Chart'),
              selected: _selectedIndex == 2,
              onTap: () => _selectPage(2),
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          DashboardPage(),
          UserListPage(),
          UserChartPage(),
        ],
      ),
    );
  }
}