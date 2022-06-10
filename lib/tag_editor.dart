import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './tag_editor_layout_delegate.dart';
import './tag_layout.dart';

const INVISIBLE = ' ';

/// A [Widget] for editing tag similar to Google's Gmail
/// email address input widget in the iOS app.
class TagEditor extends StatefulWidget {
  const TagEditor({
    required this.length,
    this.minTextFieldWidth = 160.0,
    this.tagSpacing = 4.0,
    required this.tagBuilder,
    required this.onTagChanged,
    Key? key,
    this.focusNode,
    this.hasAddButton = true,
    this.delimiters = const [],
    this.icon = const Icon(Icons.add),
    this.enabled = true,
    this.onBackspace,
    // TextField's properties
    this.controller,
    this.textStyle,
    this.inputDecoration = const InputDecoration(),
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.readOnly = false,
    this.autofocus = false,
    this.autocorrect = false,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.resetTextOnSubmitted = false,
    this.onSubmitted,
    this.inputFormatters,
    this.keyboardAppearance,
  }) : super(key: key);

  /// The number of tags currently shown.
  final int length;

  /// The minimum width that the `TextField` should take
  final double minTextFieldWidth;

  /// The spacing between each tag
  final double tagSpacing;

  /// Builder for building the tags, this usually use Flutter's Material `Chip`.
  final Widget Function(BuildContext, int) tagBuilder;

  /// Show the add button to the right.
  final bool hasAddButton;

  /// The icon for the add button enabled with `hasAddButton`.
  final Widget icon;

  /// Callback for when the tag changed. Use this to get the new tag and add
  /// it to the state.
  final ValueChanged<String> onTagChanged;

  /// Callback for when backspace is pressed. Use this to remove the last tag from the list.
  final VoidCallback? onBackspace;

  /// When the string value in this `delimiters` is found, a new tag will be
  /// created and `onTagChanged` is called.
  final List<String> delimiters;

  /// Reset the TextField when `onSubmitted` is called
  /// this is default to `false` because when the form is submitted
  /// usually the outstanding value is just used, but this option is here
  /// in case you want to reset it for any reasons (like converting the
  /// outstanding value to tag).
  final bool resetTextOnSubmitted;

  /// Called when the user are done editing the text in the [TextField]
  /// Use this to get the outstanding text that aren't converted to tag yet
  /// If no text is entered when this is called an empty string will be passed.
  final ValueChanged<String>? onSubmitted;

  /// Focus node for checking if the [TextField] is focused.
  final FocusNode? focusNode;

  /// [TextField]'s properties.
  ///
  /// Please refer to [TextField] documentation.
  final TextEditingController? controller;
  final bool enabled;
  final TextStyle? textStyle;
  final InputDecoration inputDecoration;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final bool autofocus;
  final bool autocorrect;
  final bool enableSuggestions;
  final int maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;
  final Brightness? keyboardAppearance;

  @override
  State<TagEditor> createState() => _TagsEditorState();
}

class _TagsEditorState extends State<TagEditor> {
  /// A controller to keep value of the [TextField].
  late TextEditingController _textFieldController;

  /// A state variable for checking if new text is enter.
  var _previousText = '';

  /// A state for checking if the [TextFiled] has focus.
  var _isFocused = false; // TODO used?

  /// Focus node for checking if the [TextField] is focused.
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _textFieldController = (widget.controller ?? TextEditingController());
    _focusNode = (widget.focusNode ?? FocusNode())..addListener(_onFocusChanged);
    _resetTextField();
  }

  void _onFocusChanged() {
    print('on focus changed');
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void _onTagChanged(String string) {
    if (string.isNotEmpty) {
      widget.onTagChanged(string);
      _resetTextField();
    }
  }

  // TODO check if pasting tags split them correctly
  void _onTextFieldChange(String string) {
    final previousText = _previousText;
    _previousText = string;
    print('ENTERED: $string');

    // Do not allow the entry of the delimiters, this does not account for when
    // the text is set with `TextEditingController` the behaviour of TextEditingController
    // should be controller by the developer themselves
    if (string.length <= 2 && widget.delimiters.contains(string)) {
      _resetTextField();
      return;
    }

    if(string.isEmpty) {
      _resetTextField(); // add invisible character
      widget.onBackspace?.call();
    }

    if (string.length > previousText.length) {
      // Add case
      final newChar = string[string.length - 1];

      if (widget.delimiters.contains(newChar)) {

        final targetString = string.substring(0, string.length - 1);
        if (targetString.isNotEmpty) {
          _onTagChanged(targetString);
        }
      }
    }
  }

  void _onSubmitted(String string) {
    widget.onSubmitted?.call(string);
    if (widget.resetTextOnSubmitted) {
      _resetTextField();
    }
  }

  void _resetTextField() {
    _previousText = INVISIBLE;
    _textFieldController.value = TextEditingValue(
      text: INVISIBLE,
      selection: TextSelection.fromPosition(const TextPosition(offset: INVISIBLE.length)),
    );
  }

  @override
  Widget build(BuildContext context) {
    InputDecoration decoration;

    if (widget.hasAddButton){
      decoration = widget.inputDecoration.copyWith(
          suffixIcon: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              _onTagChanged(_textFieldController.text);
            },
            icon: widget.icon,
          ));
    } else {
      decoration = widget.inputDecoration;
    }

    Widget textField = TextField(
      style: widget.textStyle,
      focusNode: _focusNode,
      enabled: widget.enabled,
      controller: _textFieldController,
      keyboardType: widget.keyboardType,
      keyboardAppearance: widget.keyboardAppearance,
      textCapitalization: widget.textCapitalization,
      textInputAction: widget.textInputAction,
      autocorrect: widget.autocorrect,
      textAlign: widget.textAlign,
      textDirection: widget.textDirection,
      readOnly: widget.readOnly,
      autofocus: widget.autofocus,
      enableSuggestions: widget.enableSuggestions,
      maxLines: widget.maxLines,
      decoration: decoration,
      inputFormatters: widget.inputFormatters,
      onChanged: _onTextFieldChange,
      onSubmitted: _onSubmitted,
    );

    return TagLayout(
      delegate: TagEditorLayoutDelegate(
        length: widget.length,
        minTextFieldWidth: widget.minTextFieldWidth,
        spacing: widget.tagSpacing,
      ),
      children: List<Widget>.generate(
        widget.length,
        (index) => LayoutId(
          id: TagEditorLayoutDelegate.getTagId(index),
          child: widget.tagBuilder(context, index),
        ),
      ) + <Widget>[
        LayoutId(
          id: TagEditorLayoutDelegate.textFieldId,
          child: textField,
        )
      ],
    );
  }
}
