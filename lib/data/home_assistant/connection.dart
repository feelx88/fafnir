library home_assistant;

import 'dart:convert';

import 'package:fafnir/data/home_assistant/entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Connection {
  late String name;
  late String token;
  late String url;
  late List<Entity> entities;

  Connection(
      {required this.name,
      required this.token,
      required this.url,
      List<Entity>? entities}) {
    this.entities = entities ?? EntityList.fromJson([]);
  }

  Map<String, dynamic> toJson() =>
      {'name': name, 'token': token, 'url': url, 'entities': entities.toJson()};

  Connection.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? '',
        token = json['token'] ?? '',
        url = json['url'] ?? '',
        entities = EntityList.fromJson(json['entities'] ?? []);

  static Future<void> toPrefs(
      SharedPreferences prefs, String key, List<Connection> connections) async {
    List<String> list = connections
        .map((connection) => jsonEncode(connection.toJson()))
        .toList();
    await prefs.setStringList(key, list);
  }

  static List<Connection> fromPrefs(SharedPreferences prefs, String key) {
    return prefs
            .getStringList(key)
            ?.map((connectionJson) =>
                Connection.fromJson(jsonDecode(connectionJson)))
            .toList(growable: true) ??
        List.empty(growable: true);
  }
}

extension ConnectionList on List<Connection> {
  static List<Connection> fromJson(List<dynamic> json) {
    List<Connection> list = List.empty(growable: true);
    for (var entity in json) {
      list.add(Connection.fromJson(entity));
    }
    return list;
  }

  List<dynamic> toJson() => map((entity) => entity.toJson()).toList();
}
