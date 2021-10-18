import 'package:cloud_firestore/cloud_firestore.dart';

enum TypeRecordType { income, outcome }

class TypeRecord {
  String id;
  String name;
  String imageUrl;
  String uid;
  String walletId;
  TypeRecordType type; // Tiền chi = 0 , Tiền thu = 1
  int orderIndex;
  TypeRecord({
    this.id,
    this.name,
    this.imageUrl,
    this.uid,
    this.walletId,
    this.type,
    this.orderIndex,
  });

  factory TypeRecord.fromJson(Map<String, dynamic> json) {
    return TypeRecord(
      id: json['id'] as String,
      name: json['typeRecord_name'] as String,
      imageUrl: json['image_url'] as String,
      uid: json['uid'] as String,
      walletId: json['wallet_id'] as String,
      type: (json['type'] as int) == 0
          ? TypeRecordType.outcome
          : TypeRecordType.income,
      orderIndex: json['order_index'] as int,
    );
  }

  TypeRecord.fromSnapshot(QueryDocumentSnapshot snapshot) {
    id = snapshot.id;
    name = snapshot.get('typeRecord_name') as String;
    imageUrl = snapshot.get('image_url') as String;
    uid = snapshot.get('uid') as String;
    walletId = snapshot.get('wallet_id') as String;
    type = (snapshot.get('type') as int) == 0
        ? TypeRecordType.outcome
        : TypeRecordType.income;
    orderIndex = snapshot.get('order_index') as int;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['id'] = id;
    data['typeRecord_name'] = name;
    data['image_url'] = imageUrl;
    data['uid'] = uid;
    data['wallet_id'] = walletId;
    data['type'] = type == TypeRecordType.outcome ? 0 : 1;
    data['order_index'] = orderIndex;
    return data;
  }
}

final listTypeRecordDefault = [
  //Tiền chi
  TypeRecord(
      name: "Chi tiêu hàng ngày", type: TypeRecordType.outcome, orderIndex: 0),
  TypeRecord(name: "Tiền nhà", type: TypeRecordType.outcome, orderIndex: 1),
  TypeRecord(name: "Ăn uống", type: TypeRecordType.outcome, orderIndex: 2),
  TypeRecord(name: "Quần áo", type: TypeRecordType.outcome, orderIndex: 3),
  TypeRecord(name: "Mỹ phẩm", type: TypeRecordType.outcome, orderIndex: 4),
  TypeRecord(name: "Y tế", type: TypeRecordType.outcome, orderIndex: 5),
  TypeRecord(name: "Giáo dục", type: TypeRecordType.outcome, orderIndex: 6),
  TypeRecord(name: "Tiền điện", type: TypeRecordType.outcome, orderIndex: 7),
  TypeRecord(name: "Đi lại", type: TypeRecordType.outcome, orderIndex: 8),
//Tiền thu
  TypeRecord(name: "Tiền lương", type: TypeRecordType.income, orderIndex: 0),
  TypeRecord(name: "Tiền phụ cấp", type: TypeRecordType.income, orderIndex: 1),
  TypeRecord(name: "Tiền thưởng", type: TypeRecordType.income, orderIndex: 2),
  TypeRecord(name: "Thu nhập phụ", type: TypeRecordType.income, orderIndex: 3),
  TypeRecord(name: "Đầu tư", type: TypeRecordType.income, orderIndex: 4),
  TypeRecord(
      name: "Thu nhập tạm thời", type: TypeRecordType.income, orderIndex: 5),
];
