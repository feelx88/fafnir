library home_assistant;

import 'package:fafnir/data/home_assistant/entity.dart';
import 'package:fafnir/generated/l10n.dart';
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
  Map<String, dynamic>? additionalBody;

  static final Map<String, _MediaPlayerFeature> configurations =
      <String, _MediaPlayerFeature>{
    'previous': _MediaPlayerFeature(
        'previous', Icons.skip_previous, 'media_previous_track'),
    'next': _MediaPlayerFeature('next', Icons.skip_next, 'media_next_track'),
    'stop': _MediaPlayerFeature('stop', Icons.stop, 'media_stop'),
    'pause': _MediaPlayerFeature('pause', Icons.pause, 'media_pause'),
    'play': _MediaPlayerFeature('play', Icons.play_arrow, 'media_play'),
    'vol_up': _MediaPlayerFeature('vol_up', Icons.volume_up, 'volume_up'),
    'vol_mute_on': _MediaPlayerFeature('vol_mute_on', Icons.volume_mute,
        'volume_mute', {'is_volume_muted': true}),
    'vol_mute_off': _MediaPlayerFeature('vol_mute_off', Icons.volume_mute,
        'volume_mute', {'is_volume_muted': false}, true),
    'vol_down':
        _MediaPlayerFeature('vol_down', Icons.volume_down, 'volume_down'),
    'shuffle_on': _MediaPlayerFeature(
        'shuffle_on', Icons.shuffle, 'shuffle_set', {'shuffle': true}),
    'shuffle_off': _MediaPlayerFeature(
        'shuffle_off', Icons.shuffle, 'shuffle_set', {'shuffle': false}, true),
    'repeat_off': _MediaPlayerFeature(
        'repeat_off', Icons.repeat, 'repeat_set', {'repeat': 'off'}, true),
    'repeat_one': _MediaPlayerFeature(
        'repeat_one', Icons.repeat_one, 'repeat_set', {'repeat': 'one'}),
    'repeat_all': _MediaPlayerFeature(
        'repeat_all', Icons.repeat, 'repeat_set', {'repeat': 'all'}),
  };

  _MediaPlayerFeature(this.id, this.icon, this.serviceCall,
      [this.additionalBody, this.inactive = false]);
}

class Domain {
  static final Map<String, Domain> configurations = <String, Domain>{
    'light': Domain(
        id: 'light',
        name: S.current.light,
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
        name: S.current.switchDomain,
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
        name: S.current.mediaPlayer,
        features: [
          DomainFeature(id: 'previous', name: S.current.previous),
          DomainFeature(id: 'next', name: S.current.next),
          DomainFeature(id: 'stop', name: S.current.stop),
          DomainFeature(id: 'pause', name: S.current.pause),
          DomainFeature(id: 'play', name: S.current.play),
          DomainFeature(id: 'vol_up', name: S.current.volumeUp),
          DomainFeature(id: 'vol_mute_on', name: S.current.volumeMuteOn),
          DomainFeature(id: 'vol_mute_off', name: S.current.volumeMuteOff),
          DomainFeature(id: 'vol_down', name: S.current.volumeDown),
          DomainFeature(id: 'shuffle_on', name: S.current.shuffleOn),
          DomainFeature(id: 'shuffle_off', name: S.current.shuffleOff),
          DomainFeature(id: 'repeat_off', name: S.current.repeatOff),
          DomainFeature(id: 'repeat_one', name: S.current.repeatOne),
          DomainFeature(id: 'repeat_all', name: S.current.repeatAll),
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
                                    onPressed: () => serviceCall(
                                        entity,
                                        'media_player/${_MediaPlayerFeature.configurations[feature.id]!.serviceCall}',
                                        _MediaPlayerFeature
                                            .configurations[feature.id]!
                                            .additionalBody),
                                  ))
                              .toList(),
                        )),
                  ],
                ))),
    'scene': Domain(
        id: 'scene',
        name: S.current.scene,
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
        name: S.current.booleanInput,
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
