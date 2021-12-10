import 'dart:convert';

class HomeAssistantEntity {
  String friendlyName;
  String entityId;
  String serviceDomain;

  HomeAssistantEntity(this.friendlyName, this.entityId,
      {this.serviceDomain = 'light'});

  @override
  String toString() {
    return jsonEncode({'entity_id': entityId, 'friendly_name': friendlyName});
  }

  Map<String, dynamic> toJson() => {
        'friendly_name': friendlyName,
        'entity_id': entityId,
        'service_domain': serviceDomain
      };

  HomeAssistantEntity.fromJson(Map<String, dynamic> json)
      : friendlyName = json['friendly_name'],
        entityId = json['entity_id'],
        serviceDomain = json['service_domain'] ?? 'light';
}

extension HomeAssistantEntityList on List<HomeAssistantEntity> {
  static List<HomeAssistantEntity> fromJson(List<dynamic> json) {
    List<HomeAssistantEntity> list = List.empty(growable: true);
    for (var entity in json) {
      list.add(HomeAssistantEntity.fromJson(entity));
    }
    return list;
  }

  List<dynamic> toJson() => map((entity) => entity.toJson()).toList();
}
