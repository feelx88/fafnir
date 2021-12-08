import 'dart:convert';

import 'package:fafnir/data/home_assistant_connection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SelectEntityView extends StatefulWidget {
  const SelectEntityView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<SelectEntityView> createState() => _SelectEntityViewState();
}

class SelectEntityViewArguments {
  final HomeAssistantConnection connection;
  SelectEntityViewArguments(this.connection);
}

class _SelectEntityViewState extends State<SelectEntityView> {
  List<dynamic>? _entities;
  bool _searching = false;
  String _filter = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SelectEntityViewArguments args =
        ModalRoute.of(context)!.settings.arguments as SelectEntityViewArguments;

    Client().get(Uri.parse('${args.connection.url}/api/states'), headers: {
      'Authorization': 'Bearer ${args.connection.token}'
    }).then((data) {
      setState(() {
        _entities = jsonDecode(data.body);
      });
    });
  }

  bool _filterFn(element) {
    return _filter == '' ||
        (element['entity_id'] ?? '')
            .contains(RegExp(_filter, caseSensitive: false)) ||
        (element['attributes']['friendly_name'] ?? '')
            .contains(RegExp(_filter, caseSensitive: false));
  }

  void _toggleFilter() {
    setState(() {
      _searching = !_searching;
      _filter = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: _searching
                ? TextField(
                    autofocus: true,
                    decoration: const InputDecoration(label: Text('Filter')),
                    onChanged: (value) => setState(() {
                      _filter = value;
                    }),
                  )
                : Text(widget.title),
          ),
          actions: [
            IconButton(
                onPressed: _toggleFilter,
                icon: _searching
                    ? const Icon(Icons.clear)
                    : const Icon(Icons.search))
          ],
        ),
        body: _entities != null
            ? ListView(
                children: _entities!
                    .where((element) => _filterFn(element))
                    .map((entity) => ListTile(
                          title: Text(entity['attributes']['friendly_name'] ??
                              entity['entity_id']),
                          subtitle: Text(entity['entity_id']),
                        ))
                    .toList())
            : const Center(child: CircularProgressIndicator(value: null)));
  }
}
