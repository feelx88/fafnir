// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de locale. All the
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
  String get localeName => 'de';

  static String m0(friendlyName) =>
      "Soll die Entität ${friendlyName} wirklich netfernt werden?";

  static String m1(connectionName) =>
      "Soll die Verbindung ${connectionName} wirklich gelöscht werden?";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addHomeAssistantConnection": MessageLookupByLibrary.simpleMessage(
            "Home- Assistant-Verbindung hinzufügen"),
        "booleanInput":
            MessageLookupByLibrary.simpleMessage("\"Umschalten\"-Helfer"),
        "cancel": MessageLookupByLibrary.simpleMessage("Abbrechen"),
        "delete": MessageLookupByLibrary.simpleMessage("Löschen"),
        "deleteConnection":
            MessageLookupByLibrary.simpleMessage("Verbindung löschen"),
        "doYouWantToRemoveEntityEntityfriendlyname": m0,
        "domain": MessageLookupByLibrary.simpleMessage("Domäne"),
        "editMode": MessageLookupByLibrary.simpleMessage("Bearbeitungsmodus"),
        "entityId": MessageLookupByLibrary.simpleMessage("Entitäts-Id"),
        "filter": MessageLookupByLibrary.simpleMessage("Filter"),
        "friendlyName": MessageLookupByLibrary.simpleMessage(
            "Lesbarer Name (\"Friendly name\")"),
        "light": MessageLookupByLibrary.simpleMessage("Licht"),
        "mediaPlayer": MessageLookupByLibrary.simpleMessage("Media Player"),
        "name": MessageLookupByLibrary.simpleMessage("Name"),
        "newConnection":
            MessageLookupByLibrary.simpleMessage("Neue Verbindung"),
        "next": MessageLookupByLibrary.simpleMessage("Weiter"),
        "noConnectionsConfigured": MessageLookupByLibrary.simpleMessage(
            "Keine Verbindung konfiguriert"),
        "noEntitiesConfigured": MessageLookupByLibrary.simpleMessage(
            "Keine Entitäten konfiguriert"),
        "pause": MessageLookupByLibrary.simpleMessage("Pause"),
        "play": MessageLookupByLibrary.simpleMessage("Play"),
        "previous": MessageLookupByLibrary.simpleMessage("Zurück"),
        "reallyDeleteConnectionConnectionname": m1,
        "remove": MessageLookupByLibrary.simpleMessage("Entfernen"),
        "removeEntity":
            MessageLookupByLibrary.simpleMessage("Entität entfernen"),
        "repeatAll": MessageLookupByLibrary.simpleMessage("Alles wiederholen"),
        "repeatOff": MessageLookupByLibrary.simpleMessage("Nichts wiederholen"),
        "repeatOne": MessageLookupByLibrary.simpleMessage("Titel wiederholen"),
        "save": MessageLookupByLibrary.simpleMessage("Speichern"),
        "scanQrCode": MessageLookupByLibrary.simpleMessage("QR-Code scannen"),
        "scene": MessageLookupByLibrary.simpleMessage("Szene"),
        "settings": MessageLookupByLibrary.simpleMessage("Einstellungen"),
        "showOnLockscreen": MessageLookupByLibrary.simpleMessage(
            "Auf dem Sperrbildschirm anzeigen"),
        "shuffleOff": MessageLookupByLibrary.simpleMessage(
            "Zufällige Wiedergabe ausschalten"),
        "shuffleOn": MessageLookupByLibrary.simpleMessage(
            "Zufällige Wiedergabe einschalten"),
        "stop": MessageLookupByLibrary.simpleMessage("Stop"),
        "switchDomain": MessageLookupByLibrary.simpleMessage("Schalter"),
        "token": MessageLookupByLibrary.simpleMessage("Token"),
        "url": MessageLookupByLibrary.simpleMessage("Url"),
        "volumeDown":
            MessageLookupByLibrary.simpleMessage("Lautstärke verringern"),
        "volumeMuteOff":
            MessageLookupByLibrary.simpleMessage("Ton aus ausschalten"),
        "volumeMuteOn":
            MessageLookupByLibrary.simpleMessage("Ton aus einschalten"),
        "volumeUp": MessageLookupByLibrary.simpleMessage("Lautstärke erhöhen")
      };
}
