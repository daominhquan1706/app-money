import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_app/model/record_model.dart';
import 'package:money_app/model/type_record_model.dart';
import 'package:money_app/model/wallet_model.dart';
import 'package:money_app/view_models/home_viewmodel.dart';
import 'package:money_app/view_models/record_create_viewmodel.dart';
import 'package:money_app/widgets/custom_input_field.dart';
import 'package:provider/provider.dart';

class AddRecord extends StatefulWidget {
  @override
  _AddRecordState createState() => _AddRecordState();
}

class _AddRecordState extends State<AddRecord> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RecordCreateViewModel _viewModel = RecordCreateViewModel();
  final HomeViewModel _homeViewModel = HomeViewModel().instance;
  final TextEditingController _dateTextController = TextEditingController();
  final TextEditingController _walletTextController = TextEditingController();
  final TextEditingController _typeRecordTextController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _dateTextController.text = _viewModel.dateString;
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
                    _buildTitle(),
                    _buildAmount(),
                    _buildDate(),
                    _buildTypeRecord(),
                    _buildWallet(),
                    _buildNote(),
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
    return CustomInputField(
      inputType: InputType.amount,
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
    return CustomInputField(
      inputType: InputType.title,
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
    return CustomInputField(
      inputType: InputType.note,
      validator: (String value) {
        return null;
      },
      onSaved: (String value) {
        _viewModel.note = value;
      },
    );
  }

  Widget _buildDate() {
    return CustomInputField(
      controller: _dateTextController,
      inputType: InputType.date,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Date isRequired';
        }
        return null;
      },
      onTap: _showDatePicker,
      trailingIcon: Icons.calendar_today,
    );
  }

  void _showDatePicker() {
    // showCupertinoModalPopup is a built-in function of the cupertino library
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 500,
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: [
            SizedBox(
              height: 400,
              child: CupertinoDatePicker(
                initialDateTime: DateTime.now(),
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (picked) {
                  setState(() {
                    if (picked != null && picked != _viewModel.date) {
                      setState(() {
                        _viewModel.date = picked;
                        _dateTextController.text = _viewModel.dateString;
                      });
                    }
                  });
                },
              ),
            ),
            CupertinoButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildWallet() {
    return CustomInputField(
      controller: _walletTextController,
      inputType: InputType.wallet,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Wallet isRequired';
        }
        return null;
      },
      onTap: _selectWallet,
      trailingIcon: Icons.account_balance_wallet,
    );
  }

  Widget _buildTypeRecord() {
    return CustomInputField(
      controller: _typeRecordTextController,
      inputType: InputType.typeRecord,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Wallet isRequired';
        }
        return null;
      },
      onTap: _selectTypeRecord,
    );
  }

  Future _selectWallet() async {
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
              : [const ListTile(title: Text("Empty Wallet"))],
        );
      },
    );
    if (wallet == null) {
      return;
    }
    _viewModel.onPickWallet(wallet);
    _walletTextController.text = wallet.name;
    _typeRecordTextController.text = null;
  }

  Future _selectTypeRecord() async {
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
              : [const ListTile(title: Text("Empty Type Record"))],
        );
      },
    );
    if (typeRecord == null) {
      return;
    }
    _viewModel.onPickTypeRecord(typeRecord);
    _typeRecordTextController.text = typeRecord.name;
  }
}
