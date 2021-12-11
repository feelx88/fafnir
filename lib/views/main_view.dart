import 'dart:convert';

import 'package:fafnir/constants.dart';
import 'package:fafnir/data/home_assistant/domain.dart';
import 'package:fafnir/data/home_assistant/entity.dart';
import 'package:fafnir/dialogs/add_connection_dialog.dart';
import 'package:fafnir/dialogs/confirm_dialog.dart';
import 'package:fafnir/views/select_entity_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/home_assistant/connection.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Connection> _Connections = List.empty();
  int _selection = 0;
  bool _editMode = false;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _Connections = Connection.fromPrefs(prefs, homeAssistantUrlsKey);
      _selection =
          int.parse(prefs.getString(selectedHomeAssistantIndex) ?? '0');
    });
  }

  void _save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Connection.toPrefs(prefs, homeAssistantUrlsKey, _Connections);
    prefs.setString(selectedHomeAssistantIndex, _selection.toString());
  }

  void _addConnection([String? name, String? url, String? token]) {
    AddConnectionDialog.create(context, name, url, token, (name, url, token) {
      setState(() {
        _Connections.add(Connection(name: name!, url: url!, token: token!));
      });

      _save();

      Navigator.pop(context);
    });
  }

  void _deleteConnection(Connection connection) {
    ConfirmDialog.create(
      context,
      'Delete connection',
      'Really delete connection ${connection.name}?',
      'Delete',
      () {
        setState(() {
          _Connections.removeWhere(
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
            arguments:
                SelectEntityViewArguments(_Connections.elementAt(_selection)))
        as Entity?;

    if (result == null) {
      return;
    }

    setState(() {
      _Connections.elementAt(_selection).entities.add(result);
    });

    _editEntity(_Connections.elementAt(_selection).entities.length - 1, result);

    _save();
  }

  Future<bool?> _removeEntity(Entity entity) {
    return ConfirmDialog.create(context, 'Remove entity',
        'Do you want to remove entity ${entity.friendlyName}?', 'Remove', () {
      setState(() {
        _Connections.elementAt(_selection).entities.remove(entity);
        Navigator.pop(context);
      });

      _save();
    },
        positiveButtonColor: Theme.of(context).errorColor,
        cancelCallback: () => setState(() {
              _Connections = _Connections;
            }));
  }

  void _reorderEntities(oldIndex, newIndex) {
    setState(() {
      _Connections.elementAt(_selection).entities.insert(
          newIndex - (oldIndex < newIndex ? 1 : 0),
          _Connections.elementAt(_selection).entities.removeAt(oldIndex));
    });

    _save();
  }

  void _editEntity(int index, Entity entity) async {
    var result =
        await Navigator.pushNamed(context, '/edit_entity', arguments: entity)
            as Entity?;

    if (result == null) {
      return;
    }

    setState(() {
      _Connections.elementAt(_selection).entities[index] = entity;
    });

    _save();
  }

  void _serviceCall(Entity entity, String service,
      [Map<String, dynamic>? additionalBodyData]) async {
    Map<String, dynamic> body = {'entity_id': entity.entityId};
    body.addAll(additionalBodyData ?? {});

    await Client().post(
        Uri.parse(
            '${_Connections.elementAt(_selection).url}/api/services/$service'),
        headers: {
          'Authorization': 'Bearer ${_Connections.elementAt(_selection).token}'
        },
        body: jsonEncode(body));
  }

  Widget _body() {
    // Empty text
    if (_Connections.isEmpty ||
        _Connections.elementAt(_selection).entities.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _Connections.isEmpty
                ? const Text('No connections configured')
                : const Text('No entities configured')
          ],
        ),
      );
    }

    // Prepare entity map
    Map<int, Entity> map =
        _Connections.elementAt(_selection).entities.toList().asMap();

    // Show edit mode list tiles
    if (_editMode) {
      return ReorderableListView(
          buildDefaultDragHandles: true,
          children: map
              .map((index, entity) => MapEntry(
                  index,
                  Dismissible(
                      key: Key(entity.entityId),
                      confirmDismiss: (direction) => _removeEntity(entity),
                      child: ListTile(
                        title: Text(entity.friendlyName),
                        subtitle: Text(entity.entityId),
                        onTap: () => _editEntity(index, entity),
                        trailing: ReorderableDragStartListener(
                            index: index, child: const Icon(Icons.drag_handle)),
                        leading: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Theme.of(context).errorColor,
                          ),
                          onPressed: () => _removeEntity(entity),
                        ),
                      ))))
              .values
              .toList(),
          onReorder: _reorderEntities);
    }

    // Show the domain-specific implementation of the entities
    return ListView(
      children: map
          .map((index, entity) => MapEntry(
              index,
              Domain.configurations[entity.serviceDomain]!
                  .widgetFactory(context, entity, _serviceCall) as Widget))
          .values
          .toList(),
    );
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
          ...(_Connections.asMap()
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
      body: _body(),
      floatingActionButton: _Connections.isNotEmpty && _editMode
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
