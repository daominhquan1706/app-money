import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:money_app/model/record_model.dart';
import 'package:money_app/model/type_record_model.dart';
import 'package:money_app/model/wallet_model.dart';
import 'package:money_app/view_models/home_viewmodel.dart';
import 'package:money_app/view_models/record_create_viewmodel.dart';
import 'package:provider/provider.dart';

class AddRecord extends StatefulWidget {
  @override
  _AddRecordState createState() => _AddRecordState();
}

class _AddRecordState extends State<AddRecord> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RecordCreateViewModel _viewModel = RecordCreateViewModel();
  final HomeViewModel _homeViewModel = HomeViewModel.instance;

  @override
  void initState() {
    super.initState();
  }

  FormState get _formState => _formKey.currentState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          "Create Record",
        ),
        actions: [
          FlatButton(
            onPressed: () async {
              if (_formState.validate()) {
                _formState.save();
                final Record record = Record(
                  createDate: DateTime.now(),
                  amount: _viewModel.amount,
                  title: _viewModel.title,
                  isAdd: _viewModel.amount >= 0,
                  walletId: _viewModel.wallet.id,
                  typeRecordId: _viewModel.typeRecord.id,
                  note: _viewModel.note,
                  date: _viewModel.date,
                );
                final success = await _homeViewModel.onCreateRecord(record);
                if (success == "SUCCESS") {
                  Navigator.of(context).pop();
                } else {
                  final snackBar = SnackBar(content: Text(success ?? "FAIL"));
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
        child: ChangeNotifierProvider<RecordCreateViewModel>(
          create: (_) => _viewModel,
          child: Consumer<RecordCreateViewModel>(
            builder: (context, viewModel, child) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    _buildAmount(),
                    _buildTitle(),
                    _buildNote(),
                    _buildDate(),
                    _buildWallet(),
                    _buildTypeRecord(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAmount() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Amount"),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Amount isRequired';
        }
        try {
          double.parse(value);
        } catch (_) {
          return 'invalid format';
        }
        return null;
      },
      onSaved: (String value) {
        _viewModel.amount = double.parse(value);
      },
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
          return 'Title isRequired';
        }
        return null;
      },
      onSaved: (String value) {
        _viewModel.title = value;
      },
    );
  }

  Widget _buildNote() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Note"),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.singleLineFormatter
      ],
      validator: (String value) {
        return null;
      },
      onSaved: (String value) {
        _viewModel.note = value;
      },
    );
  }

  Widget _buildDate() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: const Text("Date :   "),
        ),
        Expanded(
          flex: 3,
          child: ElevatedButton(
            onPressed: () async {
              final DateTime picked = await showDatePicker(
                context: context,
                initialDate: _viewModel.date,
                firstDate: DateTime(2000),
                lastDate: DateTime(2025),
              );
              if (picked != null && picked != _viewModel.date) {
                setState(() {
                  _viewModel.date = picked;
                });
              }
            },
            child: Text(DateFormat('dd-MM-yyyy').format(_viewModel.date)),
          ),
        )
      ],
    );
  }

  Widget _buildWallet() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: const Text("Wallet :   "),
        ),
        Expanded(
          flex: 3,
          child: ElevatedButton(
            onPressed: () {
              _selectWallet(context);
            },
            child: Text(_viewModel.wallet != null
                ? _viewModel.wallet.name
                : "Please Pick Wallet"),
          ),
        )
      ],
    );
  }

  Widget _buildTypeRecord() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: const Text("Type Record :   "),
        ),
        Expanded(
          flex: 3,
          child: ElevatedButton(
            onPressed: () {
              _selectTypeRecord(context);
            },
            child: Text(_viewModel.typeRecord != null
                ? _viewModel.typeRecord.name
                : "Type Record"),
          ),
        )
      ],
    );
  }

  Future _selectWallet(BuildContext context) async {
    final Wallet wallet = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text("Pick Wallet"),
          children: _viewModel.listWallet.isNotEmpty
              ? _viewModel.listWallet.map(
                  (wallet) {
                    return Card(
                      child: ListTile(
                        title: Text(wallet.name),
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
              : [const Text("Dont you dont have wallet")],
        );
      },
    );
    if (wallet == null) {
      return;
    }
    _viewModel.onPickWallet(wallet);
  }

  Future _selectTypeRecord(BuildContext context) async {
    final TypeRecord typeRecord = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text("Pick Type Record"),
          children: _viewModel.listTypeRecord.isNotEmpty
              ? _viewModel.listTypeRecord.map(
                  (typeRecord) {
                    return Card(
                      child: ListTile(
                        title: Text(typeRecord.name),
                        leading: const Icon(Icons.account_balance_wallet),
                        onTap: () {
                          Navigator.of(context).pop<TypeRecord>(typeRecord);
                        },
                        trailing: _viewModel.typeRecord?.id == typeRecord.id
                            ? const Icon(
                                Icons.check_circle,
                                color: Colors.green,
                              )
                            : const SizedBox.shrink(),
                      ),
                    );
                  },
                ).toList()
              : [const Text("Dont you dont have wallet")],
        );
      },
    );
    if (typeRecord == null) {
      return;
    }
    _viewModel.onPickTypeRecord(typeRecord);
  }
}
