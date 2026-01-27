import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Use http://10.0.2.2:3000/api for Android Emulator
  // Use http://localhost:3000/api for iOS Simulator or Web
  static const String baseUrl = "http://10.0.2.2:3000/api";

  static Future<http.Response> register(
    String name,
    String email,
    String password,
  ) async {
    final url = Uri.parse("$baseUrl/auth/register");
    return await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "fullName": name,
        "email": email,
        "password": password,
      }),
    );
  }

  static Future<http.Response> login(String email, String password) async {
    final url = Uri.parse("$baseUrl/auth/login");
    return await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );
  }

  static Future<List<dynamic>> getCars() async {
    final url = Uri.parse("$baseUrl/cars");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load cars");
    }
  }
}
