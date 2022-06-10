import 'package:flutter/material.dart';

import 'tag_editor.dart';
import 'my_chip.dart';

/// A text field for CRUD operations on tags.
class TagSelector extends StatefulWidget {
  const TagSelector({
    Key? key,
  }) : super(key: key);

  @override
  State<TagSelector> createState() => _TagSelectorState();
}

class _TagSelectorState extends State<TagSelector> {
  final List<String> tags = [];

  void onTagAdded(String value){
    print('added $value');
    setState(() {
      tags.add(value);
    });
  }

  void onBackspace(){
    print('onBackspace');

    if(tags.isEmpty){
      return;
    }

    setState(() {
      tags.removeLast();
    });
  }

  void onDelete(){
    print('DELETE');
  }

  void onEdit(){
    print('EDIT');
  }

  @override
  Widget build(BuildContext context) {
    return TagEditor(
      length: tags.length,
      delimiters: const [',', ';'],
      tagSpacing: 4.0,
       // icon property is not for the add button. do not use it
      hasAddButton: true,
      onTagChanged: onTagAdded,
      onSubmitted: onTagAdded,
      onBackspace: onBackspace,
      resetTextOnSubmitted: true,
      tagBuilder: (context, index) => TagChip(
        label: Text(tags[index]),
        onDelete: onDelete,
        onEdit: onEdit,
      ),
    );
  }
}
