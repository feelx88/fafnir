import 'package:flutter/material.dart';

class ConfirmDialog {
  static void create(BuildContext context, String title, String questionText,
      String confirmButtonText, VoidCallback callback,
      {Color? positiveButtonColor}) async {
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
