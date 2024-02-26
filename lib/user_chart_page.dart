import 'package:flutter/material.dart';
import 'user.dart';
import 'data_service.dart';

class UserChartPage extends StatelessWidget {
  const UserChartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Chart'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/userList');
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Chart will be implemented here.'),
      ),
    );
  }
}
