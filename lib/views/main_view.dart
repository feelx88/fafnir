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
  int _selection = 0;
  bool _editMode = false;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _homeAssistantConnections =
          HomeAssistantConnection.fromPrefs(prefs, homeAssistantUrlsKey);
      _selection =
          int.parse(prefs.getString(selectedHomeAssistantIndex) ?? '0');
    });
  }

  void _save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    HomeAssistantConnection.toPrefs(
        prefs, homeAssistantUrlsKey, _homeAssistantConnections);
    prefs.setString(selectedHomeAssistantIndex, _selection.toString());
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
            arguments: SelectEntityViewArguments(
                _homeAssistantConnections.elementAt(_selection)))
        as HomeAssistantEntity?;

    if (result == null) {
      return;
    }

    setState(() {
      _homeAssistantConnections.elementAt(_selection).entities.add(result);
    });

    _editEntity(_homeAssistantConnections.elementAt(_selection).entities.length,
        result);

    _save();
  }

  void _removeEntity(HomeAssistantEntity entity) {
    ConfirmDialog.create(context, 'Remove entity',
        'Do you want to remove entity ${entity.friendlyName}?', 'Remove', () {
      setState(() {
        _homeAssistantConnections.elementAt(_selection).entities.remove(entity);
        Navigator.pop(context);
      });

      _save();
    }, positiveButtonColor: Theme.of(context).errorColor);
  }

  void _editEntity(int index, HomeAssistantEntity entity) async {
    var result =
        await Navigator.pushNamed(context, '/edit_entity', arguments: entity)
            as HomeAssistantEntity?;

    if (result == null) {
      return;
    }

    setState(() {
      _homeAssistantConnections.elementAt(_selection).entities[index] = entity;
    });

    _save();
  }

  void _toggleEntity(HomeAssistantEntity entity) async {
    late String service;

    switch (entity.serviceDomain) {
      case 'light':
      case 'switch':
        service = '${entity.serviceDomain}/toggle';
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
            '${_homeAssistantConnections.elementAt(_selection).url}/api/services/$service'),
        headers: {
          'Authorization':
              'Bearer ${_homeAssistantConnections.elementAt(_selection).token}'
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
            trailing: const Icon(Icons.add),
            onTap: _addConnection,
          ),
          SwitchListTile(
            title: const Text('Edit mode'),
            value: _editMode,
            onChanged: (value) => setState(() {
              _editMode = value;
            }),
          ),
          const Divider(),
          ...(_homeAssistantConnections
              .asMap()
              .map((index, connection) => MapEntry(
                  index,
                  CheckboxListTile(
                    title: Text(connection.name),
                    value: _selection == index,
                    secondary: _editMode
                        ? IconButton(
                            icon: const Icon(Icons.delete),
                            padding: EdgeInsets.zero,
                            visualDensity: VisualDensity.compact,
                            alignment: Alignment.centerLeft,
                            color: Colors.red,
                            onPressed: () => _deleteConnection(connection),
                          )
                        : const Icon(Icons.home),
                    onChanged: (value) {
                      if (value!) {
                        setState(() {
                          _selection = index;
                        });
                        _save();
                      }
                      _save();
                    },
                  )))
              .values
              .toList())
        ]),
      ),
      body: _homeAssistantConnections.isEmpty ||
              _homeAssistantConnections.elementAt(_selection).entities.isEmpty
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
              children: _homeAssistantConnections
                  .elementAt(_selection)
                  .entities
                  .toList()
                  .asMap()
                  .map((index, entity) => MapEntry(
                      index,
                      ListTile(
                        title: Text(entity.friendlyName),
                        subtitle: Text(entity.entityId),
                        onTap: () => _editMode
                            ? _editEntity(index, entity)
                            : _toggleEntity(entity),
                        trailing: _editMode
                            ? IconButton(
                                icon: const Icon(Icons.delete),
                                color: Colors.red,
                                onPressed: () => _removeEntity(entity),
                              )
                            : null,
                      )))
                  .values
                  .toList(),
            ),
      floatingActionButton: _homeAssistantConnections.isNotEmpty && _editMode
          ? FloatingActionButton(
              onPressed: () {
                if (_editMode) {
                  _addEntity();
                }
              },
              child: const Icon(Icons.add),
            )
          : const SizedBox.shrink(),
    );
  }
}
