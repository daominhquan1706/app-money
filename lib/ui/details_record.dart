import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_app/helper/string_helper.dart';
import 'package:money_app/model/record_model.dart';
import 'package:money_app/view_models/home_viewmodel.dart';

class DetailsRecord extends StatefulWidget {
  final Record record;

  const DetailsRecord({Key key, this.record}) : super(key: key);

  @override
  _DetailsRecordState createState() => _DetailsRecordState();
}

class _DetailsRecordState extends State<DetailsRecord> {
  final HomeViewModel _homeViewModel = HomeViewModel().instance;

  @override
  Widget build(BuildContext context) {
    final record = widget.record;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail of Record"),
        actions: [
          //IconButton(icon: const Icon(Icons.share), onPressed: () {}),
          IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
          IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                final dynamic isAccept = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Do you want to Delete this Record"),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return Colors.green;
                                }
                                return null; // Use the component's default.
                              },
                            ),
                          ),
                          child: const Text(
                            "Cancel",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          //color: Colors.redAccent,
                          child: const Text("Delete"),
                        ),
                      ],
                    );
                  },
                );

                if (isAccept is bool && isAccept) {
                  _homeViewModel.deleteRecord(widget.record);
                  Navigator.pop(context);
                }
              }),
        ],
      ),
      body: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(record.title),
              leading: const CircleAvatar(),
            ),
            ListTile(
              title: Text(
                "${StringHelper.instance.getMoneyText(record.amount)} đ",
                style:
                    TextStyle(color: record.isAdd ? Colors.blue : Colors.red),
              ),
              leading: const SizedBox.shrink(),
            ),
            ListTile(
              title: Text(record.note),
              leading: const Icon(Icons.note),
            ),
            ListTile(
              title:
                  Text(DateFormat('EEEE, d/M/yyyy').format(record.createDate)),
              leading: const Icon(Icons.calendar_today_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
