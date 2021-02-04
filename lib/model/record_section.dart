import 'package:money_app/model/record.dart';

class RecordSection {
  DateTime date;
  List<Record> list;
  RecordSection({this.date, this.list});

  double sumAmount() {
    return list
        .map((e) => e.isAdd ? e.amount : 0 - e.amount)
        .reduce((a, b) => a + b);
  }
}
