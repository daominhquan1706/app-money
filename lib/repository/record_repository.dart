import 'package:money_app/constants/constant.dart';
import 'package:money_app/model/record_model.dart';
import 'package:money_app/services/api_service.dart';
import 'package:money_app/services/shared_preference_service.dart';

class RecordRepository {
  RecordRepository._privateConstructor();
  static final RecordRepository instance =
      RecordRepository._privateConstructor();
  final apiService = ApiService().service;

  Future<List<Record>> getRecords() async {
    final user = await SharedPreferenceService().instance.getUser();
    final params = {"userId": user.id.toString()};
    final data =
        await apiService.get(ApiURL.listRecordByUserId, params: params);
    if (data["result"] != null) {
      final listRecord =
          (data["result"] as Map<String, dynamic>)["list_record"];
      final list = (listRecord as List)
          .map<Record>((e) => Record.fromJson(e as Map<String, dynamic>))
          .toList();
      list.sort((a, b) => b.createDate.compareTo(a.createDate));
      return list ?? [];
    }

    return [];
  }

  Future<Map<String, dynamic>> createRecord(Record record) async {
    final body = record.toCreateJson();
    final data = await apiService.post(ApiURL.createRecord, body: body);
    return data["result"] as Map<String, dynamic>;
  }
}
