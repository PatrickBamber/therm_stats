import 'package:flutter/material.dart';
import 'data_service.dart';
import 'user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'ThermStats',
      home: UserListPage(),
    );
  }
}

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  final DataService _dataService = DataService();
  List<User> _users = [];
  List<User> _filteredUsers = [];
  String _searchText = "";
  String _currentSort = 'Temperature';
  bool _showHighTempOnly = false;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  void _loadUsers() async {
    _users = await _dataService.fetchUsers();
    _filteredUsers = _users;
    setState(() {});
  }

  void _toggleHighTempFilter(bool value) {
    setState(() {
      _showHighTempOnly = value;
      if (_showHighTempOnly) {
        _filteredUsers = _users.where((user) => user.temperature > 37).toList();
      } else {
        _filteredUsers = _users;
      }
    });
  }

  String _ageTempRatio(User user) {
    // Make sure not to divide by zero
    if (user.temperature != 0) {
      return (user.age / user.temperature).toStringAsFixed(2);
    } else {
      return 'N/A';
    }
  }

  void _filterUsersByName(String query) {
    final searchResults = _users.where((user) {
      return user.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      if (_showHighTempOnly) {
        _filteredUsers = searchResults.where((user) => user.temperature > 37).toList();
      } else {
        _filteredUsers = searchResults;
      }
    });
  }

  void _sortUsers(String sortType) {
    switch (sortType) {
      case 'Name':
        _filteredUsers.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'Age':
        _filteredUsers.sort((a, b) => a.age.compareTo(b.age));
        break;
      case 'Temperature':
        _filteredUsers.sort((a, b) => a.temperature.compareTo(b.temperature));
        break;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Temperatures'),
        actions: [
          Switch(
            value: _showHighTempOnly,
            onChanged: _toggleHighTempFilter,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search by name',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: _filterUsersByName,
            ),
          ),
          DropdownButton<String>(
            value: _currentSort,
            items: <String>['Name', 'Age', 'Temperature']
                .map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text('Sort by $value'),
              );
            }).toList(),
            onChanged: (newValue) {
              if (newValue != null) {
                setState(() {
                  _currentSort = newValue;
                  _sortUsers(newValue);
                });
              }
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredUsers.length,
              itemBuilder: (context, index) {
                User user = _filteredUsers[index];
                bool isHighTemp = user.temperature > 37;
                return Card(
                  color: isHighTemp ? Colors.redAccent.withOpacity(0.3) : Colors
                      .white,
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                      user.name,
                      style: TextStyle(
                        color: isHighTemp ? Colors.red : Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      'Age: ${user.age}, Temp: ${user.temperature
                          .toStringAsFixed(1)}°C, Ratio: ${_ageTempRatio(
                          user)}',
                    ),
                    trailing: isHighTemp ? Icon(
                        Icons.warning, color: Colors.red) : null,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}