import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:twix_ui/src/theme/theme.dart';
import 'package:twix_ui/src/theme/widget_theme/decorator.dart';
import 'package:twix_ui/src/utils/iterable.dart';
import 'package:twix_ui/src/widgets/disabled.dart';

class TwixRadioGroup<T> extends StatefulWidget {
  const TwixRadioGroup({
    super.key,
    required this.items,
    this.initialValue,
    this.onChanged,
    this.enabled = true,
  });

  final T? initialValue;
  final Iterable<Widget> items;
  final ValueChanged<T?>? onChanged;
  final bool enabled;

  @override
  State<TwixRadioGroup<T>> createState() => TwixRadioGroupState<T>();

  static TwixRadioGroupState<T> of<T>(BuildContext context) {
    return maybeOf<T>(context)!;
  }

  static TwixRadioGroupState<T>? maybeOf<T>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TwixRadioGroupInheritedWidget<T>>()?.data;
  }
}

class TwixRadioGroupState<T> extends State<TwixRadioGroup<T>> {
  late T? selectedValue = widget.initialValue;

  @override
  void didUpdateWidget(covariant TwixRadioGroup<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      selectedValue = widget.initialValue;
    }
  }

  void select(T value, {bool hideOptions = true}) {
    final changed = value != selectedValue;
    if (!changed) return;
    setState(() => selectedValue = value);
    widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    return TwixRadioGroupInheritedWidget(
      data: this,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widget.items.toList().separatedBy(const SizedBox(height: 8)),
      ),
    );
  }
}

class TwixRadioGroupInheritedWidget<T> extends InheritedWidget {
  const TwixRadioGroupInheritedWidget({
    super.key,
    required this.data,
    required super.child,
  });

  final TwixRadioGroupState<T> data;

  @override
  bool updateShouldNotify(covariant TwixRadioGroupInheritedWidget<T> oldWidget) {
    return true;
  }
}

class TwixRadio<T> extends StatefulWidget {
  const TwixRadio({
    super.key,
    required this.value,
    this.enabled = true,
    this.decoration,
    this.size,
    this.circleSize,
    this.duration,
    this.color,
    this.title,
    this.subTitle,
    this.padding,
    this.direction,
  });

  final T value;
  final bool enabled;
  final TwixDecoration? decoration;
  final double? size;
  final double? circleSize;
  final Duration? duration;
  final Color? color;
  final Widget? title;
  final Widget? subTitle;
  final EdgeInsets? padding;
  final TextDirection? direction;

  @override
  State<TwixRadio<T>> createState() => _TwixRadioState<T>();
}

class _TwixRadioState<T> extends State<TwixRadio<T>> {
  @override
  Widget build(BuildContext context) {
    final theme = TwixTheme.of(context);
    final parentRadioGroup = TwixRadioGroup.of<T>(context);

    void onTap() {
      parentRadioGroup.select(widget.value);
    }

    final selected = parentRadioGroup.selectedValue == widget.value;
    final enabled = widget.enabled && parentRadioGroup.widget.enabled;

    final effectiveDecoration = (theme.radioTheme.decoration ?? const TwixDecoration()).mergeWith(widget.decoration);
    final effectiveSize = widget.size ?? theme.radioTheme.size ?? 16;
    final effectiveCircleSize = widget.circleSize ?? theme.radioTheme.circleSize ?? 10;
    final effectiveColor = widget.color ?? theme.radioTheme.color ?? theme.colorScheme.primary;
    final effectiveDuration = widget.duration ?? theme.radioTheme.duration ?? 100.milliseconds;
    final effectivePadding = widget.padding ?? theme.radioTheme.padding ?? const EdgeInsets.only(left: 8);

    final radio = Semantics(
      checked: selected,
      child: TwixDisabled(
        showForbiddenCursor: true,
        disabled: !enabled,
        child: CallbackShortcuts(
          bindings: {
            const SingleActivator(LogicalKeyboardKey.enter): () {
              if (!enabled) return;
              onTap();
            },
          },
          child: TwixDecorator(
            decoration: effectiveDecoration,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: SizedBox.square(
                dimension: effectiveSize,
                child: AnimatedSwitcher(
                  duration: effectiveDuration,
                  child: selected
                      ? Align(
                          child: SizedBox.square(
                            dimension: effectiveCircleSize,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: effectiveColor,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    return TwixDisabled(
      showForbiddenCursor: true,
      disabled: !enabled,
      opacity: 1,
      child: GestureDetector(
        onTap: enabled ? onTap : null,
        child: Row(
          textDirection: widget.direction,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            radio,
            if (widget.title != null)
              Flexible(
                child: Padding(
                  padding: effectivePadding,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: DefaultTextStyle(
                          style: theme.textTheme.titleSmall.copyWith(fontWeight: FontWeight.w500),
                          child: widget.title!,
                        ),
                      ),
                      if (widget.subTitle != null)
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: DefaultTextStyle(
                            style: theme.textTheme.bodySmall,
                            child: widget.subTitle!,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
