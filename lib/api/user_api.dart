import 'dart:convert';
import 'package:http/http.dart' as http;

class UserApi {
  Future<http.Response> registerUser(String phone, String password) async {
    const apiUrl = 'http://localhost:8080/api/signup';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'phone': phone,
          'password': password,
        }),
      );

      return response;
    } catch (error) {
      // ignore: avoid_print
      print('Error: $error');
      rethrow; // Rethrow the error for the caller to handle
    }
  }
}
