import 'package:flutter/material.dart';
import 'package:money_app/model/wallet_model.dart';
import 'package:money_app/services/wallet_manager.dart';
import 'package:money_app/ui/wallet_create.dart';
import 'package:money_app/view_models/list_wallet_viewmodel.dart';
import 'package:provider/provider.dart';

class ListWalletPage extends StatefulWidget {
  final List<Wallet> wallets;

  const ListWalletPage({Key key, this.wallets}) : super(key: key);

  @override
  _ListWalletPageState createState() => _ListWalletPageState();
}

class _ListWalletPageState extends State<ListWalletPage> {
  final ListWalletViewModel _listWalletViewModel = ListWalletViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ListWalletViewModel>(
      create: (_) => _listWalletViewModel,
      child: Consumer<ListWalletViewModel>(
        builder: (context, value, child) => Scaffold(
          backgroundColor: Colors.grey.shade50,
          appBar: AppBar(
            title: const Text("List Wallet"),
          ),
          body: ListView(
            children: [
              if (value.listWallet.isNotEmpty) ...[
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
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              Navigator.of(context).push<bool>(
                MaterialPageRoute(
                  builder: (context) => WalletCreatePage(),
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
        color: WalletManager.instance.currentWallet.id == wallet.id
            ? Colors.green
            : Colors.white,
        child: ListTile(
          onTap: () {
            Navigator.of(context).pop<Wallet>(wallet);
          },
          leading: CircleAvatar(
            backgroundColor: Colors.black12,
            child: Text(
              wallet.id,
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
