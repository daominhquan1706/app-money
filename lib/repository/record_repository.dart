import 'dart:convert';

import 'package:money_app/mock/record_mock.dart';
import 'package:money_app/model/record.dart';

class RecordRepository {
  Future<List<Record>> getRecords() async {
    await Future.delayed(const Duration());
    return (jsonDecode(data) as List)
        .map<Record>((e) => Record.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
