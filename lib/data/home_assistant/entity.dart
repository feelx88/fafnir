library home_assistant;

import 'dart:convert';

import 'package:fafnir/data/home_assistant/domain.dart';

class Entity {
  String friendlyName;
  String entityId;
  late String serviceDomain;
  late List<DomainFeature> features;

  Entity(this.friendlyName, this.entityId) {
    Domain domain = Domain.configurations[entityId.split('.').first] ??
        Domain.configurations['light']!;
    serviceDomain = domain.id;
    features = domain.features.toList();
  }

  Entity.fromJson(Map<String, dynamic> json)
      : friendlyName = json['friendly_name'],
        entityId = json['entity_id'],
        serviceDomain = json['service_domain'] ?? 'light',
        features = DomainFeatureList.fromJson(json['features'] ?? []);

  @override
  String toString() {
    return jsonEncode({
      'entity_id': entityId,
      'friendly_name': friendlyName,
      'service_domain': serviceDomain,
      'features': features.toJson()
    });
  }

  Map<String, dynamic> toJson() => {
        'friendly_name': friendlyName,
        'entity_id': entityId,
        'service_domain': serviceDomain,
        'features': features.toJson()
      };
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
