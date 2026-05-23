import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Default to Android emulator host. Change as needed.
  static const String baseUrl = 'http://10.0.2.2:8000';

  static Future<dynamic> get(String path) async {
    final uri = Uri.parse('$baseUrl$path');
    final resp = await http.get(uri);
    if (resp.statusCode >= 200 && resp.statusCode < 300) {
      return jsonDecode(resp.body);
    }
    throw Exception('GET $path failed: ${resp.statusCode}');
  }

  static Future<dynamic> post(String path, Map<String, dynamic> body) async {
    final uri = Uri.parse('$baseUrl$path');
    final resp = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    if (resp.statusCode >= 200 && resp.statusCode < 300) {
      return jsonDecode(resp.body);
    }
    throw Exception('POST $path failed: ${resp.statusCode}');
  }
}
