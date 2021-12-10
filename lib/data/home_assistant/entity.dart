library home_assistant;

import 'dart:convert';

class Entity {
  String friendlyName;
  String entityId;
  String serviceDomain;

  Entity(this.friendlyName, this.entityId, {this.serviceDomain = 'light'});

  @override
  String toString() {
    return jsonEncode({'entity_id': entityId, 'friendly_name': friendlyName});
  }

  Map<String, dynamic> toJson() => {
        'friendly_name': friendlyName,
        'entity_id': entityId,
        'service_domain': serviceDomain
      };

  Entity.fromJson(Map<String, dynamic> json)
      : friendlyName = json['friendly_name'],
        entityId = json['entity_id'],
        serviceDomain = json['service_domain'] ?? 'light';
}

extension EntityList on List<Entity> {
  static List<Entity> fromJson(List<dynamic> json) {
    List<Entity> list = List.empty(growable: true);
    for (var entity in json) {
      list.add(Entity.fromJson(entity));
    }
    return list;
  }

  List<dynamic> toJson() => map((entity) => entity.toJson()).toList();
}
