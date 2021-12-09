import 'dart:collection';
import 'dart:convert';

import 'package:fafnir/data/home_assistant_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeAssistantConnection extends LinkedListEntry<HomeAssistantConnection> {
  late String name;
  late String token;
  late String url;
  late HomeAssistantEntityList? entities;

  HomeAssistantConnection(
      {required this.name,
      required this.token,
      required this.url,
      this.entities});

  Map<String, dynamic> toJson() => {
        'name': name,
        'token': token,
        'url': url,
        'entities': entities?.toJson()
      };

  HomeAssistantConnection.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? '',
        token = json['token'] ?? '',
        url = json['url'] ?? '',
        entities = HomeAssistantEntityList.fromJson(json['entities'] ?? []);

  static Future<void> toPrefs(SharedPreferences prefs, String key,
      List<HomeAssistantConnection> connections) async {
    List<String> list = connections
        .map((connection) => jsonEncode(connection.toJson()))
        .toList();
    await prefs.setStringList(key, list);
  }

  static List<HomeAssistantConnection> fromPrefs(
      SharedPreferences prefs, String key) {
    return prefs
            .getStringList(key)
            ?.map((connectionJson) =>
                HomeAssistantConnection.fromJson(jsonDecode(connectionJson)))
            .toList(growable: true) ??
        List.empty(growable: true);
  }
}

class HomeAssistantConnectionList extends LinkedList<HomeAssistantConnection> {
  HomeAssistantConnectionList.fromJson(List<dynamic> json) : super() {
    for (var entity in json) {
      add(HomeAssistantConnection.fromJson(entity));
    }
  }

  List<dynamic> toJson() => map((entity) => entity.toJson()).toList();
}
