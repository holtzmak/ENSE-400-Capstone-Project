import 'package:app/core/services/dialog/dialog_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/utilities/optional.dart';
import 'package:app/ui/widgets/utility/dialog.dart';
import 'package:flutter/material.dart';

class DialogScreen extends StatefulWidget {
  final Widget child;

  DialogScreen({Key key, this.child}) : super(key: key);

  _DialogScreenState createState() => _DialogScreenState();
}

class _DialogScreenState extends State<DialogScreen> {
  DialogService _dialogService = locator<DialogService>();

  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogListener(_showDialog);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _showDialog(DialogRequest request) {
    final requestCancel = Optional(request.cancelText);
    var isConfirmationDialog = requestCancel.isPresent();
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(request.title),
              content: Text(request.description),
              actions: <Widget>[
                if (isConfirmationDialog)
                  FlatButton(
                    child: Text(request.cancelText),
                    onPressed: () {
                      _dialogService
                          .dialogComplete(DialogResponse(confirmed: false));
                    },
                  ),
                FlatButton(
                  child: Text(request.buttonText),
                  onPressed: () {
                    _dialogService
                        .dialogComplete(DialogResponse(confirmed: true));
                  },
                ),
              ],
            ));
  }
}
