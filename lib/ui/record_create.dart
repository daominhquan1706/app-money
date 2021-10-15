import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

class AddEditRecord extends StatefulWidget {
  final bool isEdit;
  final Record record;
  final HomeViewModel homeViewModel;

  const AddEditRecord({
    Key key,
    this.homeViewModel,
    this.isEdit = false,
    this.record,
  }) : super(key: key);

  @override
  _AddEditRecordState createState() => _AddEditRecordState();
}

class _AddEditRecordState extends State<AddEditRecord> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RecordCreateViewModel _viewModel = RecordCreateViewModel();
  final TextEditingController _dateTextController = TextEditingController();
  final TextEditingController _amountTextController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _viewModel.initialize(record: widget.record).then((value) {
      if (widget.record == null) {
        _dateTextController.text = DateFormat.yMMMd().format(DateTime.now());
        _amountTextController.text = "0";
      } else {
        _dateTextController.text =
            DateFormat.yMMMd().format(widget.record.createDate.toDate());
        _amountTextController.text = widget.record.amount.toString();
      }
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
          title: !widget.isEdit
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CupertinoSlidingSegmentedControl(
                      groupValue: _viewModel.segmentIndex,
                      children: <int, Widget>{
                        0: Text(
                          'Tiền Chi',
                          style: TextStyle(
                            color: _viewModel.segmentIndex == 1
                                ? Colors.white
                                : Colors.blue,
                          ),
                        ),
                        1: Text(
                          'Tiền Thu',
                          style: TextStyle(
                            color: _viewModel.segmentIndex == 0
                                ? Colors.white
                                : Colors.blue,
                          ),
                        )
                      },
                      onValueChanged: (int i) {
                        setState(() {
                          _viewModel.segmentIndex = i;
                        });
                        _viewModel.onSwithType(i);
                      }),
                )
              : Text(widget.isEdit ? "Chỉnh sửa" : ""),
        ),
        body: SafeArea(
          child: Column(
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
      placeHolder: "Chưa nhập vào",
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
    // if (_listTypeRecord.isNotEmpty) {
    //   _viewModel.typeRecord ??= _listTypeRecord?.first;
    // }

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: Text(
              "Danh mục",
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
                  ...(_viewModel.listTypeRecord ?? [])
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
                    isEditButton: true,
                    typeRecord: TypeRecord(name: "Edit"),
                    onTapItem: (_) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ListTypeRecordPage(
                            recordCreateViewModel: _viewModel,
                            initIndexSegmentControl: _viewModel.segmentIndex,
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
              child: Row(
                children: [
                  IconButton(
                    onPressed: onDeleteRecord,
                    icon: const FaIcon(
                      FontAwesomeIcons.trash,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onSaveRecord,
                      child: Text(
                          "${widget.isEdit ? "Chỉnh sửa" : "Nhập"} ${_viewModel.segmentIndex == 0 ? "khoản chi" : "khoản thu"}"),
                    ),
                  ),
                ],
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
      DialogHelper.showLoading();
      final result = await _viewModel.onSaveRecord();
      EasyLoading.dismiss();
      final isEdit = _viewModel.recordForEdit != null;
      if (result != null) {
        Navigator.of(context).pop();
        EasyLoading.showToast('${isEdit ? "Chỉnh sửa" : "Tạo"} thành công !');
      } else {
        EasyLoading.showToast('${isEdit ? "Chỉnh sửa" : "Tạo"} thất bại !');
      }
    }
  }

  void setUpEditState(Record record) {
    _viewModel.setUpRecordForEdit(record);
  }

  Future<void> onDeleteRecord() async {
    final dynamic isAccept = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Do you want to Delete this Record ?"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              //color: Colors.redAccent,
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );

    if (isAccept is bool && isAccept) {
      DialogHelper.showLoading();
      _viewModel.onDeleteRecord().then((value) {
        DialogHelper.dismissLoading();
        Navigator.pop(context);
      }).catchError((e) {
        DialogHelper.dismissLoading();
      });
    }
  }
}
