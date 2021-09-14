import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_app/helper/datetime_helper.dart';

class Record {
  String id;
  String title;
  String note;
  double amount;
  bool isAdd;
  DateTime date;
  DateTime createDate;
  DateTime modifiedDate;
  String walletId;
  int typeRecordId;
  String uid;

  Record({
    this.id,
    this.title,
    this.note,
    this.amount,
    this.isAdd,
    this.date,
    this.createDate,
    this.modifiedDate,
    this.walletId,
    this.typeRecordId,
  });

  Record.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String;
    createDate =
        DateTimeHelper.instance.stringToDate(json['created_date'] as String);
    title = json['title'] as String;
    note = json['note'] as String;
    amount = double.parse(json['amount'].toString());
    isAdd = amount >= 0;
    walletId = json['wallet_id'] as String;
    typeRecordId = json['typeRecord_id'] as int;
    uid = json['uid'] as String;
  }

  Record.fromSnapshot(QueryDocumentSnapshot snapshot) {
    id = snapshot.get('id') as String;
    createDate = DateTimeHelper.instance
        .stringToDate(snapshot.get('created_date') as String);
    title = snapshot.get('title') as String;
    note = snapshot.get('note') as String;
    amount = double.parse(snapshot.get('amount').toString());
    isAdd = amount >= 0;
    walletId = snapshot.get('wallet_id') as String;
    typeRecordId = snapshot.get('typeRecord_id') as int;
    uid = snapshot.get('uid') as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_date'] = createDate;
    data['title'] = title;
    data['note'] = note;
    data['amount'] = amount;
    data['isAdd'] = isAdd;
    data['uid'] = uid;
    return data;
  }

  Map<String, dynamic> toCreateJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // "date": "01/01/2021",
    // "title": "Record title example",
    // "note": "Record note example",
    // "amount": 100000,
    // "wallet_id": 10,
    // "typeRecord_id": 1
    data["date"] = DateTimeHelper.instance.dateToString(date);
    data["title"] = title;
    data["note"] = note;
    data["amount"] = amount;
    data["wallet_id"] = walletId;
    data["typeRecord_id"] = typeRecordId;
    data['uid'] = uid;
    return data;
  }
}
