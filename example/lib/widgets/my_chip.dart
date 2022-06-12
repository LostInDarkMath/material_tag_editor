import 'package:flutter/material.dart';

/// A thin wrapper of the [Chip] widget which provides a context menu with multiple options.
class TagChip extends StatelessWidget {
  final Widget label;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final Color? selectedColor;
  final String tooltip;

  const TagChip({
    required this.label,
    required this.onTap,
    this.backgroundColor,
    this.selectedColor,
    this.tooltip = 'Edit',
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: RawChip(
        label: label,
        deleteIcon: const Icon(Icons.edit),
        onDeleted: onTap,
        backgroundColor: backgroundColor ?? Theme.of(context).chipTheme.backgroundColor,
        selectedColor: selectedColor ?? Theme.of(context).chipTheme.selectedColor,
        selected: false,
        tooltip: tooltip,
      ),
    );
  }
}

