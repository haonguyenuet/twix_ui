import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:twix_ui/src/theme/theme.dart';
import 'package:twix_ui/src/utils/iterable.dart';
import 'package:twix_ui/src/utils/position.dart';
import 'package:twix_ui/src/utils/responsive.dart';
import 'package:twix_ui/src/widgets/button.dart';
import 'package:twix_ui/src/widgets/image.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

Future<T?> showTwixDialog<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool barrierDismissible = true,
  Color? barrierColor,
  String? barrierLabel,
  bool useRootNavigator = true,
  RouteSettings? routeSettings,
  Offset? anchorPoint,
  List<Effect<dynamic>>? animateIn,
  List<Effect<dynamic>>? animateOut,
  TwixDialogType type = TwixDialogType.primary,
}) {
  final theme = TwixTheme.of(context);
  final dialogTheme = switch (type) {
    TwixDialogType.primary => theme.primaryDialogTheme,
    TwixDialogType.alert => theme.alertDialogTheme,
  };

  final effectiveAnimateIn = animateIn ??
      dialogTheme.animateIn ??
      const [
        FadeEffect(),
        ScaleEffect(begin: Offset(.95, .95), end: Offset(1, 1)),
      ];

  final effectiveAnimateOut = animateOut ??
      dialogTheme.animateOut ??
      const [
        FadeEffect(begin: 1, end: 0),
        ScaleEffect(begin: Offset(1, 1), end: Offset(.95, .95)),
      ];

  var maxDuration = Animate.defaultDuration;
  for (final e in [...effectiveAnimateIn, ...effectiveAnimateOut]) {
    final duration = e.duration ?? Duration.zero;
    maxDuration = maxDuration > duration ? maxDuration : duration;
  }

  return showGeneralDialog<T>(
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) => builder(context),
    barrierColor: barrierColor ?? const Color(0xcc000000),
    barrierDismissible: barrierDismissible,
    barrierLabel: barrierLabel,
    useRootNavigator: useRootNavigator,
    routeSettings: routeSettings,
    anchorPoint: anchorPoint,
    transitionDuration: maxDuration,
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      if (animation.status == AnimationStatus.completed) {
        return child;
      }
      final animateIn = animation.status == AnimationStatus.forward;
      return Animate(
        effects: animateIn ? effectiveAnimateIn : effectiveAnimateOut,
        child: child,
      );
    },
  );
}

enum TwixDialogType { primary, alert }

class TwixDialog extends StatelessWidget {
  const TwixDialog({
    super.key,
    this.title,
    this.description,
    this.content,
    this.actions = const [],
    this.closeIcon,
    this.closeIconSrc,
    this.closeIconPosition,
    this.radius,
    this.backgroundColor,
    this.expandActionsWhenTiny,
    this.padding,
    this.insetPadding,
    this.gap,
    this.constraints,
    this.border,
    this.shadows,
    this.removeBorderRadiusIfTiny,
    this.actionsAxis,
    this.actionsMainAxisSize,
    this.actionsMainAxisAlignment,
    this.actionsVerticalDirection,
    this.titleStyle,
    this.descriptionStyle,
    this.titleTextAlign,
    this.descriptionTextAlign,
    this.alignment,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.scrollable,
    this.scrollPadding,
  }) : variant = TwixDialogType.primary;

  const TwixDialog.alert({
    super.key,
    this.title,
    this.description,
    this.content,
    this.actions = const [],
    this.closeIcon,
    this.closeIconSrc,
    this.closeIconPosition,
    this.radius,
    this.backgroundColor,
    this.expandActionsWhenTiny,
    this.padding,
    this.insetPadding,
    this.gap,
    this.constraints,
    this.border,
    this.shadows,
    this.removeBorderRadiusIfTiny,
    this.actionsAxis,
    this.actionsMainAxisSize,
    this.actionsMainAxisAlignment,
    this.actionsVerticalDirection,
    this.titleStyle,
    this.descriptionStyle,
    this.titleTextAlign,
    this.descriptionTextAlign,
    this.alignment,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.scrollable,
    this.scrollPadding,
  }) : variant = TwixDialogType.alert;

  final Widget? title;
  final Widget? description;
  final Widget? content;
  final TwixDialogType variant;
  final List<Widget> actions;
  final Widget? closeIcon;
  final TwixIconImageSrc? closeIconSrc;
  final TwixPosition? closeIconPosition;
  final BorderRadius? radius;
  final Color? backgroundColor;
  final bool? expandActionsWhenTiny;
  final EdgeInsets? padding;
  final EdgeInsets? insetPadding;
  final double? gap;
  final BoxConstraints? constraints;
  final Axis? actionsAxis;
  final MainAxisSize? actionsMainAxisSize;
  final MainAxisAlignment? actionsMainAxisAlignment;
  final VerticalDirection? actionsVerticalDirection;
  final BoxBorder? border;
  final List<BoxShadow>? shadows;
  final bool? removeBorderRadiusIfTiny;
  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;
  final TextAlign? titleTextAlign;
  final TextAlign? descriptionTextAlign;
  final Alignment? alignment;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final bool? scrollable;
  final EdgeInsets? scrollPadding;

  @override
  Widget build(BuildContext context) {
    final theme = TwixTheme.of(context);
    final dialogTheme = switch (variant) {
      TwixDialogType.primary => theme.primaryDialogTheme,
      TwixDialogType.alert => theme.alertDialogTheme,
    };

    final effectiveBackgroundColor = backgroundColor ?? dialogTheme.backgroundColor ?? theme.colorScheme.background;

    final effectiveCloseIcon = closeIcon ??
        TwixButton.icon(
          icon: TwixIconImage.square(
            size: 16,
            closeIconSrc ?? dialogTheme.closeIconSrc ?? LucideIcons.x,
          ),
          size: 20,
          padding: EdgeInsets.zero,
          foregroundColor: theme.colorScheme.foreground.withOpacity(.5),
          hoverBackgroundColor: Colors.transparent,
          hoverForegroundColor: theme.colorScheme.foreground,
          pressedForegroundColor: theme.colorScheme.foreground,
          onPressed: () => Navigator.of(context).pop(),
        );

    final effectiveCloseIconPosition = closeIconPosition ?? dialogTheme.closeIconPosition;
    final effectiveRadius = radius ?? dialogTheme.radius ?? theme.radius;
    final effectiveExpandActionsWhenTiny = expandActionsWhenTiny ?? dialogTheme.expandActionsWhenTiny;
    final effectiveConstraints = constraints ?? dialogTheme.constraints;
    final effectiveBorder = border ?? dialogTheme.border ?? Border.all(color: theme.colorScheme.border);
    final effectiveShadows = shadows ?? dialogTheme.shadows;
    final effectiveRemoveBorderRadiusIfTiny = removeBorderRadiusIfTiny ?? dialogTheme.removeBorderRadiusIfTiny;
    final effectivePadding = padding ?? dialogTheme.padding;
    final effectiveInsetPadding = insetPadding ?? dialogTheme.insetPadding;
    final effectiveGap = gap ?? dialogTheme.gap ?? 8;
    final effectiveTitleStyle = titleStyle ?? dialogTheme.titleStyle ?? theme.textTheme.titleMedium;
    final effectiveDescriptionStyle = descriptionStyle ?? dialogTheme.descriptionStyle ?? theme.textTheme.bodySmall;
    final effectiveAlignment = alignment ?? dialogTheme.alignment ?? Alignment.center;
    final effectiveMainAxisAlignment = mainAxisAlignment ?? dialogTheme.mainAxisAlignment ?? MainAxisAlignment.start;
    final effectiveCrossAxisAlignment =
        crossAxisAlignment ?? dialogTheme.crossAxisAlignment ?? CrossAxisAlignment.stretch;
    final effectiveScrollable = scrollable ?? dialogTheme.scrollable ?? true;
    final effectiveScrollPadding = scrollPadding ?? dialogTheme.scrollPadding ?? MediaQuery.viewInsetsOf(context);

    Widget dialog = Container(
      padding: effectiveInsetPadding,
      constraints: effectiveConstraints,
      child: TwixResponsiveBuilder(
        builder: (context, breakpoint) {
          final isTiny = breakpoint < theme.breakpoints.small;

          final effectiveActionsAxis =
              actionsAxis ?? dialogTheme.actionsAxis ?? (isTiny ? Axis.vertical : Axis.horizontal);
          final effectiveActionsMainAxisSize =
              actionsMainAxisSize ?? dialogTheme.actionsMainAxisSize ?? MainAxisSize.max;
          final effectiveActionsMainAxisAlignment =
              actionsMainAxisAlignment ?? dialogTheme.actionsMainAxisAlignment ?? MainAxisAlignment.end;
          final effectiveActionsVerticalDirection = actionsVerticalDirection ??
              dialogTheme.actionsVerticalDirection ??
              (isTiny ? VerticalDirection.up : VerticalDirection.down);
          final effectiveTitleTextAlign = titleTextAlign ?? dialogTheme.titleTextAlign ?? TextAlign.start;
          final effectiveDescriptionTextAlign =
              descriptionTextAlign ?? dialogTheme.descriptionTextAlign ?? TextAlign.start;

          Widget effectiveActions = Flex(
            direction: effectiveActionsAxis,
            mainAxisSize: effectiveActionsMainAxisSize,
            mainAxisAlignment: effectiveActionsMainAxisAlignment,
            verticalDirection: effectiveActionsVerticalDirection,
            children: actions,
          );

          if (isTiny && effectiveExpandActionsWhenTiny) {
            effectiveActions = TwixTheme(
              data: theme.copyWith(
                filledButtonTheme: theme.filledButtonTheme.copyWith(width: double.infinity),
                outlineButtonTheme: theme.outlineButtonTheme.copyWith(width: double.infinity),
                iconButtonTheme: theme.iconButtonTheme.copyWith(width: double.infinity),
              ),
              child: effectiveActions,
            );
          }

          Widget? effectiveContent;
          if (content != null) {
            effectiveContent = DefaultTextStyle(
              style: effectiveDescriptionStyle,
              child: content!,
            );
            if (effectiveScrollable) {
              effectiveContent = Flexible(
                child: SingleChildScrollView(
                  padding: effectiveScrollPadding,
                  child: effectiveContent,
                ),
              );
            }
          }

          return DecoratedBox(
            decoration: BoxDecoration(
              color: effectiveBackgroundColor,
              borderRadius: (isTiny && effectiveRemoveBorderRadiusIfTiny) ? null : effectiveRadius,
              border: effectiveBorder,
              boxShadow: effectiveShadows,
            ),
            child: Stack(
              children: [
                Padding(
                  padding: effectivePadding,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: effectiveMainAxisAlignment,
                    crossAxisAlignment: effectiveCrossAxisAlignment,
                    children: [
                      if (title != null)
                        DefaultTextStyle(
                          style: effectiveTitleStyle,
                          textAlign: effectiveTitleTextAlign,
                          child: title!,
                        ),
                      if (description != null)
                        DefaultTextStyle(
                          style: effectiveDescriptionStyle,
                          textAlign: effectiveDescriptionTextAlign,
                          child: description!,
                        ),
                      if (effectiveContent != null) effectiveContent,
                      if (actions.isNotEmpty) effectiveActions,
                    ].separatedBy(SizedBox(height: effectiveGap)),
                  ),
                ),
                effectiveCloseIcon.positionedWith(effectiveCloseIconPosition),
              ],
            ),
          );
        },
      ),
    );

    return Align(
      alignment: effectiveAlignment,
      child: dialog,
    );
  }
}
