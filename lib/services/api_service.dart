import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static String baseUrl = dotenv.env['BASE_URL']!;
  static String? token;

  static Future<bool> login(String email, String password) async {
    final res = await http.post(
      Uri.parse('$baseUrl/api/v1/auth/login'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );
    print(res.body);

    if (res.statusCode == 200) {
      token = jsonDecode(res.body)['token'];
      return true;
    }
    return false;
  }

  static Future<List<dynamic>> getServices() async {
    print("Token : $token");
    final res = await http.get(
      Uri.parse('$baseUrl/api/v1/services'),
      headers: {"Authorization": "Bearer $token"},
    );

    return jsonDecode(res.body);
  }

  static Future<bool> createBooking(Map data) async {
    final res = await http.post(
      Uri.parse('$baseUrl/api/v1/bookings/add'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(data),
    );

    return res.statusCode == 200;
  }
}
