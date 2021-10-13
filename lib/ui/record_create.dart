import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:money_app/helper/dialog_helper.dart';
import 'package:money_app/model/record_model.dart';
import 'package:money_app/model/type_record_model.dart';
import 'package:money_app/ui/list_typerecord_page.dart';
import 'package:money_app/ui/widgets/custom_input_field.dart';
import 'package:money_app/ui/widgets/type_record_grid_item.dart';
import 'package:money_app/view_models/home_viewmodel.dart';
import 'package:money_app/view_models/record_create_viewmodel.dart';
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
  final TextEditingController _amountTextController = TextEditingController();

  final TextEditingController _walletTextController = TextEditingController();
  final TextEditingController _typeRecordTextController =
      TextEditingController();
  int segmentedControlGroupValue = 0;
  @override
  void initState() {
    super.initState();
    _dateTextController.text = DateFormat.yMMMd().format(DateTime.now());
    _viewModel.initialize().then((value) {
      _walletTextController.text = _viewModel.wallet?.name ?? "";
      _typeRecordTextController.text = _viewModel.typeRecord?.name ?? "";
      _amountTextController.text = "0";
    });
  }

  FormState get _formState => _formKey.currentState;
  List<TypeRecord> get _listTypeRecord {
    if (segmentedControlGroupValue == 0) {
      return _viewModel.listTypeRecordOutCome;
    } else {
      return _viewModel.listTypeRecordInCome;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RecordCreateViewModel>(
      create: (_) => _viewModel,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text("Create Record"),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoSlidingSegmentedControl(
                    groupValue: segmentedControlGroupValue,
                    children: const <int, Widget>{
                      0: Text('Tiền Chi'),
                      1: Text('Tiền Thu')
                    },
                    onValueChanged: (int i) {
                      setState(() {
                        segmentedControlGroupValue = i;
                      });
                      _viewModel.onSwithType(i);
                    }),
              ),
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
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            _buildDate(),
                            divider,
                            _buildNote(),
                            divider,
                            _buildAmount(),
                            divider,
                            Expanded(
                              child: _buildTypeRecord(),
                            ),
                          ],
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
      ),
    );
  }

  Widget _buildAmount() {
    return CustomInputField(
      controller: _amountTextController,
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

  Widget _buildNote() {
    return CustomInputField(
      inputType: InputType.note,
      isRequire: false,
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
    if (_listTypeRecord.isNotEmpty) {
      _viewModel.typeRecord ??= _listTypeRecord?.first;
    }

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: Text(
              "Type Record",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              // height: 300,
              child: GridView.count(
                childAspectRatio: 3 / 2,
                crossAxisCount: 3,
                children: [
                  ...(_listTypeRecord ?? [])
                      .map(
                        (item) => TypeRecordGridItem(
                          isSelect: item.id == _viewModel.typeRecord?.id,
                          typeRecord: item,
                          onTapItem: (typeRecord) {
                            setState(() {
                              _viewModel.onPickTypeRecord(typeRecord);
                            });
                          },
                        ),
                      )
                      .toList(),
                  TypeRecordGridItem(
                    isSelect: false,
                    typeRecord: TypeRecord(name: "Edit"),
                    onTapItem: (_) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ListTypeRecordPage(
                            recordCreateViewModel: _viewModel,
                            initIndexSegmentControl: segmentedControlGroupValue,
                            listTypeRecordIncome:
                                _viewModel.listTypeRecordInCome,
                            listTypeRecordOutcome:
                                _viewModel.listTypeRecordOutCome,
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
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
                onPressed: onSaveRecord,
                child: const Text("Add"),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> onSaveRecord() async {
    if (_formState.validate()) {
      _formState.save();
      final Record record = Record(
        createDate: Timestamp.fromDate(_viewModel.date),
        amount: _viewModel.amount,
        title: _viewModel.typeRecord.name,
        isAdd: segmentedControlGroupValue == 1,
        walletId: _viewModel.wallet.id,
        typeRecordId: _viewModel.typeRecord.id,
        note: _viewModel.note,
        date: Timestamp.fromDate(_viewModel.date),
      );
      DialogHelper.showLoading();
      final result = await _viewModel.onCreateRecord(record);
      EasyLoading.dismiss();
      if (result != null) {
        Navigator.of(context).pop();
        EasyLoading.showToast('Create Record Success !');
      } else {
        EasyLoading.showToast('Create Record Fail !');
      }
    }
  }
}
