// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(friendlyName) =>
      "Do you want to remove entity ${friendlyName}?";

  static String m1(connectionName) =>
      "Really delete connection ${connectionName}?";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addHomeAssistantConnection": MessageLookupByLibrary.simpleMessage(
            "Add Home Assistant connection"),
        "booleanInput": MessageLookupByLibrary.simpleMessage("Boolean input"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "deleteConnection":
            MessageLookupByLibrary.simpleMessage("Delete connection"),
        "doYouWantToRemoveEntityEntityfriendlyname": m0,
        "domain": MessageLookupByLibrary.simpleMessage("Domain"),
        "editMode": MessageLookupByLibrary.simpleMessage("Edit mode"),
        "entityId": MessageLookupByLibrary.simpleMessage("Entity id"),
        "filter": MessageLookupByLibrary.simpleMessage("Filter"),
        "friendlyName": MessageLookupByLibrary.simpleMessage("Friendly name"),
        "light": MessageLookupByLibrary.simpleMessage("Light"),
        "mediaPlayer": MessageLookupByLibrary.simpleMessage("Media Player"),
        "name": MessageLookupByLibrary.simpleMessage("Name"),
        "newConnection": MessageLookupByLibrary.simpleMessage("New connection"),
        "next": MessageLookupByLibrary.simpleMessage("Next"),
        "noConnectionsConfigured":
            MessageLookupByLibrary.simpleMessage("No connections configured"),
        "noEntitiesConfigured":
            MessageLookupByLibrary.simpleMessage("No entities configured"),
        "pause": MessageLookupByLibrary.simpleMessage("Pause"),
        "play": MessageLookupByLibrary.simpleMessage("Play"),
        "previous": MessageLookupByLibrary.simpleMessage("Previous"),
        "reallyDeleteConnectionConnectionname": m1,
        "remove": MessageLookupByLibrary.simpleMessage("Remove"),
        "removeEntity": MessageLookupByLibrary.simpleMessage("Remove entity"),
        "repeatAll": MessageLookupByLibrary.simpleMessage("Repeat all"),
        "repeatOff": MessageLookupByLibrary.simpleMessage("Repeat off"),
        "repeatOne": MessageLookupByLibrary.simpleMessage("Repeat one"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "scanQrCode": MessageLookupByLibrary.simpleMessage("Scan QR Code"),
        "scene": MessageLookupByLibrary.simpleMessage("Scene"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "showOnLockscreen":
            MessageLookupByLibrary.simpleMessage("Show on Lockscreen"),
        "shuffleOff": MessageLookupByLibrary.simpleMessage("Shuffle off"),
        "shuffleOn": MessageLookupByLibrary.simpleMessage("Shuffle on"),
        "stop": MessageLookupByLibrary.simpleMessage("Stop"),
        "switchDomain": MessageLookupByLibrary.simpleMessage("Switch"),
        "token": MessageLookupByLibrary.simpleMessage("Token"),
        "url": MessageLookupByLibrary.simpleMessage("Url"),
        "volumeDown": MessageLookupByLibrary.simpleMessage("Volume down"),
        "volumeMuteOff":
            MessageLookupByLibrary.simpleMessage("Volume mute off"),
        "volumeMuteOn": MessageLookupByLibrary.simpleMessage("Volume mute on"),
        "volumeUp": MessageLookupByLibrary.simpleMessage("Volume up")
      };
}
