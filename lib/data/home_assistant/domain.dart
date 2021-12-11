library home_assistant;

import 'package:fafnir/data/home_assistant/entity.dart';
import 'package:flutter/material.dart';

class DomainFeature {
  late String id;
  late String name;

  DomainFeature({required this.id, required this.name});
  DomainFeature.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

class _MediaPlayerFeature {
  String id;
  IconData icon;
  bool inactive;
  String serviceCall;

  static final Map<String, _MediaPlayerFeature> configurations =
      <String, _MediaPlayerFeature>{
    'previous': _MediaPlayerFeature(
        'previous', Icons.skip_previous, 'media_previous_track'),
    'next': _MediaPlayerFeature('next', Icons.skip_next, 'media_next_track'),
    'stop': _MediaPlayerFeature('stop', Icons.stop, 'media_stop'),
    'pause': _MediaPlayerFeature('pause', Icons.pause, 'media_pause'),
    'play': _MediaPlayerFeature('play', Icons.play_arrow, 'media_play'),
    'vol_up': _MediaPlayerFeature('vol_up', Icons.volume_up, 'volume_up'),
    'vol_mute_on':
        _MediaPlayerFeature('vol_mute_on', Icons.volume_mute, 'volume_mute'),
    'vol_mute_off': _MediaPlayerFeature(
        'vol_mute_off', Icons.volume_mute, 'volume_mute', true),
    'vol_down':
        _MediaPlayerFeature('vol_down', Icons.volume_down, 'volume_down'),
    'shuffle_on':
        _MediaPlayerFeature('shuffle_on', Icons.shuffle, 'shuffle_set'),
    'shuffle_off':
        _MediaPlayerFeature('shuffle_off', Icons.shuffle, 'shuffle_set', true),
    'repeat_on': _MediaPlayerFeature('repeat_on', Icons.repeat, 'repeat_set'),
    'repeat_off':
        _MediaPlayerFeature('repeat_off', Icons.repeat, 'repeat_set', true),
  };

  _MediaPlayerFeature(this.id, this.icon, this.serviceCall,
      [this.inactive = false]);
}

class Domain {
  static final Map<String, Domain> configurations = <String, Domain>{
    'light': Domain(
        id: 'light',
        name: 'Light',
        features: [],
        widgetFactory:
            (BuildContext context, Entity entity, Function serviceCall) =>
                ListTile(
                  title: Text(entity.friendlyName),
                  trailing: const Icon(Icons.lightbulb),
                  onTap: () => serviceCall(entity, 'light/toggle'),
                )),
    'switch': Domain(
        id: 'switch',
        name: 'Switch',
        features: [],
        widgetFactory:
            (BuildContext context, Entity entity, Function serviceCall) =>
                ListTile(
                  title: Text(entity.friendlyName),
                  trailing: const Icon(Icons.toggle_on),
                  onTap: () => serviceCall(entity, 'switch/toggle'),
                )),
    'media_player': Domain(
        id: 'media_player',
        name: 'Media Player',
        features: [
          DomainFeature(id: 'previous', name: 'Previous'),
          DomainFeature(id: 'next', name: 'Next'),
          DomainFeature(id: 'stop', name: 'Stop'),
          DomainFeature(id: 'pause', name: 'Pause'),
          DomainFeature(id: 'play', name: 'Play'),
          DomainFeature(id: 'vol_up', name: 'Volume up'),
          DomainFeature(id: 'vol_mute_on', name: 'Volume mute on'),
          DomainFeature(id: 'vol_mute_off', name: 'Volume mute off'),
          DomainFeature(id: 'vol_down', name: 'Volume down'),
          DomainFeature(id: 'shuffle_on', name: 'Shuffle on'),
          DomainFeature(id: 'shuffle_off', name: 'Shuffle off'),
          DomainFeature(id: 'repeat_on', name: 'Repeat on'),
          DomainFeature(id: 'repeat_off', name: 'Repeat off'),
        ],
        widgetFactory: (BuildContext context, Entity entity,
                Function serviceCall) =>
            Padding(
                padding:
                    kTabLabelPadding.copyWith(top: kMaterialListPadding.top),
                child: Column(
                  children: [
                    Row(
                      children: [Text(entity.friendlyName)],
                    ),
                    Padding(
                        padding: kMaterialListPadding,
                        child: Wrap(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.spaceEvenly,
                          children: entity.features
                              .map((feature) => IconButton(
                                    icon: Icon(
                                      _MediaPlayerFeature
                                          .configurations[feature.id]!.icon,
                                      color: _MediaPlayerFeature
                                              .configurations[feature.id]!
                                              .inactive
                                          ? Theme.of(context).disabledColor
                                          : Theme.of(context).iconTheme.color,
                                    ),
                                    onPressed: () => serviceCall(entity,
                                        'media_player/${_MediaPlayerFeature.configurations[feature.id]!.serviceCall}'),
                                  ))
                              .toList(),
                        )),
                  ],
                ))),
    'scene': Domain(
        id: 'scene',
        name: 'Scene',
        features: [],
        widgetFactory:
            (BuildContext context, Entity entity, Function serviceCall) =>
                ListTile(
                  title: Text(entity.friendlyName),
                  subtitle: Text(entity.entityId),
                  trailing: const Icon(Icons.image),
                  onTap: () => serviceCall(entity, 'scene/turn_on'),
                )),
    'input_boolean': Domain(
        id: 'input_boolean',
        name: 'Boolean input',
        features: [],
        widgetFactory:
            (BuildContext context, Entity entity, Function serviceCall) =>
                ListTile(
                  title: Text(entity.friendlyName),
                  trailing: const Icon(Icons.code),
                  onTap: () => serviceCall(entity, 'input_boolean/toggle'),
                )),
  };

  late String id;
  late String name;
  late Function widgetFactory;
  late List<DomainFeature> features;

  Domain(
      {required this.id,
      required this.name,
      required this.widgetFactory,
      required this.features});
}

extension DomainFeatureList on List<DomainFeature> {
  static List<DomainFeature> fromJson(List<dynamic> json) {
    List<DomainFeature> list = List.empty(growable: true);
    for (var feature in json) {
      list.add(DomainFeature.fromJson(feature));
    }
    return list;
  }

  List<dynamic> toJson() => map((feature) => feature.toJson()).toList();
}
