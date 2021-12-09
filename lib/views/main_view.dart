import 'dart:convert';

import 'package:fafnir/constants.dart';
import 'package:fafnir/data/home_assistant_entity.dart';
import 'package:fafnir/dialogs/add_connection_dialog.dart';
import 'package:fafnir/dialogs/confirm_dialog.dart';
import 'package:fafnir/views/select_entity_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/home_assistant_connection.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<HomeAssistantConnection> _homeAssistantConnections = List.empty();

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _homeAssistantConnections =
          HomeAssistantConnection.fromPrefs(prefs, homeAssistantUrlsKey);
    });
  }

  void _save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    HomeAssistantConnection.toPrefs(
        prefs, homeAssistantUrlsKey, _homeAssistantConnections);
  }

  void _addConnection([String? name, String? url, String? token]) {
    AddConnectionDialog.create(context, name, url, token, (name, url, token) {
      setState(() {
        _homeAssistantConnections.add(
            HomeAssistantConnection(name: name!, url: url!, token: token!));
      });

      _save();

      Navigator.pop(context);
    });
  }

  void _deleteConnection(HomeAssistantConnection connection) {
    ConfirmDialog.create(
      context,
      'Delete connection',
      'Really delete connection ${connection.name}?',
      'Delete',
      () {
        setState(() {
          _homeAssistantConnections.removeWhere(
              (connectionToCheck) => connectionToCheck.name == connection.name);
          Navigator.pop(context);
        });

        _save();
      },
      positiveButtonColor: Theme.of(context).errorColor,
    );
  }

  void _addEntity() async {
    var result = await Navigator.of(context).pushNamed('/select_entity',
        arguments: SelectEntityViewArguments(_homeAssistantConnections.first));

    if (result == null) {
      return;
    }

    setState(() {
      _homeAssistantConnections.first.entities
          ?.add(result as HomeAssistantEntity);
    });

    _save();
  }

  void _removeEntity(HomeAssistantEntity entity) {
    ConfirmDialog.create(context, 'Remove entity',
        'Do you want to remove entity ${entity.friendlyName}?', 'Remove', () {
      setState(() {
        _homeAssistantConnections.first.entities?.remove(entity);
        Navigator.pop(context);
      });

      _save();
    }, positiveButtonColor: Theme.of(context).errorColor);
  }

  void _toggleEntity(HomeAssistantEntity entity) async {
    String domain = entity.entityId.split('.').first;
    late String service;

    switch (domain) {
      case 'light':
      case 'switch':
        service = '$domain/toggle';
        break;
      case 'scene':
        service = 'scene/turn_on';
        break;
      case 'group':
        service = 'light/toggle';
        break;
    }

    await Client().post(
        Uri.parse(
            '${_homeAssistantConnections.first.url}/api/services/$service'),
        headers: {
          'Authorization': 'Bearer ${_homeAssistantConnections.first.token}'
        },
        body: jsonEncode({'entity_id': entity.entityId}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        key: const Key('drawer'),
        child: ListView(children: [
          DrawerHeader(
            child:
                Text('Settings', style: Theme.of(context).textTheme.headline4),
            decoration: const BoxDecoration(
              color: Colors.blueGrey,
            ),
          ),
          ListTile(
            title: const Text('Add Home Assistant connection'),
            onTap: _addConnection,
          ),
          const Divider(),
          ...(_homeAssistantConnections
              .map((connection) => ListTile(
                    title: Text(connection.name),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      color: Colors.red,
                      onPressed: () => _deleteConnection(connection),
                    ),
                  ))
              .toList())
        ]),
      ),
      body: _homeAssistantConnections.isEmpty ||
              _homeAssistantConnections.first.entities == null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _homeAssistantConnections.isEmpty
                      ? const Text('No connections configured')
                      : const Text('No entities configured')
                ],
              ),
            )
          : ListView(
              children: _homeAssistantConnections.first.entities!
                  .map((entity) => ListTile(
                        title: Text(entity.friendlyName),
                        subtitle: Text(entity.entityId),
                        onTap: () => _toggleEntity(entity),
                        onLongPress: () => _removeEntity(entity),
                      ))
                  .toList(),
            ),
      floatingActionButton: _homeAssistantConnections.isNotEmpty
          ? FloatingActionButton(
              onPressed: _addEntity,
              child: const Icon(Icons.add),
            )
          : const SizedBox.shrink(),
    );
  }
}
