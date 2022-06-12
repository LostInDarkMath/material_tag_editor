import 'package:flutter/material.dart';

import '../tag_model.dart';

class EditScreen extends StatefulWidget {
  final Tag tag;

  const EditScreen({
    required this.tag,
    Key? key,
  }) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit tag')),
      body: SingleChildScrollView(
        child: Column(
          children: const <Widget>[
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
      ),
    );
  }
}
