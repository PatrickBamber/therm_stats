import 'package:flutter/material.dart';
import 'data_service.dart';
import 'user.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  final DataService _dataService = DataService();
  List<User> _users = [];
  List<User> _filteredUsers = [];
  bool _showHighTempOnly = false;
  String _currentSort = 'Temperature';
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  void _loadUsers() async {
    List<User> users = await _dataService.fetchUsers();
    setState(() {
      _users = users;
      _filteredUsers = users;
      _applyFiltersAndSort();
    });
  }

  void _toggleHighTempFilter(bool value) {
    setState(() {
      _showHighTempOnly = value;
      _applyFiltersAndSort();
    });
  }

  void _applyFiltersAndSort() {
    List<User> users = _users.where((user) {
      return !_showHighTempOnly || user.temperature > 37;
    }).toList();
    if (_searchQuery.isNotEmpty) {
      users = users.where((user) {
        return user.name.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }
    switch (_currentSort) {
      case 'Name':
        users.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'Age':
        users.sort((a, b) => a.age.compareTo(b.age));
        break;
      case 'Temperature':
        users.sort((a, b) => a.temperature.compareTo(b.temperature));
        break;
    }
    setState(() {
      _filteredUsers = users;
    });
  }

  void _filterUsersByName(String query) {
    setState(() {
      _searchQuery = query;
      _applyFiltersAndSort();
    });
  }

  String _ageTempRatio(User user) {
    if (user.temperature != 0) {
      return (user.age / user.temperature).toStringAsFixed(2);
    } else {
      return 'N/A';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
          underline: Container(
            height: 2,
            color: Colors.blue,
          ),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                _currentSort = newValue;
                _applyFiltersAndSort();
              });
            }
          },
          items: <String>['Name', 'Age', 'Temperature']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text('Sort by $value'),
            );
          }).toList(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, // Center the Row contents horizontally
            children: [
              const Text('Toggle High Temperatures', textAlign: TextAlign.center),
              const SizedBox(width: 10), // Provide some space between the text and the switch
              Switch(
                value: _showHighTempOnly,
                onChanged: _toggleHighTempFilter,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _filteredUsers.length,
            itemBuilder: (context, index) {
              final user = _filteredUsers[index];
              final isHighTemp = user.temperature > 37;
              return Card(
                color: isHighTemp ? Colors.redAccent.withOpacity(0.3) : Colors.white,
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(
                    user.name,
                    style: TextStyle(
                      color: isHighTemp ? Colors.red : Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    'Age: ${user.age}, Temp: ${user.temperature.toStringAsFixed(1)}°C, Ratio: ${_ageTempRatio(user)}',
                  ),
                  trailing: isHighTemp ? const Icon(Icons.warning, color: Colors.red) : null,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}