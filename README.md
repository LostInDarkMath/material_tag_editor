# Material Tag Editor
A simple tag editor.

![image](https://user-images.githubusercontent.com/18391546/82047483-dc8f0f00-96ed-11ea-8a91-7eaa64e2358b.gif)

## Usage

To use this package, add `material_tag_editor` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).
```yaml
dependencies:
  material_tag_editor:
    git:
      url: https://github.com/LostInDarkMath/dash_chat.git
```

Import it

```dart
import 'package:material_tag_editor/tag_editor.dart';
```

Use the widget

```dart
TagEditor(
  length: values.length,
  delimiters: [',', ' '],
  hasAddButton: true,
  inputDecoration: const InputDecoration(
    border: InputBorder.none,
    hintText: 'Hint Text...',
  ),
  onTagChanged: (newValue) {
    setState(() {
      values.add(newValue);
    });
  },
  tagBuilder: (context, index) => _Chip(
    index: index,
    label: values[index],
    onDeleted: onDelete,
  ),
)
```

It is possible to build the tag from your own widget, but it is recommended that Material Chip is used

```dart
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
      deleteIcon: Icon(
        Icons.close,
        size: 18,
      ),
      onDeleted: () {
        onDeleted(index);
      },
    );
  }
}
```

## Issues and feedback 💭

If you have any suggestion for including a feature or if something doesn't work, feel free to open a Github [issue](https://github.com/LostInDarkMath/material_tag_editor/issues) for us to have a discussion on it.
