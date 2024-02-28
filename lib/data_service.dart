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
      // Throw exception if app should crash eg, if the server is down, or the URL is wrong
      // have a toast rather than a crash
      // could do a try catch in the UI, run if else checks for toast
      // would suggest a logger to log the error to a file or a server
      throw Exception('Failed to load users');
    }
  }
}

