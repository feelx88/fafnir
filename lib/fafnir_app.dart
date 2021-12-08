import 'package:fafnir/constants.dart';
import 'package:fafnir/views/main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Fafnir extends StatelessWidget {
  const Fafnir({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
      ),
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const MainView(title: appName),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => const MainView(title: appName),
      },
    );
  }
}
