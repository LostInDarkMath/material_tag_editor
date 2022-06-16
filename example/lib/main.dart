import 'package:example/widgets/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:material_tag_editor/tag_editor.dart';

import 'widgets/tag_selector.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material Tag Editor Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _values = <String>[];
  final _focusNode = FocusNode();
  final _textEditingController = TextEditingController();

  void _onDelete(int index) {
    setState(() {
      _values.removeAt(index);
    });
  }

  /// This is just an example for using `TextEditingController` to manipulate
  /// the the `TextField` just like a normal `TextField`.
  void _onPressedModifyTextField() {
    const text = 'Test';
    _textEditingController.text = text;
    _textEditingController.value = _textEditingController.value.copyWith(
      text: text,
      selection: const TextSelection(
        baseOffset: text.length,
        extentOffset: text.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material Tag Editor Demo'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (context) => const TagSelectorDemo(),
            ),
          );
        },
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              TagEditor(
                length: _values.length,
                controller: _textEditingController,
                focusNode: _focusNode,
                delimiters: const [',', ' '],
                hasAddButton: true,
                resetTextOnSubmitted: true,
                // This is set to grey just to illustrate the `textStyle` prop
                textStyle: const TextStyle(color: Colors.grey),
                onSubmitted: (outstandingValue) {
                  setState(() {
                    _values.add(outstandingValue);
                  });
                },
                inputDecorationOfContainer: corpInputDecoration.copyWith(
                  hintText: 'inputHintText',
                  labelText: 'inputLabelText',
                ),
                inputDecorationOfTextField: const InputDecoration(
                  hintText: 'Enter a tag here',
                ),
                onTagChanged: (newValue) {
                  setState(() {
                    _values.add(newValue);
                  });
                },
                tagBuilder: (context, index) => _Chip(
                  index: index,
                  label: _values[index],
                  onDeleted: _onDelete,
                ),
                // InputFormatters example, this disallow \ and /
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'[/\\]'))
                ],
              ),
              const Divider(),
              // This is just a button to illustrate how to use
              // TextEditingController to set the value
              // or do whatever you want with it
              ElevatedButton(
                onPressed: _onPressedModifyTextField,
                child: const Text('Use Controller to Set Value'),
              ),
              TextFormField(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.onDeleted,
    required this.index,
  });

  final String label;
  final ValueChanged<int> onDeleted;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Chip(
      labelPadding: const EdgeInsets.only(left: 8.0),
      label: Text(label),
      deleteIcon: const Icon(
        Icons.close,
        size: 18,
      ),
      onDeleted: () {
        onDeleted(index);
      },
    );
  }
}

class TagSelectorDemo extends StatefulWidget {
  const TagSelectorDemo({Key? key}) : super(key: key);

  @override
  State<TagSelectorDemo> createState() => _TagSelectorDemoState();
}

class _TagSelectorDemoState extends State<TagSelectorDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tag Selector Demo'),),
      body: Column(
        children: const [
          TagSelector(),
        ],
      ),
    );
  }
}
