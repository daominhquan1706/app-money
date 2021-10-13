import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_app/helper/dialog_helper.dart';
import 'package:money_app/model/type_record_model.dart';
import 'package:money_app/view_models/record_create_viewmodel.dart';

enum ListTypeRecordState {
  showlist,
  reordering,
}

class ListTypeRecordPage extends StatefulWidget {
  final RecordCreateViewModel recordCreateViewModel;
  final int initIndexSegmentControl;
  final List<TypeRecord> listTypeRecordOutcome;
  final List<TypeRecord> listTypeRecordIncome;
  const ListTypeRecordPage({
    Key key,
    this.recordCreateViewModel,
    this.initIndexSegmentControl,
    this.listTypeRecordOutcome,
    this.listTypeRecordIncome,
  }) : super(key: key);

  @override
  _ListTypeRecordPageState createState() => _ListTypeRecordPageState();
}

class _ListTypeRecordPageState extends State<ListTypeRecordPage> {
  int segmentedControlGroupValue = 0;
  ListTypeRecordState state = ListTypeRecordState.showlist;
  List<TypeRecord> listTypeRecordOutcome = [];
  List<TypeRecord> listTypeRecordIncome = [];

  List<TypeRecord> get _listTypeRecord {
    return segmentedControlGroupValue == 0
        ? listTypeRecordOutcome
        : listTypeRecordIncome;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      listTypeRecordOutcome = widget.listTypeRecordOutcome;
      listTypeRecordIncome = widget.listTypeRecordIncome;
      segmentedControlGroupValue = widget.initIndexSegmentControl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh mục"),
        actions: [
          TextButton(
            onPressed: () {
              switch (state) {
                case ListTypeRecordState.showlist:
                  setState(() {
                    state = ListTypeRecordState.reordering;
                  });
                  break;
                case ListTypeRecordState.reordering:
                  DialogHelper.showLoading();
                  widget.recordCreateViewModel
                      .onReorderTypeRecords(listTypeRecord: _listTypeRecord)
                      .then((value) {
                    DialogHelper.dismissLoading();
                    setState(() {
                      state = ListTypeRecordState.showlist;
                    });
                  });
                  break;
              }
            },
            child: Text(
              state == ListTypeRecordState.showlist
                  ? "Chỉnh sửa"
                  : "Hoàn thành",
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
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
                    if (state == ListTypeRecordState.showlist) {
                      setState(() {
                        segmentedControlGroupValue = i;
                      });
                    }
                  }),
            ),
            Expanded(
              child: ReorderableListView(
                buildDefaultDragHandles:
                    state == ListTypeRecordState.reordering,
                onReorder: (int oldIndex, int newIndex) {
                  setState(() {
                    switch (segmentedControlGroupValue) {
                      case 0:
                        listTypeRecordOutcome = reorderList(
                            listTypeRecordOutcome, oldIndex, newIndex);
                        break;
                      case 1:
                        listTypeRecordIncome = reorderList(
                            listTypeRecordIncome, oldIndex, newIndex);
                        break;
                    }
                  });
                },
                children: [
                  for (final item in _listTypeRecord.where(
                      (element) => element.type == segmentedControlGroupValue))
                    Container(
                      key: ValueKey(item.id),
                      child: _buildTypeRecord(item),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeRecord(TypeRecord item) {
    return Column(
      children: [
        ListTile(
          title: Text(item.name ?? ""),
          trailing: state == ListTypeRecordState.reordering
              ? const FaIcon(
                  FontAwesomeIcons.bars,
                )
              : const SizedBox(
                  height: 0,
                  width: 0,
                ),
        ),
        const Divider(
          height: 1,
        ),
      ],
    );
  }

  List<TypeRecord> reorderList(
      List<TypeRecord> list, int oldIndex, int newIndex) {
    final newList = list;
    if (oldIndex < newIndex) {
      final item = newList[oldIndex];
      newList.insert(newIndex, item);
      newList.removeAt(oldIndex);
    } else {
      final item = newList.removeAt(oldIndex);
      newList.insert(newIndex, item);
    }
    return newList;
  }
}
