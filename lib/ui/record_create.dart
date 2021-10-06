import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_app/model/record_model.dart';
import 'package:money_app/model/type_record_model.dart';
import 'package:money_app/model/wallet_model.dart';
import 'package:money_app/view_models/home_viewmodel.dart';
import 'package:money_app/view_models/record_create_viewmodel.dart';
import 'package:money_app/widgets/custom_input_field.dart';
import 'package:provider/provider.dart';
import 'package:stacked_services/stacked_services.dart';

import 'dialogs/pick_type_record.dart';
import 'dialogs/pick_wallet_dialog.dart';

class AddRecord extends StatefulWidget {
  final HomeViewModel homeViewModel;

  const AddRecord({Key key, this.homeViewModel}) : super(key: key);

  @override
  _AddRecordState createState() => _AddRecordState();
}

class _AddRecordState extends State<AddRecord> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RecordCreateViewModel _viewModel = RecordCreateViewModel();
  final TextEditingController _dateTextController = TextEditingController();
  final TextEditingController _walletTextController = TextEditingController();
  final TextEditingController _typeRecordTextController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _dateTextController.text = DateFormat.yMMMd().format(DateTime.now());
    _viewModel.initialize().then((value) {
      _walletTextController.text = _viewModel.wallet?.name ?? "";
      _typeRecordTextController.text = _viewModel.typeRecord?.name ?? "";
    });
  }

  FormState get _formState => _formKey.currentState;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RecordCreateViewModel>(
      create: (_) => _viewModel,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text("Create Record"),
          actions: [
            TextButton(
              onPressed: () async {
                if (_formState.validate()) {
                  _formState.save();
                  final Record record = Record(
                    createDate: Timestamp.fromDate(_viewModel.date),
                    amount: _viewModel.amount,
                    title: _viewModel.title,
                    isAdd: _viewModel.amount >= 0,
                    walletId: _viewModel.wallet.id,
                    typeRecordId: _viewModel.typeRecord.id,
                    note: _viewModel.note,
                    date: Timestamp.fromDate(_viewModel.date),
                  );
                  final result = await _viewModel.onCreateRecord(record);
                  if (result != null) {
                    Navigator.of(context).pop();
                    const snackBar =
                        SnackBar(content: Text("Create Record Success !"));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    const snackBar = SnackBar(content: Text("FAIL"));
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
          child: Consumer<RecordCreateViewModel>(
            builder: (context, viewModel, child) {
              return SingleChildScrollView(
                child: Padding(
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
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
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
      onTap: () {
        if (_viewModel.wallet != null) {
          _selectTypeRecord();
        } else {
          DialogService().showDialog(
            title: 'Message',
            description: "please pick wallet first !",
            buttonTitle: "OK",
          );
        }
      },
    );
  }

  Future _selectWallet() async {
    final Wallet wallet = await showDialog<Wallet>(
      context: context,
      builder: (BuildContext context) {
        return PickWalletDialog();
      },
    );
    if (wallet == null) {
      return;
    }
    await _viewModel.onPickWallet(wallet);
    _walletTextController.text = _viewModel.wallet?.name ?? "";
    _typeRecordTextController.text = _viewModel.typeRecord?.name ?? "";
  }

  Future _selectTypeRecord() async {
    final TypeRecord typeRecord = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return PickTypeRecord(
          recordCreateViewModel: _viewModel,
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
