import 'dart:convert';

import 'package:fafnir/data/home_assistant_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeAssistantConnection {
  late String name;
  late String token;
  late String url;
  late List<HomeAssistantEntity> entities;

  HomeAssistantConnection(
      {required this.name,
      required this.token,
      required this.url,
      List<HomeAssistantEntity>? entities}) {
    this.entities = entities ?? HomeAssistantEntityList.fromJson([]);
  }

  Map<String, dynamic> toJson() =>
      {'name': name, 'token': token, 'url': url, 'entities': entities.toJson()};

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

extension HomeAssistantConnectionList on List<HomeAssistantConnection> {
  static List<HomeAssistantConnection> fromJson(List<dynamic> json) {
    List<HomeAssistantConnection> list = List.empty(growable: true);
    for (var entity in json) {
      list.add(HomeAssistantConnection.fromJson(entity));
    }
    return list;
  }

  List<dynamic> toJson() => map((entity) => entity.toJson()).toList();
}
