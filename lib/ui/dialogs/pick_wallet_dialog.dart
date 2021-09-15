import 'package:flutter/material.dart';
import 'package:money_app/model/wallet_model.dart';
import 'package:money_app/view_models/record_create_viewmodel.dart';

import '../wallet_create.dart';

class PickWalletDialog extends StatelessWidget {
  const PickWalletDialog({Key key, this.recordCreateViewModel})
      : super(key: key);
  final RecordCreateViewModel recordCreateViewModel;
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
              onPressed: () async {
                final result = await Navigator.of(context).push<Wallet>(
                  MaterialPageRoute(
                    builder: (context) => WalletCreatePage(
                      homeViewModel: recordCreateViewModel.homeViewModel,
                    ),
                  ),
                );
                Navigator.of(context).pop<Wallet>(result);
              },
              child: const Text("+ Add new"),
            ),
          ],
        ),
      ],
      content: SingleChildScrollView(
        child: Column(
          children: recordCreateViewModel.listWallet.isNotEmpty
              ? recordCreateViewModel.listWallet.map(
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
                        trailing: recordCreateViewModel.wallet?.id == wallet.id
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
