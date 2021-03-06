import 'dart:convert';

import 'package:money_app/constants/constant.dart';
import 'package:money_app/model/record_model.dart';
import 'package:money_app/services/api_service.dart';

class RecordRepository {
  RecordRepository._privateConstructor();
  static final RecordRepository instance =
      RecordRepository._privateConstructor();

  Future<List<Record>> getRecords() async {
    final data = await ApiService.instance.get(ApiURL.listRecord);
    final list = (jsonDecode(data) as List)
        .map<Record>((e) => Record.fromJson(e as Map<String, dynamic>))
        .toList();
    list.sort((a, b) => b.createDate.compareTo(a.createDate));
    return list ?? [];
  }
}
