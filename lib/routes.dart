import 'package:fafnir/views/main_view.dart';
import 'package:flutter/widgets.dart';

import 'views/select_entity_view.dart';

class Routes {
  static Map<String, WidgetBuilder> create({required String title}) => {
        '/main': (BuildContext context) => MainView(title: title),
        '/select_entity': (BuildContext context) =>
            const SelectEntityView(title: 'Select entity')
      };
}
