import 'package:flutter/material.dart';
import 'package:money_app/model/type_record_model.dart';
import 'package:money_app/view_models/record_create_viewmodel.dart';

class PickTypeRecord extends StatelessWidget {
  PickTypeRecord({Key key, this.recordCreateViewModel}) : super(key: key);
  final RecordCreateViewModel recordCreateViewModel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Pick Type Record"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: recordCreateViewModel.listTypeRecord.isNotEmpty
            ? recordCreateViewModel.listTypeRecord.map(
                (typeRecord) {
                  return Card(
                    child: ListTile(
                      title: Text(typeRecord.name),
                      leading: const Icon(Icons.account_balance_wallet),
                      onTap: () {
                        Navigator.of(context).pop<TypeRecord>(typeRecord);
                      },
                      trailing:
                          recordCreateViewModel.typeRecord?.id == typeRecord.id
                              ? const Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                )
                              : const SizedBox.shrink(),
                    ),
                  );
                },
              ).toList()
            : [const ListTile(title: Text("Empty Type Record"))],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Close",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("+ Add new"),
            ),
          ],
        ),
      ],
    );
  }
}
