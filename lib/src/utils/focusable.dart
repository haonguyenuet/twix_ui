import 'package:flutter/widgets.dart';

typedef FocusWidgetBuilder = Widget Function(BuildContext context, bool focused, Widget? child);

class TwixFocusable extends StatefulWidget {
  const TwixFocusable({
    super.key,
    required this.builder,
    required this.focusNode,
    this.canRequestFocus = true,
    this.autofocus = false,
    this.child,
    this.onFocusChange,
  });

  final bool canRequestFocus;
  final bool autofocus;
  final FocusNode focusNode;
  final FocusWidgetBuilder builder;
  final Widget? child;
  final Function(bool)? onFocusChange;

  @override
  State<TwixFocusable> createState() => _TwixFocusableState();
}

class _TwixFocusableState extends State<TwixFocusable> {
  final ValueNotifier _isFocused = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _isFocused.value = widget.focusNode.hasFocus;
  }

  @override
  void dispose() {
    _isFocused.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      canRequestFocus: widget.canRequestFocus,
      onFocusChange: (value) {
        _isFocused.value = value;
        widget.onFocusChange?.call(value);
      },
      child: ValueListenableBuilder(
        valueListenable: _isFocused,
        builder: (context, value, child) => widget.builder(context, value, child),
        child: widget.child,
      ),
    );
  }
}
