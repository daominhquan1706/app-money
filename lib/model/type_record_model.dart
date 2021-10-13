import 'package:cloud_firestore/cloud_firestore.dart';

class TypeRecord {
  String id;
  String name;
  String imageUrl;
  String uid;
  String walletId;
  int type; // Tiền chi = 0 , Tiền thu = 1
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
      type: json['type'] as int,
      orderIndex: json['order_index'] as int,
    );
  }

  TypeRecord.fromSnapshot(QueryDocumentSnapshot snapshot) {
    id = snapshot.id;
    name = snapshot.get('typeRecord_name') as String;
    imageUrl = snapshot.get('image_url') as String;
    uid = snapshot.get('uid') as String;
    walletId = snapshot.get('wallet_id') as String;
    type = snapshot.get('type') as int;
    orderIndex = snapshot.get('order_index') as int;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['id'] = id;
    data['typeRecord_name'] = name;
    data['image_url'] = imageUrl;
    data['uid'] = uid;
    data['wallet_id'] = walletId;
    data['type'] = type;
    data['order_index'] = orderIndex;
    return data;
  }
}

final listTypeRecordDefault = [
  //Tiền chi
  TypeRecord(name: "Chi tiêu hàng ngày", type: 0, orderIndex: 0),
  TypeRecord(name: "Tiền nhà", type: 0, orderIndex: 1),
  TypeRecord(name: "Ăn uống", type: 0, orderIndex: 2),
  TypeRecord(name: "Quần áo", type: 0, orderIndex: 3),
  TypeRecord(name: "Mỹ phẩm", type: 0, orderIndex: 4),
  TypeRecord(name: "Y tế", type: 0, orderIndex: 5),
  TypeRecord(name: "Giáo dục", type: 0, orderIndex: 6),
  TypeRecord(name: "Tiền điện", type: 0, orderIndex: 7),
  TypeRecord(name: "Đi lại", type: 0, orderIndex: 8),
//Tiền thu
  TypeRecord(name: "Tiền lương", type: 1, orderIndex: 0),
  TypeRecord(name: "Tiền phụ cấp", type: 1, orderIndex: 1),
  TypeRecord(name: "Tiền thưởng", type: 1, orderIndex: 2),
  TypeRecord(name: "Thu nhập phụ", type: 1, orderIndex: 3),
  TypeRecord(name: "Đầu tư", type: 1, orderIndex: 4),
  TypeRecord(name: "Thu nhập tạm thời", type: 1, orderIndex: 5),
];
