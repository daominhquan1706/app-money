import 'package:cloud_firestore/cloud_firestore.dart';

class TypeRecord {
  String id;
  String name;
  String imageUrl;
  String uid;
  String walletId;
  TypeRecord({this.id, this.name, this.imageUrl, this.uid, this.walletId});

  factory TypeRecord.fromJson(Map<String, dynamic> json) {
    return TypeRecord(
      id: json['id'] as String,
      name: json['typeRecord_name'] as String,
      imageUrl: json['image_url'] as String,
      uid: json['uid'] as String,
      walletId: json['wallet_id'] as String,
    );
  }

  TypeRecord.fromSnapshot(QueryDocumentSnapshot snapshot) {
    id = snapshot.id;
    name = snapshot.get('typeRecord_name') as String;
    imageUrl = snapshot.get('image_url') as String;
    uid = snapshot.get('uid') as String;
    walletId = snapshot.get('wallet_id') as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['id'] = id;
    data['typeRecord_name'] = name;
    data['image_url'] = imageUrl;
    data['uid'] = uid;
    data['wallet_id'] = walletId;
    return data;
  }
}
