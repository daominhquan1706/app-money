import 'package:intl/intl.dart';

class Record {
  int id;
  DateTime createDate;
  String title;
  String note;
  double amount;
  bool isAdd;

  Record(
      {this.id,
      this.createDate,
      this.title,
      this.note,
      this.amount,
      this.isAdd});

  Record.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    //"10/03/2019",
    createDate = DateFormat("M/d/yyyy").parse(json['createDate'] as String);
    title = json['title'] as String;
    note = json['note'] as String;
    amount = double.parse(json['amount'].toString());
    isAdd = json['isAdd'] as bool;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createDate'] = createDate;
    data['title'] = title;
    data['note'] = note;
    data['amount'] = amount;
    data['isAdd'] = isAdd;
    return data;
  }
}
