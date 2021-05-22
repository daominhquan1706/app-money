import 'package:money_app/helper/datetime_helper.dart';

class Wallet {
  int id;
  String name;
  DateTime createdDate;
  DateTime modifiedDate;
  int userId;

  Wallet({this.id, this.name, this.createdDate, this.modifiedDate});

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
        id: json['id'] as int,
        name: json['wallet_name'] as String,
        createdDate: DateTimeHelper.instance
            .listIntToDate((json['created_date'] as List).map((s) => s as int).toList()),
        modifiedDate: DateTimeHelper.instance
            .listIntToDate((json['modified_date'] as List).map((s) => s as int).toList()));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['wallet_name'] = name;
    data['created_date'] = createdDate;
    data['modified_date'] = modifiedDate;
    return data;
  }

  Map<String, dynamic> toCreateJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['wallet_name'] = name;
    return data;
  }
}
