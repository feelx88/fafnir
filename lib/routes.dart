import 'package:fafnir/views/edit_entity_view.dart';
import 'package:fafnir/views/main_view.dart';
import 'package:flutter/widgets.dart';

import 'constants.dart';
import 'views/select_entity_view.dart';

class Routes {
  static Map<String, WidgetBuilder> create() => {
        '/main': (BuildContext context) => const MainView(title: appName),
        '/select_entity': (BuildContext context) =>
            const SelectEntityView(title: 'Select entity'),
        '/edit_entity': (BuildContext context) =>
            const EditEntityView(title: 'Edit entity'),
      };
}
