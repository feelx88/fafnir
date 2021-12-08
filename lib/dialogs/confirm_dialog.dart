import 'package:flutter/material.dart';

class ConfirmDialog {
  static void create(BuildContext context, String title, String questionText,
      String confirmButtonText, VoidCallback callback) async {
    await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              title,
            ),
            content: Text(questionText),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Cancel',
                ),
              ),
              TextButton(
                onPressed: callback,
                child: Text(
                  confirmButtonText,
                ),
              ),
            ],
          );
        });
  }
}