import 'package:http/http.dart' as http;

class ApiService {
  ApiService._privateConstructor();
  static final ApiService instance = ApiService._privateConstructor();

  final String _rootUrl = "localhost:3000";

  Future<String> get(String url, {String body}) async {
    final http.Response response = await http.get(Uri.http(_rootUrl, url));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load album');
    }
  }
}
