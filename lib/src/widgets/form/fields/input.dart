import 'dart:ui' as ui;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:twix_ui/src/theme/widget_theme/decorator.dart';
import 'package:twix_ui/src/widgets/form/field.dart';
import 'package:twix_ui/src/widgets/input.dart';

class TwixInputFormField extends TwixFormFieldBuilder<String> {
  TwixInputFormField({
    super.id,
    super.key,
    super.onSaved,
    String? Function(String)? validator,
    String? initialValue,
    super.enabled,
    super.autovalidateMode,
    super.restorationId,
    this.controller,
    super.label,
    super.error,
    super.description,
    void Function(String)? onChanged,
    super.valueTransformer,
    super.onReset,
    TwixDecoration? decoration,
    Widget? placeholder,
    TextMagnifierConfiguration magnifierConfiguration = TextMagnifierConfiguration.disabled,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlign textAlign = TextAlign.start,
    TextDirection? textDirection,
    bool autofocus = false,
    String obscuringCharacter = '•',
    bool obscureText = false,
    bool autocorrect = true,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    bool enableSuggestions = true,
    int? maxLines = 1,
    int? minLines,
    bool expands = false,
    bool readOnly = false,
    bool? showCursor = false,
    int? maxLength,
    MaxLengthEnforcement? maxLengthEnforcement,
    VoidCallback? onEditingComplete,
    ValueChanged<String>? onSubmitted,
    AppPrivateCommandCallback? onAppPrivateCommand,
    List<TextInputFormatter>? inputFormatters,
    double cursorWidth = 2.0,
    double? cursorHeight,
    Radius? cursorRadius,
    bool? cursorOpacityAnimates,
    Color? cursorColor,
    ui.BoxHeightStyle selectionHeightStyle = ui.BoxHeightStyle.tight,
    ui.BoxWidthStyle selectionWidthStyle = ui.BoxWidthStyle.tight,
    Brightness? keyboardAppearance,
    EdgeInsets scrollPadding = const EdgeInsets.all(20),
    bool? enableInteractiveSelection,
    TextSelectionControls? selectionControls,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    GestureTapCallback? onTap,
    bool onTapAlwaysCalled = false,
    TapRegionCallback? onTapOutside,
    MouseCursor? mouseCursor,
    ScrollPhysics? scrollPhysics,
    ScrollController? scrollController,
    Iterable<String>? autofillHints,
    Clip clipBehavior = Clip.hardEdge,
    bool scribbleEnabled = true,
    bool enableIMEPersonalizedLearning = true,
    ContentInsertionConfiguration? contentInsertionConfiguration,
    EditableTextContextMenuBuilder? contextMenuBuilder,
    UndoHistoryController? undoController,
    SpellCheckConfiguration? spellCheckConfiguration,
    Color? selectionColor,
    EdgeInsets? padding,
    Widget? prefix,
    Widget? suffix,
    MainAxisAlignment? mainAxisAlignment,
    CrossAxisAlignment? crossAxisAlignment,
    TextStyle? placeholderStyle,
    Alignment? placeholderAlignment,
    EdgeInsets? inputPadding,
  }) : super(
          initialValue: controller != null ? controller.text : initialValue,
          validator: validator == null ? null : (v) => validator(v ?? ''),
          onChanged: onChanged == null ? null : (v) => onChanged(v ?? ''),
          builder: (field) {
            final state = field as _TwixFormBuilderInputState;
            return TwixInput(
              key: state.inputKey,
              controller: state._effectiveController,
              restorationId: restorationId,
              enabled: state.enabled,
              focusNode: state.focusNode,
              decoration: decoration,
              style: style,
              cursorColor: cursorColor,
              selectionColor: selectionColor,
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              textCapitalization: textCapitalization,
              autofocus: autofocus,
              obscureText: obscureText,
              autocorrect: autocorrect,
              magnifierConfiguration: magnifierConfiguration,
              smartDashesType: smartDashesType,
              smartQuotesType: smartQuotesType,
              enableSuggestions: enableSuggestions,
              maxLines: maxLines,
              minLines: minLines,
              expands: expands,
              onChanged: onChanged,
              onEditingComplete: onEditingComplete,
              onSubmitted: onSubmitted,
              onAppPrivateCommand: onAppPrivateCommand,
              inputFormatters: inputFormatters,
              cursorWidth: cursorWidth,
              cursorHeight: cursorHeight,
              cursorRadius: cursorRadius,
              selectionHeightStyle: selectionHeightStyle,
              selectionWidthStyle: selectionWidthStyle,
              scrollPadding: scrollPadding,
              dragStartBehavior: dragStartBehavior,
              scrollController: scrollController,
              scrollPhysics: scrollPhysics,
              autofillHints: autofillHints,
              clipBehavior: clipBehavior,
              scribbleEnabled: scribbleEnabled,
              enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
              contentInsertionConfiguration: contentInsertionConfiguration,
              contextMenuBuilder: contextMenuBuilder,
              selectionControls: selectionControls,
              mouseCursor: mouseCursor,
              enableInteractiveSelection: enableInteractiveSelection,
              undoController: undoController,
              spellCheckConfiguration: spellCheckConfiguration,
              placeholder: placeholder,
              onTap: onTap,
              onTapAlwaysCalled: onTapAlwaysCalled,
              onTapOutside: onTapOutside,
              keyboardAppearance: keyboardAppearance,
              cursorOpacityAnimates: cursorOpacityAnimates,
              readOnly: readOnly,
              strutStyle: strutStyle,
              textAlign: textAlign,
              textDirection: textDirection,
              obscuringCharacter: obscuringCharacter,
              showCursor: showCursor,
              maxLength: maxLength,
              maxLengthEnforcement: maxLengthEnforcement,
              padding: padding,
              prefix: prefix,
              suffix: suffix,
              mainAxisAlignment: mainAxisAlignment,
              crossAxisAlignment: crossAxisAlignment,
              placeholderStyle: placeholderStyle,
              placeholderAlignment: placeholderAlignment,
              inputPadding: inputPadding,
            );
          },
        );

  final TextEditingController? controller;

  @override
  TwixFormFieldBuilderState<TwixInputFormField, String> createState() => _TwixFormBuilderInputState();
}

class _TwixFormBuilderInputState extends TwixFormFieldBuilderState<TwixInputFormField, String> {
  final GlobalKey<TwixInputState> inputKey = GlobalKey<TwixInputState>();

  TextEditingController? _controller;
  TextEditingController get _effectiveController => widget.controller ?? _controller!;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = TextEditingController(text: value);
    }
    _effectiveController.addListener(_onControllerChanged);
  }

  @override
  void didChange(String? value) {
    super.didChange(value);
    if (_effectiveController.text != value) {
      _effectiveController.text = value ?? '';
    }
  }

  @override
  void didUpdateWidget(covariant TwixInputFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller == null && widget.controller != null) {
      _controller?.dispose();
    }
    if (oldWidget.controller != null && widget.controller == null) {
      _controller = TextEditingController(text: value);
    }
  }

  @override
  void reset() {
    super.reset();
    widget.onChanged?.call(_effectiveController.text);
  }

  @override
  void dispose() {
    _effectiveController.removeListener(_onControllerChanged);
    _controller?.dispose();
    super.dispose();
  }

  void _onControllerChanged() {
    if (_effectiveController.text != value) {
      didChange(_effectiveController.text);
    }
  }
}
