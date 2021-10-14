import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  String id;
  String title;
  String note;
  double amount;
  bool isAdd;
  // Timestamp date;
  Timestamp createDate;
  // Timestamp modifiedDate;
  String walletId;
  String typeRecordId;
  String uid;

  Record({
    this.id,
    this.title,
    this.note,
    this.amount,
    this.isAdd,
    this.createDate,
    this.walletId,
    this.typeRecordId,
  });

  Record.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String;
    createDate = json['created_date'] as Timestamp;
    title = json['title'] as String;
    note = json['note'] as String;
    amount = double.parse(json['amount'].toString());
    isAdd = amount >= 0;
    walletId = json['wallet_id'] as String;
    typeRecordId = json['typeRecord_id'] as String;
    uid = json['uid'] as String;
  }

  Record.fromSnapshot(QueryDocumentSnapshot snapshot) {
    id = snapshot.id;
    createDate = snapshot.get('created_date') as Timestamp;
    title = snapshot.get('title') as String;
    note = snapshot.get('note') as String;
    amount = double.parse(snapshot.get('amount').toString());
    isAdd = snapshot.get('isAdd') as bool;
    walletId = snapshot.get('wallet_id') as String;
    typeRecordId = snapshot.get('type_record_id') as String;
    uid = snapshot.get('uid') as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_date'] = createDate;
    data['title'] = title;
    data['note'] = note;
    data['amount'] = amount;
    data['isAdd'] = isAdd;
    data['uid'] = uid;
    data['wallet_id'] = walletId;
    data['type_record_id'] = typeRecordId;
    return data;
  }
}
