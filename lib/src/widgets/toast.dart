import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:twix_ui/src/theme/theme.dart';
import 'package:twix_ui/src/theme/widget_theme/shadows.dart';
import 'package:twix_ui/src/utils/position.dart';
import 'package:twix_ui/src/utils/responsive.dart';

const kDefaultToastDuration = Duration(seconds: 3);

class TwixToastManager extends StatefulWidget {
  const TwixToastManager({super.key, required this.child});

  final Widget child;

  @override
  State<TwixToastManager> createState() => TwixToastManagerState();

  static TwixToastManagerState of<T>(BuildContext context) {
    return maybeOf<T>(context)!;
  }

  static TwixToastManagerState? maybeOf<T>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TwixToastManagerInheritedWidget>()?.data;
  }
}

class TwixToastManagerState extends State<TwixToastManager> with TickerProviderStateMixin {
  late final _animationController = AnimationController(vsync: this);
  final _visibleToast = ValueNotifier<TwixToast?>(null);
  final _shown = ValueNotifier(false);
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    _shown.dispose();
    _visibleToast.dispose();
    super.dispose();
  }

  void show(TwixToast toast) {
    _timer?.cancel();
    _shown.value = true;
    _visibleToast.value = toast;
    _animationController.forward(from: 0);
    final effectiveDuration = toast.duration ?? kDefaultToastDuration;
    _timer = Timer(effectiveDuration, hide);
  }

  Future<void> hide({bool animate = true}) async {
    _timer?.cancel();
    _shown.value = false;
    if (animate) await _animationController.forward(from: 0);
    _visibleToast.value = null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = TwixTheme.of(context);

    return TwixToastManagerInheritedWidget(
      data: this,
      child: Stack(
        children: [
          widget.child,
          ValueListenableBuilder(
            valueListenable: _visibleToast,
            builder: (context, toast, child) {
              final effectiveToastTheme = switch (toast?.type) {
                TwixToastVariant.primary || null => theme.primaryToastTheme,
                TwixToastVariant.error => theme.errorToastTheme,
              };
              final effectiveAlignment = toast?.alignment ?? effectiveToastTheme.alignment;
              final List<Effect<dynamic>> defaultAnimateIn = switch (effectiveAlignment) {
                Alignment.bottomRight || Alignment.bottomLeft || Alignment.bottomCenter => [
                    const SlideEffect(
                      begin: Offset(0, 1),
                      end: Offset.zero,
                    ),
                  ],
                Alignment.topRight || Alignment.topLeft || Alignment.topCenter => [
                    const SlideEffect(
                      begin: Offset(0, -1),
                      end: Offset.zero,
                    ),
                  ],
                Alignment.centerRight || Alignment.topRight || Alignment.bottomRight => [
                    const SlideEffect(
                      begin: Offset(1, 0),
                      end: Offset.zero,
                    ),
                  ],
                Alignment.centerLeft || Alignment.topLeft || Alignment.bottomLeft => [
                    const SlideEffect(
                      begin: Offset(-1, 0),
                      end: Offset.zero,
                    ),
                  ],
                Alignment.center || Alignment() => [
                    const FadeEffect(),
                    const ScaleEffect(
                      begin: Offset(.95, .95),
                      end: Offset(1, 1),
                    ),
                  ],
              };

              final List<Effect<dynamic>> defaultAnimateOut = switch (effectiveAlignment) {
                Alignment.bottomRight || Alignment.topRight || Alignment.centerRight => const [
                    SlideEffect(
                      begin: Offset.zero,
                      end: Offset(1, 0),
                    ),
                  ],
                Alignment.topLeft || Alignment.centerLeft || Alignment.bottomLeft => const [
                    SlideEffect(
                      begin: Offset.zero,
                      end: Offset(-1, 0),
                    ),
                  ],
                Alignment.topCenter => [
                    const SlideEffect(
                      begin: Offset.zero,
                      end: Offset(0, -1),
                    ),
                  ],
                Alignment.bottomCenter => [
                    const SlideEffect(
                      begin: Offset.zero,
                      end: Offset(0, 1),
                    ),
                  ],
                Alignment.center || Alignment() => [
                    const FadeEffect(begin: 1, end: 0),
                    const ScaleEffect(
                      begin: Offset(1, 1),
                      end: Offset(.95, .95),
                    ),
                  ],
              };

              final effectiveAnimateIn = toast?.animateIn ?? effectiveToastTheme.animateIn ?? defaultAnimateIn;
              final effectiveAnimateOut = toast?.animateOut ?? effectiveToastTheme.animateOut ?? defaultAnimateOut;

              final defaultOffset = switch (effectiveAlignment) {
                Alignment.topCenter ||
                Alignment.topLeft ||
                Alignment.topRight =>
                  Offset(16, MediaQuery.paddingOf(context).top + 16),
                Alignment.bottomCenter ||
                Alignment.bottomLeft ||
                Alignment.bottomRight =>
                  Offset(16, MediaQuery.paddingOf(context).bottom + 16),
                _ => const Offset(16, 16),
              };

              final effectiveOffset = toast?.offset ?? effectiveToastTheme.offset ?? defaultOffset;

              return Animate(
                controller: _animationController,
                effects: toast != null ? effectiveAnimateIn : effectiveAnimateOut,
                child: Align(
                  alignment: effectiveAlignment,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: effectiveOffset.dx,
                      vertical: effectiveOffset.dy,
                    ),
                    child: toast,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class TwixToastManagerInheritedWidget<T> extends InheritedWidget {
  const TwixToastManagerInheritedWidget({
    super.key,
    required this.data,
    required super.child,
  });

  final TwixToastManagerState data;

  @override
  bool updateShouldNotify(covariant TwixToastManagerInheritedWidget<T> oldWidget) {
    return oldWidget.data != data;
  }
}

enum TwixToastVariant {
  primary,
  error,
}

class TwixToast extends StatelessWidget {
  const TwixToast({
    super.key,
    this.title,
    this.description,
    this.action,
    this.closeIcon,
    this.alignment,
    this.offset,
    this.duration,
    this.textDirection,
    this.animateIn,
    this.animateOut,
    this.crossAxisAlignment,
    this.showCloseIconOnlyWhenHovered,
    this.titleStyle,
    this.descriptionStyle,
    this.actionPadding,
    this.border,
    this.radius,
    this.shadows,
    this.backgroundColor,
    this.padding,
    this.closeIconPosition,
    this.constraints,
  }) : type = TwixToastVariant.primary;

  const TwixToast.error({
    super.key,
    this.title,
    this.description,
    this.action,
    this.closeIcon,
    this.alignment,
    this.offset,
    this.duration,
    this.textDirection,
    this.animateIn,
    this.animateOut,
    this.crossAxisAlignment,
    this.showCloseIconOnlyWhenHovered,
    this.titleStyle,
    this.descriptionStyle,
    this.actionPadding,
    this.border,
    this.radius,
    this.shadows,
    this.backgroundColor,
    this.padding,
    this.closeIconPosition,
    this.constraints,
  }) : type = TwixToastVariant.error;

  const TwixToast.raw({
    super.key,
    required this.type,
    this.title,
    this.description,
    this.action,
    this.closeIcon,
    this.alignment,
    this.offset,
    this.duration,
    this.textDirection,
    this.animateIn,
    this.animateOut,
    this.crossAxisAlignment,
    this.showCloseIconOnlyWhenHovered,
    this.titleStyle,
    this.descriptionStyle,
    this.actionPadding,
    this.border,
    this.radius,
    this.shadows,
    this.backgroundColor,
    this.padding,
    this.closeIconPosition,
    this.constraints,
  });

  final Widget? title;
  final Widget? description;
  final Widget? action;
  final Widget? closeIcon;
  final Alignment? alignment;
  final Offset? offset;
  final Duration? duration;
  final List<Effect<dynamic>>? animateIn;
  final List<Effect<dynamic>>? animateOut;
  final TextDirection? textDirection;
  final CrossAxisAlignment? crossAxisAlignment;
  final bool? showCloseIconOnlyWhenHovered;
  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;
  final EdgeInsets? actionPadding;
  final Border? border;
  final BorderRadius? radius;
  final List<BoxShadow>? shadows;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final TwixPosition? closeIconPosition;
  final TwixToastVariant type;
  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    final theme = TwixTheme.of(context);

    final toastTheme = switch (type) {
      TwixToastVariant.primary => theme.primaryToastTheme,
      TwixToastVariant.error => theme.errorToastTheme,
    };
    final effectiveForegroundColor = switch (type) {
      TwixToastVariant.primary => theme.colorScheme.foreground,
      TwixToastVariant.error => theme.colorScheme.errorForeground,
    };

    final effectiveTitleStyle =
        titleStyle ?? toastTheme.titleStyle ?? theme.textTheme.titleSmall.copyWith(color: effectiveForegroundColor);
    final effectiveDescriptionStyle = descriptionStyle ??
        toastTheme.descriptionStyle ??
        theme.textTheme.bodySmall.copyWith(color: effectiveForegroundColor.withOpacity(.9));
    final effectiveActionPadding = actionPadding ?? toastTheme.actionPadding ?? const EdgeInsets.only(left: 16);
    final effectiveBorder = border ?? toastTheme.border ?? Border.all(color: theme.colorScheme.border);
    final effectiveBorderRadius = radius ?? toastTheme.radius ?? theme.radius;
    final effectiveShadows = shadows ?? toastTheme.shadows ?? TwixShadowsDefault.lg;
    final effectiveBackgroundColor = backgroundColor ?? toastTheme.backgroundColor ?? theme.colorScheme.background;
    final effectivePadding = padding ?? toastTheme.padding ?? const EdgeInsets.fromLTRB(24, 24, 32, 24);
    final effectiveCrossAxisAlignment =
        crossAxisAlignment ?? toastTheme.crossAxisAlignment ?? CrossAxisAlignment.center;

    return TwixResponsiveBuilder(
      builder: (context, breakpoint) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: breakpoint >= theme.breakpoints.medium ? 0 : double.infinity,
            maxWidth: breakpoint >= theme.breakpoints.medium ? 420 : double.infinity,
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: effectiveBorder,
              borderRadius: effectiveBorderRadius,
              boxShadow: effectiveShadows,
              color: effectiveBackgroundColor,
            ),
            child: Padding(
              padding: effectivePadding,
              child: Row(
                textDirection: textDirection,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: effectiveCrossAxisAlignment,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (title != null)
                          DefaultTextStyle(
                            style: effectiveTitleStyle,
                            child: title!,
                          ),
                        if (description != null)
                          DefaultTextStyle(
                            style: effectiveDescriptionStyle,
                            child: description!,
                          ),
                      ],
                    ),
                  ),
                  if (action != null)
                    Padding(
                      padding: effectiveActionPadding,
                      child: action,
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
