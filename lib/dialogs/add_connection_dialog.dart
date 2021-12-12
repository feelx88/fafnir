import 'package:fafnir/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class AddConnectionDialog {
  static void create(BuildContext context, String? name, String? url,
      String? token, Function saveCallback) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(S.of(context).newConnection),
              content: Column(mainAxisSize: MainAxisSize.min, children: [
                TextField(
                  decoration: InputDecoration(label: Text(S.of(context).name)),
                  controller: TextEditingController(text: name),
                  onChanged: (value) => name = value,
                ),
                TextField(
                  decoration: InputDecoration(label: Text(S.of(context).url)),
                  controller: TextEditingController(text: url),
                  onChanged: (value) => url = value,
                ),
                TextField(
                  decoration: InputDecoration(label: Text(S.of(context).token)),
                  controller: TextEditingController(text: token),
                  onChanged: (value) => token = value,
                ),
              ]),
              actions: [
                TextButton(
                    onPressed: () async {
                      token = await FlutterBarcodeScanner.scanBarcode(
                          '#${Colors.red.value.toRadixString(16)}',
                          S.of(context).cancel,
                          true,
                          ScanMode.QR);
                      Navigator.pop(context);
                      AddConnectionDialog.create(
                          context, name, url, token, saveCallback);
                    },
                    child: Text(S.of(context).scanQrCode)),
                TextButton(
                  child: Text(S.of(context).cancel),
                  onPressed: () {
                    name = null;
                    Navigator.pop(context);
                  },
                ),
                ElevatedButton(
                  child: Text(S.of(context).save),
                  onPressed: () => saveCallback(name, url, token),
                )
              ],
            ));
  }
}
