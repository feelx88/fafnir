import 'package:fafnir/constants.dart';
import 'package:fafnir/dialogs/add_connection_dialog.dart';
import 'package:fafnir/dialogs/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/home_assistant_connection.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late List<HomeAssistantConnection> _homeAssistantConnections;

  _MainViewState() {
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _homeAssistantConnections =
            HomeAssistantConnection.fromPrefs(prefs, homeAssistantUrlsKey);
      });
    });
  }

  void _addConnection([String? name, String? url, String? token]) async {
    AddConnectionDialog.create(context, name, url, token,
        (name, url, token) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      List<HomeAssistantConnection> connections =
          HomeAssistantConnection.fromPrefs(prefs, homeAssistantUrlsKey);
      connections
          .add(HomeAssistantConnection(name: name!, url: url!, token: token!));
      HomeAssistantConnection.toPrefs(prefs, homeAssistantUrlsKey, connections);

      setState(() {
        _homeAssistantConnections = connections;
      });

      Navigator.pop(context);
    });
  }

  Future<void> _deleteConnection(HomeAssistantConnection connection) async {
    ConfirmDialog.create(context, 'Delete connection',
        'Really delete connection ${connection.name}?', 'Delete', () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<HomeAssistantConnection> connections =
          HomeAssistantConnection.fromPrefs(prefs, homeAssistantUrlsKey);
      connections.removeWhere(
          (connectionToCheck) => connectionToCheck.name == connection.name);
      HomeAssistantConnection.toPrefs(prefs, homeAssistantUrlsKey, connections);
      setState(() {
        _homeAssistantConnections = connections;
        Navigator.pop(context);
      });
    });
  }

  void _addEntity() {}

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
            leading: const Icon(Icons.add),
            title: const Text('Add Home Assistant connection'),
            onTap: _addConnection,
          ),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _homeAssistantConnections.isEmpty
              ? <Widget>[
                  _homeAssistantConnections.isEmpty
                      ? const Text('No connections configured')
                      : const SizedBox.shrink(),
                ]
              : <Widget>[
                  _homeAssistantConnections.first.entities == null
                      ? const Text('No entities configured')
                      : const SizedBox.shrink(),
                ],
        ),
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
