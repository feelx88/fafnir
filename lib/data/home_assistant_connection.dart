import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class HomeAssistantConnection {
  late String name;
  late String token;
  late String url;
  late List<String>? entities;

  HomeAssistantConnection(
      {required this.name,
      required this.token,
      required this.url,
      this.entities});

  HomeAssistantConnection.fromString(String jsonContent) {
    var json = jsonDecode(jsonContent);
    name = json['name'] ?? '';
    token = json['token'] ?? '';
    url = json['url'] ?? '';
    entities = json['entities'] ?? List<String>.empty(growable: true);
  }

  @override
  String toString() {
    return jsonEncode({'name': name, 'token': token});
  }

  static Future<void> toPrefs(SharedPreferences prefs, String key,
      List<HomeAssistantConnection> connections) async {
    List<String> list = connections.map((e) => e.toString()).toList();
    await prefs.setStringList(key, list);
  }

  static List<HomeAssistantConnection> fromPrefs(
      SharedPreferences prefs, String key) {
    return prefs
            .getStringList(key)
            ?.map((e) => HomeAssistantConnection.fromString(e))
            .toList(growable: true) ??
        List.empty(growable: true);
  }
}
