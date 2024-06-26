import 'dart:ui' as ui;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:twix_ui/src/theme/theme.dart';
import 'package:twix_ui/src/theme/widget_theme/decorator.dart';
import 'package:twix_ui/src/widgets/disabled.dart';

class TwixInput extends StatefulWidget {
  const TwixInput({
    super.key,
    this.initialValue,
    this.placeholder,
    this.controller,
    this.focusNode,
    this.decoration,
    this.undoController,
    TextInputType? keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.readOnly = false,
    this.showCursor,
    this.autofocus = false,
    this.obscuringCharacter = '•',
    this.obscureText = false,
    this.autocorrect = true,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.maxLengthEnforcement,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.onAppPrivateCommand,
    this.inputFormatters,
    this.enabled = true,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorOpacityAnimates,
    this.cursorColor,
    this.selectionHeightStyle = ui.BoxHeightStyle.tight,
    this.selectionWidthStyle = ui.BoxWidthStyle.tight,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20),
    this.dragStartBehavior = DragStartBehavior.start,
    bool? enableInteractiveSelection,
    this.selectionControls,
    this.onTap,
    this.onTapAlwaysCalled = false,
    this.onTapOutside,
    this.mouseCursor,
    this.scrollController,
    this.scrollPhysics,
    this.autofillHints = const <String>[],
    this.contentInsertionConfiguration,
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.scribbleEnabled = true,
    this.enableIMEPersonalizedLearning = true,
    this.contextMenuBuilder,
    this.spellCheckConfiguration,
    this.magnifierConfiguration = TextMagnifierConfiguration.disabled,
    this.selectionColor,
    this.padding,
    this.prefix,
    this.suffix,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.placeholderStyle,
    this.placeholderAlignment,
    this.inputPadding,
  })  : smartDashesType = smartDashesType ?? (obscureText ? SmartDashesType.disabled : SmartDashesType.enabled),
        smartQuotesType = smartQuotesType ?? (obscureText ? SmartQuotesType.disabled : SmartQuotesType.enabled),
        keyboardType = keyboardType ?? (maxLines == 1 ? TextInputType.text : TextInputType.multiline),
        enableInteractiveSelection = enableInteractiveSelection ?? (!readOnly || !obscureText),
        assert(
          initialValue == null || controller == null,
          'Either initialValue or controller must be specified',
        );

  final TwixDecoration? decoration;
  final String? initialValue;
  final Widget? placeholder;
  final TextMagnifierConfiguration magnifierConfiguration;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final bool autofocus;
  final String obscuringCharacter;
  final bool obscureText;
  final bool autocorrect;
  final SmartDashesType smartDashesType;
  final SmartQuotesType smartQuotesType;
  final bool enableSuggestions;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  final bool readOnly;
  final bool? showCursor;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final AppPrivateCommandCallback? onAppPrivateCommand;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  final double cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final bool? cursorOpacityAnimates;
  final Color? cursorColor;
  final ui.BoxHeightStyle selectionHeightStyle;
  final ui.BoxWidthStyle selectionWidthStyle;
  final Brightness? keyboardAppearance;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
  final TextSelectionControls? selectionControls;
  final DragStartBehavior dragStartBehavior;
  final GestureTapCallback? onTap;
  final TapRegionCallback? onTapOutside;
  final MouseCursor? mouseCursor;
  final ScrollPhysics? scrollPhysics;
  final ScrollController? scrollController;
  final Iterable<String>? autofillHints;
  final Clip clipBehavior;
  final String? restorationId;
  final bool scribbleEnabled;
  final bool enableIMEPersonalizedLearning;
  final ContentInsertionConfiguration? contentInsertionConfiguration;
  final EditableTextContextMenuBuilder? contextMenuBuilder;
  final UndoHistoryController? undoController;
  final SpellCheckConfiguration? spellCheckConfiguration;
  final Color? selectionColor;
  final EdgeInsets? padding;
  final Widget? prefix;
  final Widget? suffix;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final TextStyle? placeholderStyle;
  final Alignment? placeholderAlignment;
  final EdgeInsets? inputPadding;
  final bool onTapAlwaysCalled;

  static const int noMaxLength = -1;

  bool get selectionEnabled => enableInteractiveSelection;

  @override
  State<TwixInput> createState() => TwixInputState();
}

class TwixInputState extends State<TwixInput>
    with RestorationMixin
    implements TextSelectionGestureDetectorBuilderDelegate {
  late final _InputSelectionGestureDetectorBuilder _selectionGestureDetectorBuilder;
  final ValueNotifier _isFocused = ValueNotifier(false);

  @override
  final GlobalKey<EditableTextState> editableTextKey = GlobalKey<EditableTextState>();

  FocusNode? _focusNode;
  FocusNode get _effectiveFocusNode => widget.focusNode ?? (_focusNode ??= FocusNode());

  RestorableTextEditingController? _restorableController;
  TextEditingController get _effectiveController => widget.controller ?? _restorableController!.value;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _createRestorableController(TextEditingValue(text: widget.initialValue ?? ''));
    }
    _effectiveFocusNode.addListener(_onFocusChanged);
    _selectionGestureDetectorBuilder = _InputSelectionGestureDetectorBuilder(state: this);
  }

  @override
  void didUpdateWidget(TwixInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller == null && oldWidget.controller != null) {
      _createRestorableController(oldWidget.controller!.value);
    } else if (widget.controller != null && oldWidget.controller == null) {
      _unregisterRestorableController();
      _restorableController?.dispose();
      _restorableController = null;
    }

    if (widget.focusNode != oldWidget.focusNode) {
      (oldWidget.focusNode ?? _focusNode)?.removeListener(_onFocusChanged);
      _effectiveFocusNode.addListener(_onFocusChanged);
    }
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    if (_restorableController != null) _registerRestorableController();
  }

  @override
  bool get forcePressEnabled {
    return Theme.of(context).platform == TargetPlatform.iOS;
  }

  @override
  bool get selectionEnabled => widget.enableInteractiveSelection;

  @override
  String? get restorationId => widget.restorationId;

  @override
  void dispose() {
    _restorableController?.dispose();
    _effectiveFocusNode.removeListener(_onFocusChanged);
    _focusNode?.dispose();
    super.dispose();
  }

  void _registerRestorableController() {
    assert(_restorableController != null);
    registerForRestoration(_restorableController!, 'restorableController');
  }

  void _unregisterRestorableController() {
    assert(_restorableController != null);
    unregisterFromRestoration(_restorableController!);
  }

  void _createRestorableController([TextEditingValue? value]) {
    assert(_restorableController == null);
    _restorableController =
        value == null ? RestorableTextEditingController() : RestorableTextEditingController.fromValue(value);
    if (!restorePending) {
      _registerRestorableController();
    }
  }

  void _onFocusChanged() {
    _isFocused.value = _effectiveFocusNode.hasFocus;
  }

  @override
  Widget build(BuildContext context) {
    final theme = TwixTheme.of(context);
    final effectiveTextStyle = widget.style ??
        theme.inputTheme.style ??
        theme.textTheme.bodyMedium.copyWith(color: theme.colorScheme.foreground);
    final effectiveDecoration = (theme.inputTheme.decoration ?? const TwixDecoration()).mergeWith(widget.decoration);
    final effectivePadding =
        widget.padding ?? theme.inputTheme.padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
    final effectiveInputPadding = widget.inputPadding ?? theme.inputTheme.inputPadding ?? EdgeInsets.zero;
    final effectivePlaceholderStyle =
        widget.placeholderStyle ?? theme.inputTheme.placeholderStyle ?? theme.textTheme.bodyMedium;
    final effectivePlaceholderAlignment =
        widget.placeholderAlignment ?? theme.inputTheme.placeholderAlignment ?? Alignment.topLeft;
    final effectiveMainAxisAlignment =
        widget.mainAxisAlignment ?? theme.inputTheme.mainAxisAlignment ?? MainAxisAlignment.start;
    final effectiveCrossAxisAlignment =
        widget.crossAxisAlignment ?? theme.inputTheme.crossAxisAlignment ?? CrossAxisAlignment.center;
    final effectiveMouseCursor = widget.mouseCursor ?? MouseCursor.defer;
    return TwixDisabled(
      disabled: !widget.enabled,
      child: _selectionGestureDetectorBuilder.buildGestureDetector(
        behavior: HitTestBehavior.translucent,
        child: ValueListenableBuilder(
          valueListenable: _isFocused,
          builder: (context, focused, _) {
            return ValueListenableBuilder(
              valueListenable: _effectiveController,
              builder: (context, textEditingValue, child) {
                return TwixDecorator(
                  decoration: effectiveDecoration,
                  isFocused: focused,
                  child: Padding(
                    padding: effectivePadding,
                    child: Row(
                      mainAxisAlignment: effectiveMainAxisAlignment,
                      crossAxisAlignment: effectiveCrossAxisAlignment,
                      children: [
                        if (widget.prefix != null) widget.prefix!,
                        Flexible(
                          child: AbsorbPointer(
                            absorbing: widget.readOnly,
                            child: Padding(
                              padding: effectiveInputPadding,
                              child: Stack(
                                children: [
                                  // placeholder
                                  if (textEditingValue.text.isEmpty && widget.placeholder != null)
                                    Positioned.fill(
                                      child: Align(
                                        alignment: effectivePlaceholderAlignment,
                                        child: DefaultTextStyle(
                                          style: effectivePlaceholderStyle,
                                          child: widget.placeholder!,
                                        ),
                                      ),
                                    ),
                                  RepaintBoundary(
                                    child: UnmanagedRestorationScope(
                                      bucket: bucket,
                                      child: EditableText(
                                        key: editableTextKey,
                                        controller: _effectiveController,
                                        obscuringCharacter: widget.obscuringCharacter,
                                        readOnly: widget.readOnly,
                                        focusNode: _effectiveFocusNode,
                                        style: effectiveTextStyle,
                                        strutStyle: widget.strutStyle,
                                        cursorColor: widget.cursorColor ?? theme.colorScheme.primary,
                                        backgroundCursorColor: Colors.grey,
                                        selectionColor:
                                            focused ? widget.selectionColor ?? theme.colorScheme.selection : null,
                                        keyboardType: widget.keyboardType,
                                        textInputAction: widget.textInputAction,
                                        textCapitalization: widget.textCapitalization,
                                        autofocus: widget.autofocus,
                                        obscureText: widget.obscureText,
                                        autocorrect: widget.autocorrect,
                                        magnifierConfiguration: widget.magnifierConfiguration,
                                        smartDashesType: widget.smartDashesType,
                                        smartQuotesType: widget.smartQuotesType,
                                        enableSuggestions: widget.enableSuggestions,
                                        maxLines: widget.maxLines,
                                        minLines: widget.minLines,
                                        expands: widget.expands,
                                        onChanged: widget.onChanged,
                                        onEditingComplete: widget.onEditingComplete,
                                        onSubmitted: widget.onSubmitted,
                                        onAppPrivateCommand: widget.onAppPrivateCommand,
                                        inputFormatters: widget.inputFormatters,
                                        cursorWidth: widget.cursorWidth,
                                        cursorHeight: widget.cursorHeight,
                                        cursorRadius: widget.cursorRadius,
                                        selectionHeightStyle: widget.selectionHeightStyle,
                                        selectionWidthStyle: widget.selectionWidthStyle,
                                        scrollPadding: widget.scrollPadding,
                                        dragStartBehavior: widget.dragStartBehavior,
                                        scrollController: widget.scrollController,
                                        scrollPhysics: widget.scrollPhysics,
                                        autofillHints: widget.autofillHints,
                                        clipBehavior: widget.clipBehavior,
                                        restorationId: 'editableInput',
                                        scribbleEnabled: widget.scribbleEnabled,
                                        enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
                                        contentInsertionConfiguration: widget.contentInsertionConfiguration,
                                        contextMenuBuilder: widget.contextMenuBuilder,
                                        selectionControls: widget.selectionControls,
                                        mouseCursor: effectiveMouseCursor,
                                        enableInteractiveSelection: widget.enableInteractiveSelection,
                                        undoController: widget.undoController,
                                        spellCheckConfiguration: widget.spellCheckConfiguration,
                                        textAlign: widget.textAlign,
                                        onTapOutside: widget.onTapOutside,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        if (widget.suffix != null) widget.suffix!,
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _InputSelectionGestureDetectorBuilder extends TextSelectionGestureDetectorBuilder {
  _InputSelectionGestureDetectorBuilder({
    required TwixInputState state,
  })  : _state = state,
        super(delegate: state);

  final TwixInputState _state;

  @override
  void onForcePressStart(ForcePressDetails details) {
    super.onForcePressStart(details);
    if (delegate.selectionEnabled && shouldShowSelectionToolbar) {
      editableText.showToolbar();
    }
  }

  @override
  void onForcePressEnd(ForcePressDetails details) {
    // Not required.
  }

  void onUserTap() {
    _state.widget.onTap?.call();
  }

  bool get onUserTapAlwaysCalled => _state.widget.onTapAlwaysCalled;

  @override
  void onSingleLongTapStart(LongPressStartDetails details) {
    super.onSingleLongTapStart(details);
    if (delegate.selectionEnabled) {
      switch (Theme.of(_state.context).platform) {
        case TargetPlatform.iOS:
        case TargetPlatform.macOS:
          break;
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
        case TargetPlatform.linux:
        case TargetPlatform.windows:
          Feedback.forLongPress(_state.context);
      }
    }
  }
}
