import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

import 'fafnir_app.dart';

void main() {
  runApp(const Fafnir());
  FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SHOW_WHEN_LOCKED)
      .then((e) {});
}
