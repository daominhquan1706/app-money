import 'package:money_app/helper/datetime_helper.dart';

class Record {
  int id;
  DateTime createDate;
  String title;
  String note;
  double amount;
  bool isAdd;
  DateTime createdDate;
  DateTime modifiedDate;
  int walletId;

  Record({
    this.id,
    this.createDate,
    this.title,
    this.note,
    this.amount,
    this.isAdd,
    this.walletId,
  });

  Record.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    //"10/03/2019",
    //2021-04-04T08:26:03
    createDate =
        DateTimeHelper.instance.stringToDate(json['created_date'] as String);
    title = json['title'] as String;
    note = json['note'] as String;
    amount = double.parse(json['amount'].toString());
    isAdd = amount >= 0;
    walletId = json['wallet_id'] as int;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_date'] = createDate;
    data['title'] = title;
    data['note'] = note;
    data['amount'] = amount;
    data['isAdd'] = isAdd;
    return data;
  }
}
