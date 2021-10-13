import 'package:flutter/material.dart';
import 'package:money_app/model/type_record_model.dart';

class TypeRecordGridItem extends StatelessWidget {
  final TypeRecord typeRecord;
  final bool isSelect;
  final Function(TypeRecord) onTapItem;
  const TypeRecordGridItem({
    Key key,
    this.typeRecord,
    this.isSelect,
    this.onTapItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTapItem != null) {
          onTapItem(typeRecord);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          height: 20,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
              color: isSelect ? Colors.green.shade100 : Colors.grey.shade300,
              width: isSelect ? 3 : 1,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: Center(
            child: Text(
              typeRecord.name,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
