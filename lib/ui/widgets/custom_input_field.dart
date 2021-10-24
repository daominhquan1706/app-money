import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CustomInputField extends StatefulWidget {
  FormFieldSetter<String> onSaved;
  FormFieldValidator<String> validator;
  InputType inputType;
  TextEditingController controller;
  GestureTapCallback onTap;
  IconData trailingIcon;
  String placeHolder;
  bool isRequire;
  bool autofocus;
  ValueChanged<String> onChanged;
  CustomInputField({
    Key key,
    this.onSaved,
    this.validator,
    this.inputType,
    this.controller,
    this.onTap,
    this.trailingIcon,
    this.placeHolder,
    this.isRequire = true,
    this.autofocus = false,
    this.onChanged,
  }) : super(key: key);

  @override
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  static const _locale = 'en';
  String get _currency =>
      NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 85,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              widget.inputType.label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 4, 8, 4),
            child: SizedBox(
              height: 30,
              child: TextFormField(
                autofocus: widget.autofocus,
                onTap: widget.onTap,
                focusNode:
                    widget.onTap != null ? AlwaysDisabledFocusNode() : null,
                controller: widget.controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: Icon(widget.trailingIcon),
                  hintText: widget.placeHolder,
                  filled: true,
                  fillColor: widget.isRequire
                      ? Colors.yellow.shade50
                      : Colors.transparent,
                  hintStyle: TextStyle(color: Colors.grey.shade300),
                  isDense: true,
                  contentPadding: const EdgeInsets.all(10),
                  prefixText:
                      widget.inputType == InputType.amount ? _currency : null,
                ),
                inputFormatters: widget.inputType.inputFormatters,
                keyboardType: widget.inputType.keyboardType,
                validator: widget.validator,
                onSaved: widget.onSaved,
                onChanged: widget.onChanged,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

enum InputType { amount, title, note, date, wallet, typeRecord }

extension InputTypeExtension on InputType {
  List<TextInputFormatter> get inputFormatters {
    switch (this) {
      case InputType.amount:
        return <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly];
      case InputType.title:
        return <TextInputFormatter>[
          FilteringTextInputFormatter.singleLineFormatter
        ];
      case InputType.note:
        return <TextInputFormatter>[
          FilteringTextInputFormatter.singleLineFormatter
        ];
      case InputType.date:
        // TODO: Handle this case.
        break;
      case InputType.wallet:
        // TODO: Handle this case.
        break;
      case InputType.typeRecord:
        // TODO: Handle this case.
        break;
    }
    return null;
  }

  String get label {
    switch (this) {
      case InputType.amount:
        return "Tiền";
      case InputType.title:
        return "Tiêu đề";
      case InputType.note:
        return "Ghi chú";
      case InputType.date:
        return "Ngày";
      case InputType.wallet:
        return "Ví";
      case InputType.typeRecord:
        return "Danh mục";
    }
    return "null";
  }

  TextInputType get keyboardType {
    switch (this) {
      case InputType.amount:
        return TextInputType.number;
      default:
        return TextInputType.text;
    }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
