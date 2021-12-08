import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class AddConnectionDialog {
  static void create(BuildContext context, String? name, String? url,
      String? token, Function saveCallback) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('Enter Name for the new connection'),
              content: Column(mainAxisSize: MainAxisSize.min, children: [
                TextField(
                  decoration: const InputDecoration(label: Text('Name')),
                  controller: TextEditingController(text: name),
                  onChanged: (value) => name = value,
                ),
                TextField(
                  decoration: const InputDecoration(label: Text('Url')),
                  controller: TextEditingController(text: url),
                  onChanged: (value) => url = value,
                ),
                TextField(
                  decoration: const InputDecoration(label: Text('Token')),
                  controller: TextEditingController(text: token),
                  onChanged: (value) => token = value,
                ),
              ]),
              actions: [
                TextButton(
                    onPressed: () async {
                      token = await FlutterBarcodeScanner.scanBarcode(
                          '#${Colors.red.value.toRadixString(16)}',
                          'Cancel',
                          true,
                          ScanMode.QR);
                      Navigator.pop(context);
                      AddConnectionDialog.create(
                          context, name, url, token, saveCallback);
                    },
                    child: const Text('Scan QR Code')),
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    name = null;
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: const Text('Save'),
                  onPressed: () => saveCallback(name, url, token),
                )
              ],
            ));
  }
}
