// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Delete connection`
  String get deleteConnection {
    return Intl.message(
      'Delete connection',
      name: 'deleteConnection',
      desc: '',
      args: [],
    );
  }

  /// `Really delete connection {connectionName}?`
  String reallyDeleteConnectionConnectionname(Object connectionName) {
    return Intl.message(
      'Really delete connection $connectionName?',
      name: 'reallyDeleteConnectionConnectionname',
      desc: '',
      args: [connectionName],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Remove entity`
  String get removeEntity {
    return Intl.message(
      'Remove entity',
      name: 'removeEntity',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get remove {
    return Intl.message(
      'Remove',
      name: 'remove',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to remove entity {friendlyName}?`
  String doYouWantToRemoveEntityEntityfriendlyname(Object friendlyName) {
    return Intl.message(
      'Do you want to remove entity $friendlyName?',
      name: 'doYouWantToRemoveEntityEntityfriendlyname',
      desc: '',
      args: [friendlyName],
    );
  }

  /// `No connections configured`
  String get noConnectionsConfigured {
    return Intl.message(
      'No connections configured',
      name: 'noConnectionsConfigured',
      desc: '',
      args: [],
    );
  }

  /// `No entities configured`
  String get noEntitiesConfigured {
    return Intl.message(
      'No entities configured',
      name: 'noEntitiesConfigured',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Add Home Assistant connection`
  String get addHomeAssistantConnection {
    return Intl.message(
      'Add Home Assistant connection',
      name: 'addHomeAssistantConnection',
      desc: '',
      args: [],
    );
  }

  /// `Show on Lockscreen`
  String get showOnLockscreen {
    return Intl.message(
      'Show on Lockscreen',
      name: 'showOnLockscreen',
      desc: '',
      args: [],
    );
  }

  /// `Edit mode`
  String get editMode {
    return Intl.message(
      'Edit mode',
      name: 'editMode',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get filter {
    return Intl.message(
      'Filter',
      name: 'filter',
      desc: '',
      args: [],
    );
  }

  /// `Friendly name`
  String get friendlyName {
    return Intl.message(
      'Friendly name',
      name: 'friendlyName',
      desc: '',
      args: [],
    );
  }

  /// `Entity id`
  String get entityId {
    return Intl.message(
      'Entity id',
      name: 'entityId',
      desc: '',
      args: [],
    );
  }

  /// `Domain`
  String get domain {
    return Intl.message(
      'Domain',
      name: 'domain',
      desc: '',
      args: [],
    );
  }

  /// `New connection`
  String get newConnection {
    return Intl.message(
      'New connection',
      name: 'newConnection',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Url`
  String get url {
    return Intl.message(
      'Url',
      name: 'url',
      desc: '',
      args: [],
    );
  }

  /// `Token`
  String get token {
    return Intl.message(
      'Token',
      name: 'token',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Scan QR Code`
  String get scanQrCode {
    return Intl.message(
      'Scan QR Code',
      name: 'scanQrCode',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get light {
    return Intl.message(
      'Light',
      name: 'light',
      desc: '',
      args: [],
    );
  }

  /// `Switch`
  String get switchDomain {
    return Intl.message(
      'Switch',
      name: 'switchDomain',
      desc: '',
      args: [],
    );
  }

  /// `Media Player`
  String get mediaPlayer {
    return Intl.message(
      'Media Player',
      name: 'mediaPlayer',
      desc: '',
      args: [],
    );
  }

  /// `Scene`
  String get scene {
    return Intl.message(
      'Scene',
      name: 'scene',
      desc: '',
      args: [],
    );
  }

  /// `Boolean input`
  String get booleanInput {
    return Intl.message(
      'Boolean input',
      name: 'booleanInput',
      desc: '',
      args: [],
    );
  }

  /// `Previous`
  String get previous {
    return Intl.message(
      'Previous',
      name: 'previous',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Stop`
  String get stop {
    return Intl.message(
      'Stop',
      name: 'stop',
      desc: '',
      args: [],
    );
  }

  /// `Pause`
  String get pause {
    return Intl.message(
      'Pause',
      name: 'pause',
      desc: '',
      args: [],
    );
  }

  /// `Play`
  String get play {
    return Intl.message(
      'Play',
      name: 'play',
      desc: '',
      args: [],
    );
  }

  /// `Volume up`
  String get volumeUp {
    return Intl.message(
      'Volume up',
      name: 'volumeUp',
      desc: '',
      args: [],
    );
  }

  /// `Volume mute on`
  String get volumeMuteOn {
    return Intl.message(
      'Volume mute on',
      name: 'volumeMuteOn',
      desc: '',
      args: [],
    );
  }

  /// `Volume mute off`
  String get volumeMuteOff {
    return Intl.message(
      'Volume mute off',
      name: 'volumeMuteOff',
      desc: '',
      args: [],
    );
  }

  /// `Volume down`
  String get volumeDown {
    return Intl.message(
      'Volume down',
      name: 'volumeDown',
      desc: '',
      args: [],
    );
  }

  /// `Shuffle on`
  String get shuffleOn {
    return Intl.message(
      'Shuffle on',
      name: 'shuffleOn',
      desc: '',
      args: [],
    );
  }

  /// `Shuffle off`
  String get shuffleOff {
    return Intl.message(
      'Shuffle off',
      name: 'shuffleOff',
      desc: '',
      args: [],
    );
  }

  /// `Repeat off`
  String get repeatOff {
    return Intl.message(
      'Repeat off',
      name: 'repeatOff',
      desc: '',
      args: [],
    );
  }

  /// `Repeat one`
  String get repeatOne {
    return Intl.message(
      'Repeat one',
      name: 'repeatOne',
      desc: '',
      args: [],
    );
  }

  /// `Repeat all`
  String get repeatAll {
    return Intl.message(
      'Repeat all',
      name: 'repeatAll',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'de'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
