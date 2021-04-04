import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  ApiService._privateConstructor();
  static final ApiService instance = ApiService._privateConstructor();

  final String _rootUrl = "localhost:8080";

  Future<Map<String, dynamic>> get(String url,
      {Map<String, String> params}) async {
    final http.Response response =
        await http.get(Uri.http(_rootUrl, url, params));
    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes))
          as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<Map<String, dynamic>> post(String url,
      {Map<String, dynamic> params, Map<String, dynamic> body}) async {
    final http.Response response = await http.post(
      Uri.http(_rootUrl, url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );
    print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes))
          as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load album');
    }
  }
}
