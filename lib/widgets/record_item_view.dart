import 'package:flutter/material.dart';
import 'package:money_app/helper/string_helper.dart';
import 'package:money_app/model/record_model.dart';
import 'package:money_app/ui/details_record.dart';
import 'package:money_app/view_models/home_viewmodel.dart';
import 'package:provider/provider.dart';

class RecordItemView extends StatelessWidget {
  final Record record;

  const RecordItemView({Key key, this.record}) : super(key: key);

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
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsRecord(record: record),
            ),
          );
          Provider.of<HomeViewModel>(context, listen: false).refresh();
          const snackBar = SnackBar(content: Text("Delete Record Success !"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
      ),
    );
  }
}
