import 'package:flutter/material.dart';

/// A thin wrapper of the [Chip] widget which provides a context menu with multiple options.
/// This chip can be selected with an long-press.
class SelectableTagChip extends StatefulWidget {
  final Widget label;
  final VoidCallback onEdit;
  final Color? backgroundColor;
  final Color? selectedColor;
  final String tooltip;

  const SelectableTagChip({
    required this.label,
    required this.onEdit,
    this.backgroundColor,
    this.selectedColor,
    this.tooltip = 'Edit',
    Key? key,
  }) : super(key: key);

  @override
  State<SelectableTagChip> createState() => _SelectableTagChipState();
}

class _SelectableTagChipState extends State<SelectableTagChip> {
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
        tooltip: widget.tooltip,
      ),
    );
  }
}
