import 'dart:collection';
import 'dart:convert';

class HomeAssistantEntity extends LinkedListEntry<HomeAssistantEntity> {
  final String friendlyName;
  final String entityId;

  HomeAssistantEntity(this.friendlyName, this.entityId);

  @override
  String toString() {
    return jsonEncode({'entity_id': entityId, 'friendly_name': friendlyName});
  }

  Map<String, dynamic> toJson() =>
      {'friendly_name': friendlyName, 'entity_id': entityId};

  HomeAssistantEntity.fromJson(Map<String, dynamic> json)
      : friendlyName = json['friendly_name'],
        entityId = json['entity_id'];
}

class HomeAssistantEntityList extends LinkedList<HomeAssistantEntity> {
  HomeAssistantEntityList.fromJson(List<dynamic> json) : super() {
    for (var entity in json) {
      add(HomeAssistantEntity.fromJson(entity));
    }
  }

  List<dynamic> toJson() => map((entity) => entity.toJson()).toList();
}
