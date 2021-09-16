import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_app/constants/constant.dart';
import 'package:money_app/model/record_model.dart';
import 'package:money_app/services/locator_service.dart';
import 'package:money_app/services/shared_preference_service.dart';

class RecordRepository {
  static final RecordRepository instance = locator<RecordRepository>();

  final CollectionReference _recordRef =
      FirebaseFirestore.instance.collection(CollectionName.record);
  final SharedPreferenceService _sharedPreferenceService =
      SharedPreferenceService().instance;

  Future<List<Record>> getRecords() async {
    final user = await _sharedPreferenceService.getUser();
    final snapshot = await _recordRef.where('uid', isEqualTo: user.id).get();
    final records = snapshot.docs
        .map((QueryDocumentSnapshot documentSnapshot) =>
            Record.fromSnapshot(documentSnapshot))
        .toList();
    records.sort((a, b) => b.createDate.compareTo(a.createDate));
    return records;
  }

  Future<Record> createRecord(Record record) async {
    final value = await _recordRef.add(record.toJson());
    record.id = value.id;
    return record;
  }
}
