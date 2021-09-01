import 'package:flutter/material.dart';
import 'package:money_app/model/wallet_model.dart';
import 'package:money_app/view_models/record_create_viewmodel.dart';

class PickWalletDialog extends StatelessWidget {
  PickWalletDialog({Key key}) : super(key: key);
  final RecordCreateViewModel _viewModel = RecordCreateViewModel().instance;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Pick Wallet"),
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
      content: SingleChildScrollView(
        child: Column(
          children: _viewModel.listWallet.isNotEmpty
              ? _viewModel.listWallet.map(
                  (wallet) {
                    return Card(
                      child: ListTile(
                        title: Text(
                          wallet.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        leading: const Icon(Icons.account_balance_wallet),
                        onTap: () {
                          Navigator.of(context).pop<Wallet>(wallet);
                        },
                        trailing: _viewModel.wallet?.id == wallet.id
                            ? const Icon(
                                Icons.check_circle,
                                color: Colors.green,
                              )
                            : const SizedBox.shrink(),
                      ),
                    );
                  },
                ).toList()
              : [const ListTile(title: Text("Empty Wallet"))],
        ),
      ),
    );
  }
}
