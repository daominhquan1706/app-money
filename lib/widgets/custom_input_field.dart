import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInputField extends StatefulWidget {
  FormFieldSetter<String> onSaved;
  FormFieldValidator<String> validator;
  InputType inputType;
  TextEditingController controller;
  GestureTapCallback onTap;
  IconData trailingIcon;
  CustomInputField({
    Key key,
    this.onSaved,
    this.validator,
    this.inputType,
    this.controller,
    this.onTap,
    this.trailingIcon,
  }) : super(key: key);

  @override
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        onTap: widget.onTap,
        focusNode: widget.onTap != null ? AlwaysDisabledFocusNode() : null,
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: widget.inputType.label,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          suffixIcon: Icon(widget.trailingIcon),
        ),
        inputFormatters: widget.inputType.inputFormatters,
        keyboardType: widget.inputType.keyboardType,
        validator: widget.validator,
        onSaved: widget.onSaved,
      ),
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
        return "Amount";
      case InputType.title:
        return "Title";
      case InputType.note:
        return "Note";
      case InputType.date:
        return "Date";
      case InputType.wallet:
        return "Wallet";
      case InputType.typeRecord:
        return "Type Record";
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
