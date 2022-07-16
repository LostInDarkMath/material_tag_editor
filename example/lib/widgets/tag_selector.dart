import 'package:example/widgets/theme.dart';
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
      _textController.text = TagEditor.INVISIBLE + removedTag.name;
      _textController.selection = TextSelection.fromPosition(TextPosition(offset: _textController.text.length));
    });
  }

  Future<void> onTagTap(int index) async {
    final Tag tagAtIndex = tags[index];
    print('BEGIN EDIT: $tagAtIndex');
    await Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => EditScreen(
          tag: tagAtIndex,
          onSubmit: (newTag){
            print('new tag: $newTag');
            tags.remove(tagAtIndex);
            tags.insert(index, newTag);
          },
        ),
      ),
    );
    print('END EDIT: $tags');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TagEditor(
        length: tags.length,
        delimiters: const [',', ';'],
        tagSpacing: 4.0,
        hasAddButton: true,
        onTagChanged: onTagAdded,
        onSubmitted: onTagAdded,
        onBackspace: onBackspace,
        resetTextOnSubmitted: true,
        controller: _textController,
        inputDecorationOfContainer: corpInputDecoration.copyWith(
          labelText: 'Material Tag Editor advanced',
        ),
        inputDecorationOfTextFieldWrapper: const InputDecoration(
          hintText: ' enter a tag',
          border: InputBorder.none,
        ),
        tagBuilder: (context, index) => TagChip(
          label: Text(tags[index].name),
          onTap: () => onTagTap(index),
        ),
      ),
    );
  }
}
