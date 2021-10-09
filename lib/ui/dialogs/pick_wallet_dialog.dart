import 'package:flutter/material.dart';
import 'package:money_app/model/wallet_model.dart';
import 'package:money_app/services/locator_service.dart';
import 'package:money_app/services/wallet_manager.dart';

import '../wallet_create.dart';

class PickWalletDialog extends StatelessWidget {
  PickWalletDialog({Key key}) : super(key: key);
  final WalletManager walletManager = locator<WalletManager>();
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
                    builder: (context) => const WalletCreatePage(),
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
          children: walletManager.listWallet.isNotEmpty
              ? walletManager.listWallet.map(
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
                        trailing: walletManager.currentWallet?.id == wallet.id
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
