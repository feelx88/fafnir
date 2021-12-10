import 'dart:convert';

import 'package:fafnir/data/home_assistant_connection.dart';
import 'package:fafnir/data/home_assistant_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
                entry['attributes']?['friendly_name'] ??
                    entry['entity_id'] ??
                    '',
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

  void _addEntity(HomeAssistantEntity entity) {
    Navigator.pop(
        context, HomeAssistantEntity(entity.friendlyName, entity.entityId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: _searching
              ? IconButton(
                  onPressed: _toggleFilter, icon: const Icon(Icons.arrow_back))
              : null,
          title: AnimatedSwitcher(
            layoutBuilder: (currentChild, previousChildren) => Stack(
              children: [currentChild!, ...previousChildren],
              alignment: Alignment.centerLeft,
            ),
            duration: kThemeAnimationDuration,
            child: _searching
                ? TextField(
                    autofocus: true,
                    maxLines: 1,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                        hintText: 'Filter',
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                            onPressed: () => setState(() {
                                  _filter = '';
                                }),
                            icon: const Icon(Icons.clear))),
                    controller:
                        _filter == '' ? TextEditingController(text: '') : null,
                    onChanged: (value) => setState(() {
                      _filter = value;
                    }),
                  )
                : Text(widget.title),
          ),
          actions: _searching
              ? []
              : [
                  IconButton(
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
                          onTap: () => _addEntity(entity),
                        ))
                    .toList())
            : const Center(child: CircularProgressIndicator(value: null)));
  }
}
