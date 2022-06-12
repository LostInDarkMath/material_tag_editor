import 'package:flutter/material.dart';
import 'package:material_tag_editor/tag_editor.dart';

import '../tag_model.dart';
import 'edit_screen.dart';
import 'my_chip.dart';

/// A text field for CRUD operations on a list of tags.
class TagSelector extends StatefulWidget {
  const TagSelector({
    Key? key,
  }) : super(key: key);

  @override
  State<TagSelector> createState() => _TagSelectorState();
}

class _TagSelectorState extends State<TagSelector> {
  final _textController = TextEditingController();
  final List<Tag> tags = [];

  @override
  void dispose(){
    _textController.dispose();
    super.dispose();
  }

  void onTagAdded(String value){
    print('added $value');
    setState(() {
      tags.add(Tag(name: value.trim(), weight: 1.0, description: 'description'));
    });
  }

  void onBackspace(){
    print('onBackspace');

    if(tags.isEmpty){
      return;
    }

    setState(() {
      final removedTag = tags.removeLast();
      _textController.text = removedTag.name;
      _textController.selection = TextSelection.fromPosition(TextPosition(offset: _textController.text.length));
    });
  }

  Future<void> onTagTap(Tag tag) async {
    print('BEGIN EDIT: $tag');
    await Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => EditScreen(
          tag: tag,
        ),
      ),
    );
    print('END EDIT');
  }

  @override
  Widget build(BuildContext context) {
    return TagEditor(
      length: tags.length,
      delimiters: const [',', ';'],
      tagSpacing: 4.0,
      hasAddButton: true,
      onTagChanged: onTagAdded,
      onSubmitted: onTagAdded,
      onBackspace: onBackspace,
      resetTextOnSubmitted: true,
      controller: _textController,
      tagBuilder: (context, index) => TagChip(
        label: Text(tags[index].name),
        onTap: () => onTagTap(tags[index]),
      ),
    );
  }
}
