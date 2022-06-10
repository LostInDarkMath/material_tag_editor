import 'package:flutter/material.dart';

/// A thin wrapper of the [Chip] widget which provides a context menu with multiple options.
class TagChip extends StatefulWidget {
  const TagChip({
    required this.label,
    required this.onDelete,
    required this.onEdit,
    this.backgroundColor,
    this.selectedColor,
    Key? key,
  }) : super(key: key);
  
  final Widget label;
  final Function() onDelete;
  final Function() onEdit;
  final Color? backgroundColor;
  final Color? selectedColor;

  @override
  State<TagChip> createState() => _TagChipState();
}

class _TagChipState extends State<TagChip> {
  bool isSelected = false;

  void onLongPress(){
    setState(() {
      isSelected = !isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onEdit,
      onLongPress: onLongPress,
      child: RawChip(
        label: widget.label,
        deleteIcon: const Icon(Icons.edit),
        onDeleted: widget.onEdit,
        backgroundColor: widget.backgroundColor ?? Theme.of(context).chipTheme.backgroundColor,
        selectedColor: widget.selectedColor ?? Theme.of(context).chipTheme.selectedColor,
        selected: isSelected,
      ),
    );
  }
}
