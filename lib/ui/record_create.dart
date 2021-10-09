import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_app/model/record_model.dart';
import 'package:money_app/view_models/home_viewmodel.dart';
import 'package:money_app/view_models/record_create_viewmodel.dart';
import 'package:money_app/widgets/custom_input_field.dart';
import 'package:money_app/widgets/type_record_grid_item.dart';
import 'package:provider/provider.dart';


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
        body: Column(
          children: [
            Expanded(
              child: Form(
                key: _formKey,
                child: Consumer<RecordCreateViewModel>(
                  builder: (context, viewModel, child) {
                    const divider = Divider(
                      color: Colors.black26,
                      indent: 12,
                      height: 0,
                    );
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Column(
                            children: [
                              _buildDate(),
                              divider,
                              _buildAmount(),
                              divider,
                              _buildNote(),
                              divider,
                              _buildTypeRecord(),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            _bottomBar(),
          ],
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
      placeHolder: "0",
      onSaved: (String value) {
        _viewModel.amount = double.parse(value);
      },
    );
  }

  Widget _buildNote() {
    return CustomInputField(
      inputType: InputType.note,
      validator: (String value) {
        return null;
      },
      placeHolder: "Has not been entered",
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
    );
  }

  Future<void> _showDatePicker() async {
    DateTime pickedDate;
    final result = await showCupertinoModalPopup<DateTime>(
      context: context,
      builder: (_) => Container(
        height: 255,
        //color: const Color.fromARGB(255, 255, 255, 255),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                CupertinoButton(
                  onPressed: () => Navigator.of(context).pop(null),
                  child: const Text('Cancel'),
                ),
                const Spacer(),
                CupertinoButton(
                  onPressed: () => Navigator.of(context).pop(pickedDate),
                  child: const Text('OK'),
                ),
              ],
            ),
            SizedBox(
              height: 180,
              child: CupertinoDatePicker(
                initialDateTime: DateTime.now(),
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (picked) {
                  setState(() {
                    if (picked != null) {
                      pickedDate = picked;
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
    if (result != null) {
      setState(() {
        _viewModel.date = result;
        _dateTextController.text = _viewModel.dateString;
      });
    }
  }

  Widget _buildTypeRecord() {
    if (_viewModel.listTypeRecord.isNotEmpty) {
      _viewModel.typeRecord ??= _viewModel?.listTypeRecord?.first;
    }

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: Text("Type Record"),
          ),
          SizedBox(
            width: double.infinity,
            height: 300,
            child: GridView.count(
              childAspectRatio: 3 / 2,
              crossAxisCount: 3,
              children: _viewModel.listTypeRecord
                  .map(
                    (item) => TypeRecordGridItem(
                      isSelect: item.id == _viewModel.typeRecord?.id,
                      typeRecord: item,
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
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
                onPressed: () {},
                child: const Text("Add"),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
