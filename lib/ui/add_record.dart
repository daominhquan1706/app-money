import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AddRecord extends StatefulWidget {
  @override
  _AddRecordState createState() => _AddRecordState();
}

class _AddRecordState extends State<AddRecord> {
  double _amount;
  DateTime _date;
  String _title;
  String _note;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FormState get _formState => _formKey.currentState;

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
          "Add Record",
        ),
        actions: [
          FlatButton(
            onPressed: () {
              if (_formState.validate()) {
                _formState.save();
              } else {
                Navigator.of(context).pop();
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
          return 'Name isRequired';
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
        const Text("Date :"),
        const Spacer(),
        RaisedButton(
          onPressed: () {
            _selectDate(context);
          },
          child: Text("${DateFormat('dd-MM-yyyy').format(_date)}"),
        )
      ],
    );
  }

  _selectDate(BuildContext context) async {
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
}
