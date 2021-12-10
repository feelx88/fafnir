import 'package:fafnir/data/home_assistant_entity.dart';
import 'package:flutter/material.dart';

class HomeAssistantDomain {
  static final Map<String, HomeAssistantDomain> configurations =
      <String, HomeAssistantDomain>{
    'light': HomeAssistantDomain(
        id: 'light',
        name: 'Light',
        widgetFactory: (HomeAssistantEntity entity, Function serviceCall) =>
            ListTile(
              title: Text(entity.friendlyName),
              subtitle: Text(entity.entityId),
              trailing: const Icon(Icons.lightbulb),
              onTap: () => serviceCall(entity, 'light/toggle'),
            )),
    'switch': HomeAssistantDomain(
        id: 'switch',
        name: 'Switch',
        widgetFactory: (HomeAssistantEntity entity, Function serviceCall) =>
            ListTile(
              title: Text(entity.friendlyName),
              subtitle: Text(entity.entityId),
              trailing: const Icon(Icons.toggle_on),
              onTap: () => serviceCall(entity, 'switch/toggle'),
            )),
    'media_player': HomeAssistantDomain(
        id: 'media_player',
        name: 'Media Player',
        widgetFactory: (HomeAssistantEntity entity, Function serviceCall) =>
            Padding(
                padding: kTabLabelPadding,
                child: Column(
                  children: [
                    Row(
                      children: [Text(entity.friendlyName)],
                    ),
                    Padding(
                        padding: kMaterialListPadding,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.skip_previous),
                              onPressed: () => serviceCall(
                                  entity, 'media_player/media_previous_track'),
                            ),
                            IconButton(
                              icon: const Icon(Icons.pause),
                              onPressed: () => serviceCall(
                                  entity, 'media_player/media_pause'),
                            ),
                            IconButton(
                              icon: const Icon(Icons.play_arrow),
                              onPressed: () => serviceCall(
                                  entity, 'media_player/media_play'),
                            ),
                            IconButton(
                              icon: const Icon(Icons.skip_next),
                              onPressed: () => serviceCall(
                                  entity, 'media_player/media_next_track'),
                            ),
                          ],
                        )),
                  ],
                ))),
    'scene': HomeAssistantDomain(
        id: 'scene',
        name: 'Scene',
        widgetFactory: (HomeAssistantEntity entity, Function serviceCall) =>
            ListTile(
              title: Text(entity.friendlyName),
              subtitle: Text(entity.entityId),
              trailing: const Icon(Icons.image),
              onTap: () => serviceCall(entity, 'scene/turn_on'),
            )),
  };

  late String id;
  late String name;
  late Function widgetFactory;

  HomeAssistantDomain(
      {required this.id, required this.name, required this.widgetFactory});
}
