import 'package:flutter/material.dart';
import 'package:money_app/model/wallet_model.dart';
import 'package:money_app/ui/wallet_create.dart';
import 'package:money_app/view_models/home_viewmodel.dart';
import 'package:provider/provider.dart';

class WalletList extends StatefulWidget {
  final List<Wallet> wallets;

  const WalletList({Key key, this.wallets}) : super(key: key);

  @override
  _WalletListState createState() => _WalletListState();
}

class _WalletListState extends State<WalletList> {
  final HomeViewModel _homeViewModel = HomeViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (_) => _homeViewModel,
      child: Consumer<HomeViewModel>(
        builder: (context, value, child) => Scaffold(
          backgroundColor: Colors.grey.shade50,
          appBar: AppBar(
            title: const Text("List Wallet"),
          ),
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).pop(Wallet(id: "all"));
                    },
                    leading: const CircleAvatar(
                      backgroundColor: Colors.black12,
                      child: FlutterLogo(),
                    ),
                    title: const Text("All"),
                    subtitle: const Text(""),
                  ),
                ),
              ),
              const Divider(),
              ...(value.listWallet ?? []).map((e) => walletView(e)).toList()
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              Navigator.of(context).push<bool>(
                MaterialPageRoute(
                  builder: (context) => WalletCreatePage(
                    homeViewModel: _homeViewModel,
                  ),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
        ),
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
          leading: CircleAvatar(
            backgroundColor: Colors.black12,
            child: Text(
              "${wallet.id}",
              style: const TextStyle(color: Colors.black),
            ),
          ),
          title: Text(wallet.name),
          subtitle: const Text(""),
        ),
      ),
    );
  }
}
