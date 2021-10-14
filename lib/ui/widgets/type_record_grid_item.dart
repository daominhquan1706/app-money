import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_app/model/type_record_model.dart';

class TypeRecordGridItem extends StatelessWidget {
  final TypeRecord typeRecord;
  final bool isSelect;
  final Function(TypeRecord) onTapItem;
  final bool isEditButton;
  const TypeRecordGridItem({
    Key key,
    this.typeRecord,
    this.isSelect = false,
    this.onTapItem,
    this.isEditButton = false,
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
            child: isEditButton
                ? const FaIcon(FontAwesomeIcons.edit)
                : Text(
                    typeRecord.name,
                    textAlign: TextAlign.center,
                  ),
          ),
        ),
      ),
    );
  }
}
