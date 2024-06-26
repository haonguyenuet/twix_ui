import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:twix_ui/src/theme/theme.dart';
import 'package:twix_ui/src/theme/widget_theme/decorator.dart';
import 'package:twix_ui/src/widgets/disabled.dart';
import 'package:twix_ui/src/widgets/image.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class TwixCheckbox extends StatefulWidget {
  const TwixCheckbox({
    super.key,
    required this.checked,
    this.enabled = true,
    this.onChanged,
    this.decoration,
    this.size,
    this.duration,
    this.icon,
    this.color,
    this.title,
    this.subTitle,
    this.padding,
    this.direction,
  });

  final bool checked;
  final bool enabled;
  final ValueChanged<bool>? onChanged;
  final TwixDecoration? decoration;
  final double? size;
  final Duration? duration;
  final Widget? icon;
  final Color? color;
  final Widget? title;
  final Widget? subTitle;
  final EdgeInsets? padding;
  final TextDirection? direction;

  @override
  State<TwixCheckbox> createState() => _TwixCheckboxState();
}

class _TwixCheckboxState extends State<TwixCheckbox> {
  void _onPressed() {
    widget.onChanged?.call(!widget.checked);
  }

  @override
  Widget build(BuildContext context) {
    final theme = TwixTheme.of(context);

    final effectiveColor = widget.color ?? theme.checkboxTheme.color ?? theme.colorScheme.primary;
    final effectivePadding = widget.padding ?? theme.checkboxTheme.padding ?? const EdgeInsets.only(left: 8);
    final effectiveDuration = widget.duration ?? theme.checkboxTheme.duration ?? 100.milliseconds;
    final effectiveDecoration = (theme.checkboxTheme.decoration ?? const TwixDecoration())
        .mergeWith(widget.decoration)
        .copyWith(color: widget.checked ? effectiveColor : Colors.transparent);

    final effectiveSize = widget.size ?? theme.checkboxTheme.size ?? 16;
    final effectiveIcon = widget.icon ??
        TwixIconImage.square(
          LucideIcons.check,
          color: theme.colorScheme.primaryForeground,
          size: effectiveSize,
        );

    final checkbox = Semantics(
      checked: widget.checked,
      child: TwixDisabled(
        showForbiddenCursor: true,
        disabled: !widget.enabled,
        child: CallbackShortcuts(
          bindings: {
            const SingleActivator(LogicalKeyboardKey.enter): () {
              if (!widget.enabled) return;
              _onPressed();
            },
          },
          child: TwixDecorator(
            decoration: effectiveDecoration,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: SizedBox.square(
                dimension: effectiveSize,
                child: Center(
                  child: AnimatedSwitcher(
                    duration: effectiveDuration,
                    child: widget.checked ? effectiveIcon : const SizedBox(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    return TwixDisabled(
      showForbiddenCursor: true,
      disabled: !widget.enabled,
      opacity: 1,
      child: GestureDetector(
        onTap: _onPressed,
        child: Row(
          textDirection: widget.direction,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            checkbox,
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
