import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:money_app/model/record_model.dart';
import 'package:money_app/model/wallet_model.dart';
import 'package:money_app/view_models/home_viewmodel.dart';

class AddRecord extends StatefulWidget {
  @override
  _AddRecordState createState() => _AddRecordState();
}

class _AddRecordState extends State<AddRecord> {
  double _amount;
  DateTime _date;
  String _title;
  String _note;
  Wallet _wallet = HomeViewModel.instance.currentWallet;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FormState get _formState => _formKey.currentState;
  HomeViewModel _homeViewModel = HomeViewModel.instance;

  @override
  void initState() {
    _date = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          "Create Record",
        ),
        actions: [
          FlatButton(
            onPressed: () {
              if (_formState.validate()) {
                _formState.save();
                final Record record = Record(
                  createDate: DateTime.now(),
                  amount: _amount,
                  title: _title,
                  isAdd: _amount >= 0,
                  walletId: _wallet.id,
                  note: _note,
                );
                Navigator.of(context).pop<Record>(record);
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
              _buildAmount(),
              _buildTitle(),
              _buildNote(),
              _buildDate(),
              _buildWallet(),
            ],
          ),
        ),
      ),
    );
    return scaffold;
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
        _amount = double.parse(value);
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
        _title = value;
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
        _note = value;
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
          child: RaisedButton(
            onPressed: () {
              _selectDate(context);
            },
            child: Text(DateFormat('dd-MM-yyyy').format(_date)),
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
          child: RaisedButton(
            onPressed: () {
              _selectWallet(context);
            },
            child: Text(_wallet != null ? _wallet.name : "Please Pick Wallet"),
          ),
        )
      ],
    );
  }

  Future _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
      });
    }
  }

  Future _selectWallet(BuildContext context) async {
    final Wallet wallet = await showDialog(
        context: context,
        child: SimpleDialog(
          title: const Text("Pick Wallet"),
          children: _homeViewModel.listWallet.isNotEmpty
              ? _homeViewModel.listWallet.map((e) {
                  return Card(
                    child: ListTile(
                      title: Text(e.name),
                      leading: const Icon(Icons.account_balance_wallet),
                      onTap: () {
                        Navigator.of(context).pop<Wallet>(e);
                      },
                      trailing: _wallet?.id == e.id
                          ? const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            )
                          : const SizedBox.shrink(),
                    ),
                  );
                }).toList()
              : [const Text("Dont you dont have wallet")],
        ));
    if (wallet == null) {
      return;
    }
    setState(() {
      _wallet = wallet;
    });
  }
}
