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
    id = json['id'];
    //"10/03/2019",
    createDate = new DateFormat("M/d/yyyy").parse(json['createDate']);
    title = json['title'];
    note = json['note'];
    amount = json['amount'].toDouble();
    isAdd = json['isAdd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createDate'] = this.createDate;
    data['title'] = this.title;
    data['note'] = this.note;
    data['amount'] = this.amount;
    data['isAdd'] = this.isAdd;
    return data;
  }
}
