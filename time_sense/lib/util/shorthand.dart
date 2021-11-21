import 'package:flutter/material.dart';
import 'package:time_sense/widget/dialog/confirmation_dialog.dart';

void confirmationDialog({
  required BuildContext context,
  required String confirmationMessage,
  required Function onConfirm,
  Function? onCancel
}) {
  showDialog(
      context: context,
      builder: (context) => ConfirmationDialog(
        confirmationMessage: confirmationMessage,
        onConfirm: onConfirm,
        onCancel: onCancel,
      )
  );
}
