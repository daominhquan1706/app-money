import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_app/model/type_record_model.dart';
import 'package:money_app/view_models/record_create_viewmodel.dart';

class TypeRecordCreatePage extends StatefulWidget {
  final RecordCreateViewModel recordCreateViewModel;

  const TypeRecordCreatePage({Key key, @required this.recordCreateViewModel})
      : super(key: key);
  @override
  _TypeRecordCreatePageState createState() => _TypeRecordCreatePageState();
}

class _TypeRecordCreatePageState extends State<TypeRecordCreatePage> {
  String _title;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FormState get _formState => _formKey.currentState;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("Create Type Record"),
        actions: [
          TextButton(
            onPressed: _onCreateTypeRecord,
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
          child: Column(children: [_buildTitle()]),
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

  Future<void> _onCreateTypeRecord() async {
    if (_formState.validate()) {
      _formState.save();
      final TypeRecord typeRecord = TypeRecord(
        name: _title,
      );
      final result =
          await widget.recordCreateViewModel.onCreateTypeRecord(typeRecord);
      Navigator.of(context).pop<TypeRecord>(result);
    }
  }
}
