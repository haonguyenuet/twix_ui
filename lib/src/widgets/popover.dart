import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:twix_ui/src/theme/theme.dart';
import 'package:twix_ui/src/theme/widget_theme/decorator.dart';
import 'package:twix_ui/src/widgets/portal.dart';

/// Controls the visibility of a [TwixPopover].
class TwixPopoverController extends ValueNotifier<bool> {
  TwixPopoverController({bool isOpen = false}) : super(isOpen);

  bool get isOpen => value;

  void show() {
    if (isOpen) return;
    value = true;
  }

  void hide() {
    if (!isOpen) return;
    value = false;
  }

  void toggle() => isOpen ? hide() : show();
}

class TwixPopover extends StatefulWidget {
  const TwixPopover({
    super.key,
    required this.child,
    required this.popoverBuilder,
    this.controller,
    this.closeOnTapOutside = true,
    this.focusNode,
    this.waitDuration,
    this.showDuration,
    this.anchor,
    this.effects,
    this.padding,
    this.decoration,
  });

  final Widget child;
  final WidgetBuilder popoverBuilder;
  final TwixPopoverController? controller;
  final bool closeOnTapOutside;
  final FocusNode? focusNode;
  final Duration? waitDuration;
  final Duration? showDuration;
  final TwixAnchorBase? anchor;
  final List<Effect<dynamic>>? effects;
  final EdgeInsets? padding;
  final TwixDecoration? decoration;

  @override
  State<TwixPopover> createState() => _TwixPopoverState();
}

class _TwixPopoverState extends State<TwixPopover> {
  final UniqueKey _popoverKey = UniqueKey();

  TwixPopoverController? _controller;
  TwixPopoverController get _effectiveController => widget.controller ?? _controller!;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = TwixPopoverController();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = TwixTheme.of(context);

    final effectiveEffects = widget.effects ?? theme.popoverTheme.effects;
    final effectivePadding = widget.padding ?? theme.popoverTheme.padding;
    final effectiveDecoration = (theme.popoverTheme.decoration ?? const TwixDecoration()).mergeWith(widget.decoration);
    final effectiveAnchor = widget.anchor ?? theme.popoverTheme.anchor;

    Widget popover = TwixDecorator(
      decoration: effectiveDecoration,
      child: Padding(
        padding: effectivePadding,
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: TextStyle(color: theme.colorScheme.popoverForeground),
          child: Builder(
            builder: widget.popoverBuilder,
          ),
        ),
      ),
    );

    if (effectiveEffects != null && effectiveEffects.isNotEmpty) {
      popover = Animate(
        effects: effectiveEffects,
        child: popover,
      );
    }

    if (widget.closeOnTapOutside) {
      popover = TapRegion(
        groupId: _popoverKey,
        behavior: HitTestBehavior.opaque,
        onTapOutside: (_) => _effectiveController.hide(),
        child: popover,
      );
    }

    return TapRegion(
      groupId: _popoverKey,
      child: ValueListenableBuilder(
        valueListenable: _effectiveController,
        builder: (context, isOpen, _) {
          return CallbackShortcuts(
            bindings: {
              const SingleActivator(LogicalKeyboardKey.escape): () {
                _effectiveController.hide();
              },
            },
            child: TwixPortal(
              portalBuilder: (context) => popover,
              visible: isOpen,
              anchor: effectiveAnchor,
              child: widget.child,
            ),
          );
        },
      ),
    );
  }
}
