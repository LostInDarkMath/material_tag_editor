import 'package:flutter/material.dart';

class EditTag extends StatefulWidget {
  const EditTag({
    required this.name,
    Key? key,
  }) : super(key: key);

  final String name;

  @override
  State<EditTag> createState() => _EditTagState();
}

class _EditTagState extends State<EditTag> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const <Widget>[ // TODO am besten ExpansionPanelList
          Text('Hier kannst den Tag bearbeiten'),
          TextField(

          ),
          Text('Sichtbarkeit'),
          Text('Hier kannst du eine Story einfügen'),
          TextField(
            maxLines: 5, // multiline
          ),
          Text('Gewichtung'),
        ],
      ),
    );
  }
}
