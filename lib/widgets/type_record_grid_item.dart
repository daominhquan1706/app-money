import 'package:flutter/material.dart';
import 'package:money_app/model/type_record_model.dart';

class TypeRecordGridItem extends StatelessWidget {
  final TypeRecord typeRecord;
  final bool isSelect;
  const TypeRecordGridItem({Key key, this.typeRecord, this.isSelect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
            color: isSelect ? Colors.green.shade100 : Colors.grey.shade300),
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Center(
        child: Text(typeRecord.name),
      ),
    );
  }
}
