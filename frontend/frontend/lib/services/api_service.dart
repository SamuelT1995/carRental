import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static String get baseUrl {
    if (kIsWeb) return 'http://localhost:5000/api';
    return Platform.isAndroid
        ? 'http://10.0.2.2:5000/api'
        : 'http://localhost:5000/api';
  }

  static Future<Map<String, dynamic>?> login(
    String email,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email.trim(), 'password': password.trim()}),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', data['token']);

        // FIX: Change setInt to setString because your ID is a UUID string
        await prefs.setString('userId', data['user']['id'].toString());

        return data;
      }
    } catch (e) {
      debugPrint('Login Error: $e');
    }
    return null;
  }

  static Future<Map<String, dynamic>?> signup(
    String name,
    String email,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'full_name': name,
          'email': email.trim(),
          'password': password.trim(),
        }),
      );
      return response.statusCode == 201 ? jsonDecode(response.body) : null;
    } catch (e) {
      debugPrint('Signup Error: $e');
    }
    return null;
  }

  static Future<List<dynamic>> fetchCars() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/cars'));
      if (response.statusCode == 200) return jsonDecode(response.body);
    } catch (e) {
      debugPrint('Fetch Error: $e');
    }
    return [];
  }

  static Future<bool> createBooking(Map<String, dynamic> bookingData) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      final response = await http.post(
        Uri.parse('$baseUrl/bookings'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(bookingData),
      );
      return response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }
}
