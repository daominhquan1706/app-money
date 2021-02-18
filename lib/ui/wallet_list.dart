import 'package:flutter/material.dart';
import 'package:money_app/model/wallet_model.dart';
import 'package:money_app/view_models/home_viewmodel.dart';

class WalletList extends StatefulWidget {
  final List<Wallet> wallets;

  const WalletList({Key key, this.wallets}) : super(key: key);

  @override
  _WalletListState createState() => _WalletListState();
}

class _WalletListState extends State<WalletList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(),
      body: Column(
        children: (HomeViewModel.instance.listWallet ?? [])
            .map((e) => walletView(e))
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget walletView(Wallet wallet) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        child: ListTile(
          onTap: () {
            Navigator.of(context).pop(wallet);
          },
          leading: const CircleAvatar(
            backgroundColor: Colors.black12,
            child: FlutterLogo(),
          ),
          title: Text(wallet.name),
          subtitle: Text("Haha"),
        ),
      ),
    );
  }
}
