import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
            title: const Text("Danh sách ví"),
          ),
          body: ListView(
            children: [
              if (value.listWallet.isNotEmpty) ...[
                ...(value.listWallet ?? []).map((e) => walletView(e)).toList()
              ],
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              Navigator.of(context).push<Wallet>(
                MaterialPageRoute(
                  builder: (context) =>
                      WalletCreatePage(viewModel: _listWalletViewModel),
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
    final bool isSelect = WalletManager.instance.currentWallet?.id == wallet.id;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        color: isSelect ? Colors.green.shade100 : Colors.white,
        child: ListTile(
          onTap: () {
            Navigator.of(context).pop<Wallet>(wallet);
          },
          leading: CircleAvatar(
            backgroundColor: isSelect ? Colors.green : Colors.black12,
            child: const FaIcon(
              FontAwesomeIcons.wallet,
              color: Colors.white,
            ),
          ),
          title: Text(wallet.name),
          subtitle: const Text(""),
        ),
      ),
    );
  }
}
