import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_app/model/wallet_model.dart';
import 'package:money_app/services/locator_service.dart';
import 'package:money_app/services/wallet_manager.dart';

class WalletCreatePage extends StatefulWidget {
  final bool isPrenventBack;

  const WalletCreatePage({Key key, this.isPrenventBack = false})
      : super(key: key);
  @override
  _WalletCreatePageState createState() => _WalletCreatePageState();
}

class _WalletCreatePageState extends State<WalletCreatePage> {
  String _title;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FormState get _formState => _formKey.currentState;
  WalletManager walletManager = locator<WalletManager>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !widget.isPrenventBack,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: !widget.isPrenventBack,
          centerTitle: false,
          title: const Text("Create Wallet"),
        ),
        body: Column(
          children: [
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [_buildTitle()]),
              ),
            ),
            const Spacer(),
            _bottomBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Title"),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.singleLineFormatter
      ],
      validator: (String value) {
        if (value.isEmpty) {
          return 'Title is required';
        }
        return null;
      },
      onSaved: (String value) {
        _title = value;
      },
    );
  }

  Future<void> onCreateWallet() async {
    if (_formState.validate()) {
      _formState.save();
      final Wallet wallet = Wallet(
        name: _title,
        createdDate: DateTime.now(),
      );
      final result = await walletManager.onCreateWallet(wallet);
      Navigator.of(context).pop<Wallet>(result);
    }
  }

  Widget _bottomBar() {
    return Column(
      children: [
        const Divider(height: 1),
        SizedBox(
          width: double.infinity,
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: onCreateWallet,
                child: const Text("Add"),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
