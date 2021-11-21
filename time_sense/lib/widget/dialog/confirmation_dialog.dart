import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfirmationDialog extends StatefulWidget {
  const ConfirmationDialog({
    Key? key,
    required this.confirmationMessage,
    required this.onConfirm,
    this.onCancel
  }) : super(key: key);

  final String confirmationMessage;
  final Function onConfirm;
  final Function? onCancel;

  @override
  State<StatefulWidget> createState() => _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<ConfirmationDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.confirmationMessage),
      actions: [
        TextButton(
            onPressed: () {
              widget.onCancel?.call();
              Navigator.pop(context);
            },
            child: const Text("NO",
              style: TextStyle(
                color: Colors.redAccent
              )
            )
        ),
        TextButton(
            onPressed: () {
              widget.onConfirm.call();
              Navigator.pop(context);
            },
            child: const Text("YES")
        ),
      ],
    );
  }

}
