import 'package:money_app/constants/constant.dart';
import 'package:money_app/services/api_service.dart';

class LoginRepository {
  LoginRepository._privateConstructor();
  static final LoginRepository instance = LoginRepository._privateConstructor();
  final apiService = ApiService().service;

  Future<Map<String, dynamic>> login(String username, String password) async {
    final data = await apiService.post(ApiURL.login, body: {
      "user_name": username,
      "password": password,
    });
    return data;
  }

  Future<Map<String, dynamic>> register(
      String username, String password) async {
    final data = await apiService.post(ApiURL.register, body: {
      "user_name": username,
      "password": password,
      "confirm_password": password,
    });
    return data;
  }
}
