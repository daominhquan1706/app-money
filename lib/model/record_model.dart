import 'package:money_app/helper/datetime_helper.dart';

class Record {
  int id;
  String title;
  String note;
  double amount;
  bool isAdd;
  DateTime date;
  DateTime createDate;
  DateTime modifiedDate;
  int walletId;
  int typeRecordId;

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
    typeRecordId = json['typeRecord_id'] as int;
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
    return data;
  }
}
