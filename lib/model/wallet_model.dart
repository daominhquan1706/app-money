import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_app/helper/datetime_helper.dart';

class Wallet {
  String id;
  String name;
  DateTime createdDate;
  DateTime modifiedDate;
  String uid;

  Wallet({this.id, this.name, this.createdDate, this.modifiedDate, this.uid});

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
        id: json['id'] as String,
        name: json['wallet_name'] as String,
        createdDate: DateTimeHelper.instance.listIntToDate(
            (json['created_date'] as List).map((s) => s as int).toList()),
        modifiedDate: DateTimeHelper.instance.listIntToDate(
            (json['modified_date'] as List).map((s) => s as int).toList()),
        uid: json['uid'] as String);
  }

  Wallet.fromSnapshot(QueryDocumentSnapshot snapshot) {
    id = snapshot.get('id') as String ?? snapshot.id;
    name = snapshot.get('wallet_name') as String;
    createdDate = DateTimeHelper.instance
        .stampTimeToDate(snapshot.get('created_date') as Timestamp);
    modifiedDate = DateTimeHelper.instance
        .stampTimeToDate(snapshot.get('modified_date') as Timestamp);
    uid = snapshot.get('uid') as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['wallet_name'] = name;
    data['created_date'] = createdDate;
    data['modified_date'] = modifiedDate;
    data['uid'] = uid;
    return data;
  }
}
