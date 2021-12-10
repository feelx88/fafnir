import 'package:flutter/material.dart';

class ConfirmDialog {
  static Future<bool?> create(BuildContext context, String title,
      String questionText, String confirmButtonText, VoidCallback callback,
      {Color? positiveButtonColor, VoidCallback? cancelCallback}) async {
    return await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              title,
            ),
            content: Text(questionText),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  cancelCallback!();
                },
                child: const Text(
                  'Cancel',
                ),
              ),
              ElevatedButton(
                onPressed: callback,
                style: ElevatedButton.styleFrom(primary: positiveButtonColor),
                child: Text(
                  confirmButtonText,
                ),
              ),
            ],
          );
        });
  }
}
