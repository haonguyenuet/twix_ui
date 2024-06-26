import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:twix_ui/src/theme/theme.dart';
import 'package:twix_ui/src/theme/widget_theme/button.dart';
import 'package:twix_ui/src/theme/widget_theme/decorator.dart';
import 'package:twix_ui/src/utils/gesture_detector.dart';
import 'package:twix_ui/src/utils/interaction_states_controller.dart';

enum TwixButtonType { filled, outline, icon, link }

class TwixButton extends StatefulWidget {
  const TwixButton({
    super.key,
    required this.type,
    this.text,
    this.icon,
    this.onPressed,
    this.applyIconColorFilter,
    this.cursor,
    this.width,
    this.height,
    this.padding,
    this.backgroundColor,
    this.hoverBackgroundColor,
    this.foregroundColor,
    this.hoverForegroundColor,
    this.pressedBackgroundColor,
    this.pressedForegroundColor,
    this.shadows,
    this.gradient,
    this.textDecoration,
    this.hoverTextDecoration,
    this.decoration,
    this.enabled = true,
    this.onLongPressed,
    this.interactionStatesController,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.hoverStrategies,
    this.onHoverChange,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onLongPressStart,
    this.onLongPressCancel,
    this.onLongPressUp,
    this.onLongPressDown,
    this.onLongPressEnd,
    this.onDoubleTap,
    this.onDoubleTapDown,
    this.onDoubleTapCancel,
    this.longPressDuration,
  });

  const TwixButton.filled({
    super.key,
    this.text,
    this.icon,
    this.onPressed,
    this.applyIconColorFilter,
    this.cursor,
    this.width,
    this.height,
    this.padding,
    this.backgroundColor,
    this.hoverBackgroundColor,
    this.foregroundColor,
    this.hoverForegroundColor,
    this.pressedBackgroundColor,
    this.pressedForegroundColor,
    this.shadows,
    this.gradient,
    this.textDecoration,
    this.hoverTextDecoration,
    this.decoration,
    this.enabled = true,
    this.onLongPressed,
    this.interactionStatesController,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.hoverStrategies,
    this.onHoverChange,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onLongPressStart,
    this.onLongPressCancel,
    this.onLongPressUp,
    this.onLongPressDown,
    this.onLongPressEnd,
    this.onDoubleTap,
    this.onDoubleTapDown,
    this.onDoubleTapCancel,
    this.longPressDuration,
  }) : type = TwixButtonType.filled;

  const TwixButton.outline({
    super.key,
    this.text,
    this.icon,
    this.onPressed,
    this.applyIconColorFilter,
    this.cursor,
    this.width,
    this.height,
    this.padding,
    this.backgroundColor,
    this.hoverBackgroundColor,
    this.foregroundColor,
    this.hoverForegroundColor,
    this.pressedBackgroundColor,
    this.pressedForegroundColor,
    this.shadows,
    this.gradient,
    this.textDecoration,
    this.hoverTextDecoration,
    this.decoration,
    this.enabled = true,
    this.onLongPressed,
    this.interactionStatesController,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.hoverStrategies,
    this.onHoverChange,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onLongPressStart,
    this.onLongPressCancel,
    this.onLongPressUp,
    this.onLongPressDown,
    this.onLongPressEnd,
    this.onDoubleTap,
    this.onDoubleTapDown,
    this.onDoubleTapCancel,
    this.longPressDuration,
  }) : type = TwixButtonType.outline;

  const TwixButton.icon({
    super.key,
    this.icon,
    this.onPressed,
    double? size,
    this.applyIconColorFilter,
    this.cursor,
    this.padding,
    this.backgroundColor,
    this.hoverBackgroundColor,
    this.foregroundColor,
    this.hoverForegroundColor,
    this.pressedBackgroundColor,
    this.pressedForegroundColor,
    this.shadows,
    this.gradient,
    this.hoverTextDecoration,
    this.decoration,
    this.enabled = true,
    this.onLongPressed,
    this.interactionStatesController,
    this.hoverStrategies,
    this.onHoverChange,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onLongPressStart,
    this.onLongPressCancel,
    this.onLongPressUp,
    this.onLongPressDown,
    this.onLongPressEnd,
    this.onDoubleTap,
    this.onDoubleTapDown,
    this.onDoubleTapCancel,
    this.longPressDuration,
  })  : type = TwixButtonType.icon,
        width = size,
        height = size,
        text = null,
        textDecoration = null,
        mainAxisAlignment = MainAxisAlignment.center,
        crossAxisAlignment = CrossAxisAlignment.center;

  const TwixButton.link({
    super.key,
    required this.text,
    this.onPressed,
    this.applyIconColorFilter,
    this.cursor,
    this.width,
    this.height,
    this.padding,
    this.backgroundColor,
    this.hoverBackgroundColor,
    this.foregroundColor,
    this.hoverForegroundColor,
    this.pressedBackgroundColor,
    this.pressedForegroundColor,
    this.shadows,
    this.gradient,
    this.textDecoration,
    this.hoverTextDecoration,
    this.decoration,
    this.enabled = true,
    this.onLongPressed,
    this.interactionStatesController,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.hoverStrategies,
    this.onHoverChange,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onLongPressStart,
    this.onLongPressCancel,
    this.onLongPressUp,
    this.onLongPressDown,
    this.onLongPressEnd,
    this.onDoubleTap,
    this.onDoubleTapDown,
    this.onDoubleTapCancel,
    this.longPressDuration,
  })  : type = TwixButtonType.link,
        icon = null;

  final VoidCallback? onPressed;
  final VoidCallback? onLongPressed;
  final Widget? icon;
  final Widget? text;
  final TwixButtonType type;
  final bool? applyIconColorFilter;
  final MouseCursor? cursor;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? hoverBackgroundColor;
  final Color? hoverForegroundColor;
  final Color? pressedBackgroundColor;
  final Color? pressedForegroundColor;
  final Gradient? gradient;
  final List<BoxShadow>? shadows;
  final TextDecoration? textDecoration;
  final TextDecoration? hoverTextDecoration;
  final TwixDecoration? decoration;
  final bool enabled;
  final TwixInteractionStatesController? interactionStatesController;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final TwixHoverStrategies? hoverStrategies;
  final ValueChanged<bool>? onHoverChange;
  final ValueChanged<TapDownDetails>? onTapDown;
  final ValueChanged<TapUpDetails>? onTapUp;
  final VoidCallback? onTapCancel;
  final ValueChanged<LongPressStartDetails>? onLongPressStart;
  final VoidCallback? onLongPressCancel;
  final VoidCallback? onLongPressUp;
  final ValueChanged<LongPressDownDetails>? onLongPressDown;
  final ValueChanged<LongPressEndDetails>? onLongPressEnd;
  final VoidCallback? onDoubleTap;
  final ValueChanged<TapDownDetails>? onDoubleTapDown;
  final VoidCallback? onDoubleTapCancel;
  final Duration? longPressDuration;

  @override
  State<TwixButton> createState() => _TwixButtonState();
}

class _TwixButtonState extends State<TwixButton> {
  late TwixInteractionStatesController _interactionStatesController;

  @override
  void initState() {
    super.initState();
    _interactionStatesController = widget.interactionStatesController ?? TwixInteractionStatesController();
    _interactionStatesController.update(TwixInteractionState.disabled, !widget.enabled);
  }

  @override
  void didUpdateWidget(covariant TwixButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.enabled != widget.enabled) {
      _interactionStatesController.update(TwixInteractionState.disabled, !widget.enabled);
    }
  }

  @override
  void dispose() {
    if (widget.interactionStatesController == null) {
      _interactionStatesController.dispose();
    }
    super.dispose();
  }

  void _assertCheckHasTextOrIcon() {
    assert(
      widget.text != null || widget.icon != null,
      'Either text or icon must be provided',
    );
  }

  TextDecoration? _effectiveTextDecoration(TwixButtonTheme buttonTheme, {required bool hovered}) {
    if (hovered) {
      return widget.hoverTextDecoration ?? buttonTheme.hoverTextDecoration;
    }
    return widget.textDecoration ?? buttonTheme.textDecoration;
  }

  MouseCursor _effectiveCursor(TwixButtonTheme buttonTheme) {
    if (widget.cursor != null) return widget.cursor!;
    return (widget.enabled ? buttonTheme.cursor ?? SystemMouseCursors.click : MouseCursor.defer);
  }

  void _onPressed() {
    widget.onPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    _assertCheckHasTextOrIcon();

    final theme = TwixTheme.of(context);
    final buttonTheme = switch (widget.type) {
      TwixButtonType.filled => theme.filledButtonTheme,
      TwixButtonType.outline => theme.outlineButtonTheme,
      TwixButtonType.icon => theme.iconButtonTheme,
      TwixButtonType.link => theme.linkButtonTheme,
    };

    final effectiveWidth = widget.width ?? buttonTheme.width;
    final effectiveHeight = widget.height ?? buttonTheme.height;
    final effectivePadding = widget.padding ?? buttonTheme.padding;

    final effectiveBackground = widget.backgroundColor ?? buttonTheme.backgroundColor;
    final effectiveForeground = widget.foregroundColor ?? buttonTheme.foregroundColor;

    final effectiveHoverBackground =
        widget.hoverBackgroundColor ?? buttonTheme.hoverBackgroundColor ?? effectiveBackground;
    final effectiveHoverForeground =
        widget.hoverForegroundColor ?? buttonTheme.hoverForegroundColor ?? effectiveForeground;

    final effectivePressedBackground =
        widget.pressedBackgroundColor ?? buttonTheme.pressedBackgroundColor ?? effectiveHoverBackground;
    final effectivePressedForeground =
        widget.pressedForegroundColor ?? buttonTheme.pressedForegroundColor ?? effectiveHoverForeground;

    final effectiveDecoration = (buttonTheme.decoration ?? const TwixDecoration()).mergeWith(widget.decoration);
    final effectiveGradient = widget.gradient ?? buttonTheme.gradient;
    final effectiveShadows = widget.shadows ?? buttonTheme.shadows;

    final effectiveMainAxisAlignment = widget.mainAxisAlignment ?? buttonTheme.mainAxisAlignment;
    final effectiveCrossAxisAlignment = widget.crossAxisAlignment ?? buttonTheme.crossAxisAlignment;
    final effectiveLongPressDuration = widget.longPressDuration ?? buttonTheme.longPressDuration;
    final effectiveHoverStrategies = widget.hoverStrategies ?? buttonTheme.hoverStrategies;

    final applyIconColorFilter = widget.applyIconColorFilter ?? buttonTheme.applyIconColorFilter;
    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.enter): _onPressed,
      },
      child: ValueListenableBuilder(
        valueListenable: _interactionStatesController,
        builder: (context, states, _) {
          final pressed = states.contains(TwixInteractionState.pressed);
          final hovered = states.contains(TwixInteractionState.hovered);
          final enabled = !states.contains(TwixInteractionState.disabled);

          final updatedDecoration = effectiveDecoration.copyWith(
            color: pressed
                ? effectivePressedBackground
                : hovered
                    ? effectiveHoverBackground
                    : effectiveBackground,
            gradient: effectiveGradient,
            shadows: effectiveShadows,
          );

          // Applies the foreground color filter to the icon if provided
          var icon = widget.icon;
          if (icon != null &&
              applyIconColorFilter &&
              effectivePressedForeground != null &&
              effectiveHoverForeground != null &&
              effectiveForeground != null) {
            icon = ColorFiltered(
              colorFilter: ColorFilter.mode(
                pressed
                    ? effectivePressedForeground
                    : hovered
                        ? effectiveHoverForeground
                        : effectiveForeground,
                BlendMode.srcIn,
              ),
              child: icon,
            );
          }
          return Semantics(
            container: true,
            button: true,
            enabled: enabled,
            child: Opacity(
              opacity: enabled ? 1 : .5,
              child: AbsorbPointer(
                absorbing: !enabled,
                child: TwixDecorator(
                  decoration: updatedDecoration,
                  child: TwixGestureDetector(
                    behavior: HitTestBehavior.opaque,
                    cursor: _effectiveCursor(buttonTheme),
                    onTap: widget.onPressed == null ? null : _onPressed,
                    onHoverChange: (value) {
                      _interactionStatesController.update(TwixInteractionState.hovered, value);
                    },
                    hoverStrategies: effectiveHoverStrategies,
                    onTapDown: (details) {
                      _interactionStatesController.update(TwixInteractionState.pressed, true);
                      widget.onTapDown?.call(details);
                    },
                    onTapUp: (details) {
                      _interactionStatesController.update(TwixInteractionState.pressed, false);
                      widget.onTapUp?.call(details);
                    },
                    onTapCancel: () {
                      _interactionStatesController.update(TwixInteractionState.pressed, false);
                      widget.onTapCancel?.call();
                    },
                    onDoubleTap: widget.onDoubleTap,
                    onDoubleTapDown: widget.onDoubleTapDown,
                    onDoubleTapCancel: widget.onDoubleTapCancel,
                    onLongPressed: widget.onLongPressed,
                    onLongPressCancel: widget.onLongPressCancel,
                    onLongPressEnd: widget.onLongPressEnd,
                    onLongPressUp: widget.onLongPressUp,
                    onLongPressDown: widget.onLongPressDown,
                    onLongPressStart: widget.onLongPressStart,
                    longPressDuration: effectiveLongPressDuration,
                    child: SizedBox(
                      height: effectiveHeight,
                      width: effectiveWidth,
                      child: Padding(
                        padding: effectivePadding ?? EdgeInsets.zero,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: effectiveCrossAxisAlignment,
                          mainAxisAlignment: effectiveMainAxisAlignment,
                          children: [
                            if (icon != null) icon,
                            if (icon != null && widget.text != null) const SizedBox(width: 5),
                            if (widget.text != null)
                              DefaultTextStyle(
                                style: theme.textTheme.labelMedium.copyWith(
                                  color: pressed
                                      ? effectivePressedForeground
                                      : hovered
                                          ? effectiveHoverForeground
                                          : effectiveForeground,
                                  decoration: _effectiveTextDecoration(
                                    buttonTheme,
                                    hovered: hovered,
                                  ),
                                  decorationColor: effectiveForeground,
                                  decorationStyle: TextDecorationStyle.solid,
                                ),
                                textAlign: TextAlign.center,
                                child: widget.text!,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
