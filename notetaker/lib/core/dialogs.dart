import 'package:flutter/material.dart';
import 'package:notetaker/widgets/confirmation_dialog.dart';
import 'package:notetaker/widgets/message_dialog.dart';
import 'package:notetaker/widgets/new_tag_dialog.dart';

Future<String?> showNewTagDialog({required BuildContext context, String? tag}) {
  return showDialog<String?>(
    context: context,
    builder: (context) => NewTagDialog(tag: tag),
  );
}

Future<bool?> showConfirmationDialog({
  required BuildContext context,
  required String title,
}) {
  return showDialog<bool?>(
    context: context,
    builder: (_) => ConfirmationDialog(title: title),
  );
}

Future<String?> showMessageDialog({
  required BuildContext context,
  required String message,
}) {
  return showDialog<String?>(
    context: context,
    builder: (_) => MessageDialog(message: message),
  );
}
