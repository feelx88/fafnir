import 'package:fafnir/data/home_assistant/domain.dart';
import 'package:fafnir/data/home_assistant/entity.dart';
import 'package:flutter/material.dart';

class EditEntityView extends StatefulWidget {
  final String title;

  const EditEntityView({Key? key, required this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditEntityState();
}

class _EditEntityState extends State<EditEntityView> {
  Entity? _entity;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    setState(() {
      _entity = ModalRoute.of(context)!.settings.arguments as Entity;
    });
  }

  void _save() {
    Navigator.pop(context, _entity);
  }

  @override
  Widget build(BuildContext context) {
    print(_entity!.serviceDomain);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [IconButton(onPressed: _save, icon: const Icon(Icons.save))],
        ),
        body: ListView(
          padding: kTabLabelPadding,
          children: [
            TextFormField(
                initialValue: _entity!.friendlyName,
                onChanged: (value) => _entity!.friendlyName = value,
                decoration:
                    const InputDecoration(label: Text('Friendly name'))),
            TextFormField(
                initialValue: _entity!.entityId,
                decoration: const InputDecoration(label: Text('Entity id')),
                readOnly: true),
            DropdownButtonFormField(
                onChanged: (value) => setState(() {
                      _entity!.serviceDomain = value as String;
                    }),
                value: _entity!.serviceDomain,
                items: Domain.configurations
                    .map((key, value) => MapEntry(
                        key,
                        DropdownMenuItem(
                            child: Text(value.name), value: value.id)))
                    .values
                    .toList(),
                hint: const Text('Service type')),
            ...(Domain.configurations[_entity!.serviceDomain]!.features.map(
                (feature) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(feature.name),
                          Checkbox(
                              onChanged: (bool? value) {
                                setState(() {
                                  if (value!) {
                                    _entity!.features.add(DomainFeature(
                                        id: feature.id, name: feature.name));
                                  } else {
                                    _entity!.features.removeWhere(
                                        (element) => element.id == feature.id);
                                  }
                                });
                              },
                              value: _entity!.features
                                  .any((element) => element.id == feature.id))
                        ]))).toList()
          ],
        ));
  }
}
