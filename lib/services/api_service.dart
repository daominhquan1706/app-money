import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:money_app/constants/constant.dart';
import 'package:money_app/services/locator_service.dart';
import 'package:stacked_services/stacked_services.dart';

class ApiService {
  ApiService get service => locator<ApiService>();
  final String _rootUrl = "localhost:8080";
  final _dialogService = DialogService();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users =
      FirebaseFirestore.instance.collection(CollectionName.user);

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
      //throw Exception(e);
      return null;
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
      final data =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      final message = data["message"] as String;
      if (message != null) {
        await _dialogService.showDialog(
          title: 'Message',
          description: message,
          buttonTitle: "OK",
        );
      }
      return jsonDecode(utf8.decode(response.bodyBytes))
          as Map<String, dynamic>;
    } catch (e) {
      EasyLoading.dismiss();
      _dialogService.showDialog(
        title: 'Error',
        description: e.toString(),
        buttonTitle: "OK",
      );
      throw Exception(e);
    }
  }
}
