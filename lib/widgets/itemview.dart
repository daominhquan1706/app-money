import 'package:flutter/material.dart';
import 'package:money_app/helper/string_helper.dart';
import 'package:money_app/model/record.dart';
import 'package:money_app/ui/details_record.dart';

class ItemView extends StatelessWidget {
  final Record record;

  const ItemView({Key key, this.record}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListTile(
        leading: const CircleAvatar(),
        title: Text(record.title),
        subtitle: Text(record.note),
        trailing: Text(
          StringHelper.instance.getMoneyText(record.amount),
          style: TextStyle(color: record.isAdd ? Colors.blue : Colors.red),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsRecord(record: record)),
          );
        },
      ),
    );
  }
}
