library home_assistant;

import 'package:fafnir/data/home_assistant/entity.dart';
import 'package:flutter/material.dart';

class Domain {
  static final Map<String, Domain> configurations = <String, Domain>{
    'light': Domain(
        id: 'light',
        name: 'Light',
        widgetFactory: (Entity entity, Function serviceCall) => ListTile(
              title: Text(entity.friendlyName),
              trailing: const Icon(Icons.lightbulb),
              onTap: () => serviceCall(entity, 'light/toggle'),
            )),
    'switch': Domain(
        id: 'switch',
        name: 'Switch',
        widgetFactory: (Entity entity, Function serviceCall) => ListTile(
              title: Text(entity.friendlyName),
              trailing: const Icon(Icons.toggle_on),
              onTap: () => serviceCall(entity, 'switch/toggle'),
            )),
    'media_player': Domain(
        id: 'media_player',
        name: 'Media Player',
        widgetFactory: (Entity entity, Function serviceCall) => Padding(
            padding: kTabLabelPadding.copyWith(top: kMaterialListPadding.top),
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
                          onPressed: () =>
                              serviceCall(entity, 'media_player/media_pause'),
                        ),
                        IconButton(
                          icon: const Icon(Icons.play_arrow),
                          onPressed: () =>
                              serviceCall(entity, 'media_player/media_play'),
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
    'scene': Domain(
        id: 'scene',
        name: 'Scene',
        widgetFactory: (Entity entity, Function serviceCall) => ListTile(
              title: Text(entity.friendlyName),
              subtitle: Text(entity.entityId),
              trailing: const Icon(Icons.image),
              onTap: () => serviceCall(entity, 'scene/turn_on'),
            )),
    'input_boolean': Domain(
        id: 'input_boolean',
        name: 'Boolean input',
        widgetFactory: (Entity entity, Function serviceCall) => ListTile(
              title: Text(entity.friendlyName),
              trailing: const Icon(Icons.code),
              onTap: () => serviceCall(entity, 'input_boolean/toggle'),
            )),
  };

  late String id;
  late String name;
  late Function widgetFactory;

  Domain({required this.id, required this.name, required this.widgetFactory});
}
