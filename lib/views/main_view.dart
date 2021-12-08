import 'package:fafnir/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/home_assistant_connection.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  String? _result;
  late List<HomeAssistantConnection> _homeAssistantConnections;

  _MainViewState() {
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _homeAssistantConnections =
            HomeAssistantConnection.fromPrefs(prefs, homeAssistantUrlsKey);
      });
    });
  }

  Future<void> _scanToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = await FlutterBarcodeScanner.scanBarcode(
        '#${Colors.red.value.toRadixString(16)}', 'Cancel', true, ScanMode.QR);
    String? name, url;

    if (value == '-1') {
      await showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text('Scan failed'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Ok'))
                ],
              ));
      return;
    }

    await showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('Enter Name for the new connection'),
              content: Column(mainAxisSize: MainAxisSize.min, children: [
                TextField(
                  decoration: const InputDecoration(label: Text('Name')),
                  onChanged: (value) => name = value,
                ),
                TextField(
                  decoration: const InputDecoration(label: Text('Url')),
                  onChanged: (value) => url = value,
                )
              ]),
              actions: [
                TextButton(
                    onPressed: () {
                      name = null;
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel')),
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Save')),
              ],
            ));

    if (name == null || url == null) {
      return;
    }

    List<HomeAssistantConnection> connections =
        HomeAssistantConnection.fromPrefs(prefs, homeAssistantUrlsKey);
    connections
        .add(HomeAssistantConnection(name: name!, url: url!, token: value));
    HomeAssistantConnection.toPrefs(prefs, homeAssistantUrlsKey, connections);

    setState(() {
      _result = value;
      _homeAssistantConnections = connections;
    });
  }

  Future<void> _deleteConnection(HomeAssistantConnection connection) async {
    if (await showDialog<bool>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                  'Delete connection',
                ),
                content: Text('Really delete connection ${connection.name}?'),
                actions: [
                  TextButton(
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      List<HomeAssistantConnection> connections =
                          HomeAssistantConnection.fromPrefs(
                              prefs, homeAssistantUrlsKey);
                      connections.removeWhere((e) => e.name == connection.name);
                      HomeAssistantConnection.toPrefs(
                          prefs, homeAssistantUrlsKey, connections);
                      setState(() {
                        _homeAssistantConnections = connections;
                        Navigator.pop(context);
                      });
                    },
                    child: const Text(
                      'Delete',
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Cancel',
                    ),
                  )
                ],
              );
            }) ??
        false) {}
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
            leading: const Icon(Icons.add),
            title: const Text('Add Home Assistant connection'),
            onTap: _scanToken,
          ),
          ...(_homeAssistantConnections
              .map((e) => ListTile(
                    title: Text(e.name),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      color: Colors.red,
                      onPressed: () => _deleteConnection(e),
                    ),
                  ))
              .toList())
        ]),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _homeAssistantConnections.isEmpty ||
                    _homeAssistantConnections.first.entities == null
                ? const Text('Do iss nix!')
                : const Text(
                    'Do iss ebbes',
                  )
          ],
        ),
      ),
    );
  }
}
