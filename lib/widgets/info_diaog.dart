import 'package:flutter/material.dart';

class AdaptiveDialogScreen {
  void call(BuildContext context, String text, String title) {
    showAdaptiveDialog(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        title: Text(title),
        content: Text(text),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
