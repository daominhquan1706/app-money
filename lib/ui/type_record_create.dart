import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_app/model/type_record_model.dart';
import 'package:money_app/view_models/record_create_viewmodel.dart';

class TypeRecordCreatePage extends StatefulWidget {
  final TypeRecord typeRecord;
  final RecordCreateViewModel recordCreateViewModel;
  final TypeRecordType type;
  const TypeRecordCreatePage({
    Key key,
    @required this.recordCreateViewModel,
    @required this.type,
    this.typeRecord,
  }) : super(key: key);
  @override
  _TypeRecordCreatePageState createState() => _TypeRecordCreatePageState();
}

class _TypeRecordCreatePageState extends State<TypeRecordCreatePage> {
  String _title;

  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FormState get _formState => _formKey.currentState;
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    isEdit = widget.typeRecord != null;
    if (isEdit) {
      _nameController.text = widget.typeRecord.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(isEdit ? "Chỉnh sửa danh mục" : "Tạo danh mục"),
        actions: [
          TextButton(
            onPressed: _onSave,
            child: Text(
              isEdit ? "Lưu" : "Tạo",
              style: const TextStyle(color: Colors.white),
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
      controller: _nameController,
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

  Future<void> _onSave() async {
    if (_formState.validate()) {
      _formState.save();
      if (isEdit) {
        await widget.recordCreateViewModel
            .onUpdateTypeRecord(widget.typeRecord..name = _title);
        Navigator.of(context).pop();
      } else {
        final TypeRecord typeRecord = TypeRecord(
          name: _title,
          type: widget.type,
        );
        await widget.recordCreateViewModel.onCreateTypeRecord(typeRecord);
        Navigator.of(context).pop();
      }
    }
  }
}
