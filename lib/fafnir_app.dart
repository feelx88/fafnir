import 'package:fafnir/constants.dart';
import 'package:fafnir/routes.dart';
import 'package:fafnir/views/main_view.dart';
import 'package:flutter/material.dart';
import 'package:fafnir/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'generated/l10n.dart';

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
      routes: Routes.create(),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}
