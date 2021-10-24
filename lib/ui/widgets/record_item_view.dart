import 'package:flutter/material.dart';
import 'package:money_app/helper/string_helper.dart';
import 'package:money_app/model/record_model.dart';
import 'package:money_app/ui/record_create.dart';
import 'package:money_app/view_models/home_viewmodel.dart';
import 'package:provider/provider.dart';

class RecordItemView extends StatelessWidget {
  final Record record;

  const RecordItemView({Key key, this.record}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.black12),
        ),
      ),
      child: ListTile(
        // leading: const CircleAvatar(),
        title: Text(
          record.title ?? "",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Text(
          "${StringHelper.instance.getMoneyText(record.amount)}đ",
          style: TextStyle(
            color: record.isAdd ? Colors.blue : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEditRecord(
                isEdit: true,
                record: record,
              ),
            ),
          );
          Provider.of<HomeViewModel>(context, listen: false).refresh();
        },
      ),
    );
  }
}
