import 'package:money_app/helper/datetime_helper.dart';

class Wallet {
  int id;
  String name;
  DateTime createdDate;
  DateTime modifiedDate;

  Wallet({this.id, this.name, this.createdDate, this.modifiedDate});

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
        id: json['id'] as int,
        name: json['wallet_name'] as String,
        createdDate: DateTimeHelper.instance
            .stringToDate(json['created_date'] as String),
        modifiedDate: DateTimeHelper.instance
            .stringToDate(json['modified_date'] as String));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['wallet_name'] = name;
    data['created_date'] = createdDate;
    data['modified_date'] = modifiedDate;
    return data;
  }
}
