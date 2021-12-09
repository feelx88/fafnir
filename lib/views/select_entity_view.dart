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

class HomeAssistantEntity {
  final String friendlyName;
  final String entityId;

  HomeAssistantEntity(this.friendlyName, this.entityId);
}

class _SelectEntityViewState extends State<SelectEntityView> {
  List<HomeAssistantEntity>? _entities;
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
        _entities = (jsonDecode(data.body) as List<dynamic>)
            .map((entry) => HomeAssistantEntity(
                entry['friendly_name'] ?? entry['entity_id'] ?? '',
                entry['entity_id'] ?? ''))
            .toList();
      });
    });
  }

  bool _filterFn(HomeAssistantEntity entity) {
    return _filter == '' ||
        (entity.entityId).contains(RegExp(_filter, caseSensitive: false)) ||
        (entity.friendlyName).contains(RegExp(_filter, caseSensitive: false));
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
          leading: _searching
              ? IconButton(
                  onPressed: _toggleFilter, icon: Icon(Icons.arrow_back))
              : null,
          title: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: _searching
                ? TextField(
                    autofocus: true,
                    decoration: const InputDecoration(label: Text('Filter')),
                    controller:
                        _filter == '' ? TextEditingController(text: '') : null,
                    onChanged: (value) => setState(() {
                      _filter = value;
                    }),
                  )
                : Text(widget.title),
          ),
          actions: [
            _searching
                ? IconButton(
                    onPressed: () => setState(() {
                          _filter = '';
                        }),
                    icon: const Icon(Icons.clear))
                : IconButton(
                    onPressed: _toggleFilter, icon: const Icon(Icons.search))
          ],
        ),
        body: _entities != null
            ? ListView(
                children: _entities!
                    .where((element) => _filterFn(element))
                    .map((HomeAssistantEntity entity) => ListTile(
                          title: Text(entity.friendlyName),
                          subtitle: Text(entity.entityId),
                        ))
                    .toList())
            : const Center(child: CircularProgressIndicator(value: null)));
  }
}
