import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import 'locator_service.dart';

enum DialogType { basic, form }

void setupDialogUi() {
  final DialogService dialogService = locator<DialogService>();

  final builders = {
    DialogType.basic: (context, DialogRequest sheetRequest,
            Function(DialogResponse) completer) =>
        _BasicDialog(request: sheetRequest, completer: completer),
    DialogType.form: (context, DialogRequest sheetRequest,
            Function(DialogResponse) completer) =>
        _FormDialog(request: sheetRequest, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}

class _BasicDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const _BasicDialog({Key key, this.request, this.completer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Dialog(child: Text("ok"));
  }
}

class _FormDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const _FormDialog({Key key, this.request, this.completer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Dialog(child: Text("ok"));
  }
}
