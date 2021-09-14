import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_app/constants/constant.dart';
import 'package:money_app/model/record_model.dart';
import 'package:money_app/services/api_service.dart';
import 'package:money_app/services/shared_preference_service.dart';
import 'package:money_app/view_models/login_viewmodel.dart';

class RecordRepository {
  RecordRepository._privateConstructor();
  static final RecordRepository instance =
      RecordRepository._privateConstructor();
  final apiService = ApiService().service;
  CollectionReference recordRef =
      FirebaseFirestore.instance.collection(CollectionName.record);

  Future<List<Record>> getRecords() async {
    final snapshot = await recordRef
        .where('uid', isEqualTo: LoginViewModel().instance.user.uid)
        .get();
    final records = snapshot.docs
        .map((QueryDocumentSnapshot documentSnapshot) =>
            Record.fromSnapshot(documentSnapshot))
        .toList();
    records.sort((a, b) => b.createDate.compareTo(a.createDate));
    return records;
    // final user = await SharedPreferenceService().instance.getUser();
    // final params = {"userId": user.id.toString()};
    // final data =
    //     await apiService.get(ApiURL.listRecordByUserId, params: params);
    // if (data["result"] != null) {
    //   final listRecord =
    //       (data["result"] as Map<String, dynamic>)["list_record"];
    //   final list = (listRecord as List)
    //       .map<Record>((e) => Record.fromJson(e as Map<String, dynamic>))
    //       .toList();
    //   list.sort((a, b) => b.createDate.compareTo(a.createDate));
    //   return list ?? [];
    // }
    //
    // return [];
  }

  Future<Record> createRecord(Record record) async {
    final value = await recordRef.add(record.toJson());
    record.id = value.id;
    return record;
  }
}
