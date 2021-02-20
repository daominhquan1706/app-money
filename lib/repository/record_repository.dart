import 'dart:convert';

import 'package:money_app/mock/record_mock.dart';
import 'package:money_app/model/record_model.dart';

class RecordRepository {
  RecordRepository._privateConstructor();
  static final RecordRepository instance =
      RecordRepository._privateConstructor();

  Future<List<Record>> getRecords() async {
    await Future.delayed(const Duration(seconds: 1));
    final list = (jsonDecode(fakeDataRecords) as List)
        .map<Record>((e) => Record.fromJson(e as Map<String, dynamic>))
        .toList();
    list.sort((a, b) => b.createDate.compareTo(a.createDate));
    return list ?? [];
  }
}
