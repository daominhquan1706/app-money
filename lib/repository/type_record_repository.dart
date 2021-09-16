import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_app/constants/constant.dart';
import 'package:money_app/model/type_record_model.dart';
import 'package:money_app/services/api_service.dart';
import 'package:money_app/services/login_manager.dart';
import 'package:money_app/view_models/login_viewmodel.dart';

class TypeRecordRepository {
  TypeRecordRepository._privateConstructor();
  static final TypeRecordRepository instance =
      TypeRecordRepository._privateConstructor();
  final apiService = ApiService().instance;
  CollectionReference typeRecordRef =
      FirebaseFirestore.instance.collection(CollectionName.typeRecord);

  Future<List<TypeRecord>> getTypeRecords(String walletId) async {
    final snapshot = await typeRecordRef
        .where('uid', isEqualTo: LoginManager.instance.user.uid)
        .get();
    final typeRecords = snapshot.docs
        .map((QueryDocumentSnapshot documentSnapshot) =>
            TypeRecord.fromSnapshot(documentSnapshot))
        .toList();
    return typeRecords;
  }

  Future<TypeRecord> createTypeRecord(TypeRecord typeRecord) async {
    final value = await typeRecordRef.add(typeRecord.toJson());
    typeRecord.id = value.id;
    return typeRecord;
  }
}
