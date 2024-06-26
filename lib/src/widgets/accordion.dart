import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:twix_ui/src/theme/theme.dart';
import 'package:twix_ui/src/utils/animation_builder.dart';
import 'package:twix_ui/src/utils/effects.dart';
import 'package:twix_ui/src/utils/gesture_detector.dart';
import 'package:twix_ui/src/widgets/image.dart';

enum TwixAccordionType { single, multiple }

class TwixAccordion<T> extends StatefulWidget {
  TwixAccordion.single({
    super.key,
    required this.children,
    T? initialValue,
    this.maintainState,
  })  : type = TwixAccordionType.single,
        initialValue = initialValue == null ? <T>[] : <T>[initialValue];

  const TwixAccordion.multiple({
    super.key,
    required this.children,
    this.initialValue,
    this.maintainState,
  }) : type = TwixAccordionType.multiple;

  final TwixAccordionType type;
  final Iterable<Widget> children;
  final List<T>? initialValue;
  final bool? maintainState;

  @override
  State<TwixAccordion<T>> createState() => TwixAccordionState<T>();

  static TwixAccordionState<T> of<T>(BuildContext context) {
    return maybeOf<T>(context)!;
  }

  static TwixAccordionState<T>? maybeOf<T>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TwixAccordionInheritedWidget<T>>()?.data;
  }
}

class TwixAccordionState<T> extends State<TwixAccordion<T>> {
  late List<T> _values = widget.initialValue?.toList() ?? <T>[];

  bool get _maintainState {
    return widget.maintainState ?? TwixTheme.of(context, listen: false).accordionTheme.maintainState ?? false;
  }

  void _toggle(T value) {
    setState(() {
      switch (widget.type) {
        case TwixAccordionType.single:
          if (_values.contains(value)) {
            _values = <T>[];
          } else {
            _values = <T>[value];
          }
        case TwixAccordionType.multiple:
          if (_values.contains(value)) {
            _values.remove(value);
          } else {
            _values.add(value);
          }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TwixAccordionInheritedWidget<T>(
      data: this,
      child: FocusTraversalGroup(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: widget.children.toList(),
        ),
      ),
    );
  }
}

class TwixAccordionInheritedWidget<T> extends InheritedWidget {
  const TwixAccordionInheritedWidget({
    super.key,
    required this.data,
    required super.child,
  });

  final TwixAccordionState<T> data;

  @override
  bool updateShouldNotify(covariant TwixAccordionInheritedWidget<T> oldWidget) {
    return true;
  }
}

class TwixAccordionItem<T> extends StatefulWidget {
  const TwixAccordionItem({
    super.key,
    required this.value,
    required this.title,
    required this.content,
    this.separator,
    this.icon,
    this.iconSrc,
    this.iconEffects,
    this.padding,
    this.showUnderlineTitleOnHover,
    this.titleStyle,
    this.curve,
    this.duration,
    this.effects,
  });

  final T value;
  final Widget title;
  final Widget content;
  final Widget? separator;
  final Widget? icon;
  final EdgeInsets? padding;
  final TwixIconImageSrc? iconSrc;
  final bool? showUnderlineTitleOnHover;
  final TextStyle? titleStyle;
  final Curve? curve;
  final Duration? duration;
  final List<Effect<dynamic>>? iconEffects;
  final List<Effect<dynamic>>? effects;
  @override
  State<TwixAccordionItem<T>> createState() => _TwixAccordionItemState<T>();
}

class _TwixAccordionItemState<T> extends State<TwixAccordionItem<T>> with SingleTickerProviderStateMixin {
  final _isHovered = ValueNotifier(false);

  @override
  void dispose() {
    _isHovered.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final parentAccordion = TwixAccordion.of<T>(context);
    final isExpanded = parentAccordion._values.contains(widget.value);

    final theme = TwixTheme.of(context);
    final effectiveSeparator = widget.separator ?? const Divider();
    final effectiveDuration = widget.duration ?? theme.accordionTheme.duration ?? 300.milliseconds;
    final effectiveCurve = widget.curve ?? theme.accordionTheme.curve ?? const Cubic(0.87, 0, 0.13, 1);
    final effectiveTitleStyle = widget.titleStyle ?? theme.accordionTheme.titleStyle ?? theme.textTheme.titleMedium;
    final effectiveShowUnderlineTitleOnHover =
        widget.showUnderlineTitleOnHover ?? theme.accordionTheme.showUnderlineTitleOnHover;

    final effectiveIconSrc = widget.iconSrc ?? theme.accordionTheme.iconSrc ?? LucideIcons.chevronDown;
    final effectiveIcon = widget.icon ??
        TwixIconImage.square(
          effectiveIconSrc,
          color: theme.colorScheme.foreground,
          size: 16,
        );

    final effectiveIconEffects = widget.iconEffects ??
        theme.accordionTheme.iconEffects ??
        [
          RotateEffect(
            begin: 0,
            end: .5,
            duration: 300.milliseconds,
            curve: effectiveCurve,
          ),
        ];

    final effectivePadding = widget.padding ?? theme.accordionTheme.padding ?? const EdgeInsets.symmetric(vertical: 16);

    final effectiveEffects = widget.effects ??
        theme.accordionTheme.effects ??
        [
          PaddingEffect(
            padding: const EdgeInsets.only(bottom: 8),
            curve: effectiveCurve,
            duration: effectiveDuration,
          ),
          SlideEffect(
            curve: effectiveCurve,
            begin: const Offset(0, -1),
            end: Offset.zero,
            duration: effectiveDuration,
          ),
          SizeEffect(
            curve: effectiveCurve,
            duration: effectiveDuration,
          ),
        ];

    return TwixAnimationBuilder(
      duration: effectiveDuration,
      builder: (context, controller) {
        if (isExpanded && !controller.isCompleted) {
          controller.forward();
        } else if (!isExpanded && !controller.isDismissed) {
          controller.reverse();
        }

        final isClosed = !isExpanded && controller.isDismissed;
        final shouldRemoveChild = isClosed && !parentAccordion._maintainState;
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TwixGestureDetector(
              cursor: SystemMouseCursors.click,
              onHoverChange: (value) => _isHovered.value = value,
              behavior: HitTestBehavior.opaque,
              onTap: () => parentAccordion._toggle(widget.value),
              child: Padding(
                padding: effectivePadding,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ValueListenableBuilder(
                      valueListenable: _isHovered,
                      builder: (context, hovered, child) {
                        return DefaultTextStyle(
                          style: effectiveTitleStyle.copyWith(
                            decoration: hovered && effectiveShowUnderlineTitleOnHover ? TextDecoration.underline : null,
                          ),
                          child: widget.title,
                        );
                      },
                    ),
                    Animate(
                      target: isExpanded ? 1 : 0,
                      effects: effectiveIconEffects,
                      child: effectiveIcon,
                    ),
                  ],
                ),
              ),
            ),
            if (!shouldRemoveChild)
              Animate(
                controller: controller,
                effects: effectiveEffects,
                child: widget.content,
              ),
            effectiveSeparator,
          ],
        );
      },
    );
  }
}
