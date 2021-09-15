import 'package:flutter/material.dart';
import 'package:money_app/model/type_record_model.dart';
import 'package:money_app/ui/type_record_create.dart';
import 'package:money_app/view_models/record_create_viewmodel.dart';

class PickTypeRecord extends StatelessWidget {
  const PickTypeRecord({Key key, @required this.recordCreateViewModel})
      : super(key: key);
  final RecordCreateViewModel recordCreateViewModel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Pick Type Record"),
      content: SingleChildScrollView(
        child: Column(
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
                        trailing: recordCreateViewModel.typeRecord?.id ==
                                typeRecord.id
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
              onPressed: () async {
                final result = await Navigator.of(context).push<TypeRecord>(
                  MaterialPageRoute(
                    builder: (context) => TypeRecordCreatePage(
                      recordCreateViewModel: recordCreateViewModel,
                    ),
                  ),
                );
                Navigator.of(context).pop<TypeRecord>(result);
              },
              child: const Text("+ Add new"),
            ),
          ],
        ),
      ],
    );
  }
}
