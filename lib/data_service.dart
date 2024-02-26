import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user.dart'; // Import the User model from user.dart

class DataService {
  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse('https://dev.osbornetechnologies.co.uk/project/'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<User> users = body.map((dynamic item) => User.fromJson(item)).toList();
      return users;
    } else {
      throw Exception('Failed to load users');
    }
  }
}

