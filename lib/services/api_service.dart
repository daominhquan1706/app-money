import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

class ApiService {
  ApiService._privateConstructor();
  static final ApiService instance = ApiService._privateConstructor();

  final String _rootUrl = "localhost:8080";

  Future<Map<String, dynamic>> get(String url,
      {Map<String, String> params}) async {
    EasyLoading.show(status: 'loading...');
    try {
      final http.Response response =
          await http.get(Uri.http(_rootUrl, url, params));
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        return jsonDecode(utf8.decode(response.bodyBytes))
            as Map<String, dynamic>;
      } else {
        throw Exception('Failed to load album');
      }
    } catch (e) {
      EasyLoading.dismiss();
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> post(String url,
      {Map<String, String> params, Map<String, dynamic> body}) async {
    EasyLoading.show(status: 'loading...');
    try {
      final http.Response response = await http.post(
        Uri.http(_rootUrl, url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        return jsonDecode(utf8.decode(response.bodyBytes))
            as Map<String, dynamic>;
      } else {
        throw Exception('Failed to load album');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
