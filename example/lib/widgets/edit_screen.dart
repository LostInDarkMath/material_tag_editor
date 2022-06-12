import 'package:flutter/material.dart';

import '../tag_model.dart';

class EditScreen extends StatefulWidget {
  final Tag tag;
  final void Function(Tag) onSubmit;

  const EditScreen({
    required this.tag,
    required this.onSubmit,
    Key? key,
  }) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  String name = '';
  String description = '';
  double weight = 1.0;

  @override
  void initState(){
    super.initState();
    name = widget.tag.name;
    description = widget.tag.description;
    weight = widget.tag.weight;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print('onWillPop');
        widget.onSubmit(Tag(name: name, description: description, weight: weight));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Edit tag')),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const Text('Hier kannst den Tag bearbeiten'),
              TextFormField(
                initialValue: name,
                onChanged: (v) => name = v,
              ),
              const Text('Sichtbarkeit'),
              const Text('Hier kannst du eine Story einfügen'),
              TextFormField(
                initialValue: description,
                onChanged: (v) => description = v,
                maxLines: 5, // multiline
              ),
              Text('Gewichtung'),
              Slider(
                value: weight,
                min: 0.5,
                max: 2,
                onChanged: (v) => setState(() => weight = v),
              ),
              RawChip(
                deleteIcon: const Icon(Icons.edit),
                tooltip: 'Edit',
                deleteButtonTooltipMessage: 'Edit',
                onDeleted: () => print('Foo'),
                label: const Text('Foo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
