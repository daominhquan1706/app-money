import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_app/model/wallet_model.dart';
import 'package:money_app/view_models/home_viewmodel.dart';

class WalletCreatePage extends StatefulWidget {
  @override
  _WalletCreatePageState createState() => _WalletCreatePageState();
}

class _WalletCreatePageState extends State<WalletCreatePage> {
  String _title;
  final HomeViewModel _homeViewModel = HomeViewModel.instance;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FormState get _formState => _formKey.currentState;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          "Create Wallet",
        ),
        actions: [
          FlatButton(
            onPressed: () async {
              if (_formState.validate()) {
                _formState.save();
                final Wallet wallet = Wallet(
                  name: _title,
                  createdDate: DateTime.now(),
                );

                final message = await _homeViewModel.onCreateWallet(wallet);
                if (message == "SUCCESS") {
                  Navigator.of(context).pop();
                } else {
                  final snackBar = SnackBar(content: Text(message ?? "FAIL"));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              }
            },
            child: const Text(
              "Add",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _buildTitle(),
            ],
          ),
        ),
      ),
    );
    return scaffold;
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
}
