import 'package:flutter/material.dart';
import 'package:twix_ui/twix_ui.dart';

Future<T?> showTwixSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  TwixSheetSide? side,
  Color? backgroundColor,
  String barrierLabel = '',
  ShapeBorder? shape,
  Color barrierColor = const Color(0xcc000000),
  bool useRootNavigator = false,
  bool isDismissible = true,
  RouteSettings? routeSettings,
  Offset? anchorPoint,
}) {
  final effectiveSide = side ?? TwixSheetSide.bottom;
  final effectiveAnimateIn = switch (effectiveSide) {
    TwixSheetSide.top => const SlideEffect(
        begin: Offset(0, -1),
        end: Offset.zero,
      ),
    TwixSheetSide.bottom => const SlideEffect(
        begin: Offset(0, 1),
        end: Offset.zero,
      ),
    TwixSheetSide.left => const SlideEffect(
        begin: Offset(-1, 0),
        end: Offset.zero,
      ),
    TwixSheetSide.right => const SlideEffect(
        begin: Offset(1, 0),
        end: Offset.zero,
      ),
  };
  final effectiveAnimateOut = switch (effectiveSide) {
    TwixSheetSide.top => const SlideEffect(
        begin: Offset.zero,
        end: Offset(0, -1),
      ),
    TwixSheetSide.bottom => const SlideEffect(
        begin: Offset.zero,
        end: Offset(0, 1),
      ),
    TwixSheetSide.left => const SlideEffect(
        begin: Offset.zero,
        end: Offset(-1, 0),
      ),
    TwixSheetSide.right => const SlideEffect(
        begin: Offset.zero,
        end: Offset(1, 0),
      ),
  };

  return showTwixDialog<T>(
    context: context,
    builder: (context) => TwixSheetInheritedWidget(side: effectiveSide, child: builder(context)),
    barrierColor: barrierColor,
    barrierLabel: barrierLabel,
    barrierDismissible: isDismissible,
    useRootNavigator: useRootNavigator,
    routeSettings: routeSettings,
    anchorPoint: anchorPoint,
    animateIn: [effectiveAnimateIn],
    animateOut: [effectiveAnimateOut],
  );
}

class TwixSheetInheritedWidget extends InheritedWidget {
  const TwixSheetInheritedWidget({
    super.key,
    required super.child,
    required this.side,
  });

  final TwixSheetSide side;

  static TwixSheetSide of(BuildContext context) {
    final inherited =
        context.getElementForInheritedWidgetOfExactType<TwixSheetInheritedWidget>()!.widget as TwixSheetInheritedWidget;
    return inherited.side;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}

enum TwixSheetSide {
  top,
  right,
  bottom,
  left;

  Alignment toAlignment() {
    return switch (this) {
      TwixSheetSide.top => Alignment.topCenter,
      TwixSheetSide.bottom => Alignment.bottomCenter,
      TwixSheetSide.left => Alignment.topLeft,
      TwixSheetSide.right => Alignment.topRight,
    };
  }
}

class TwixSheet extends StatelessWidget {
  const TwixSheet({
    super.key,
    this.title,
    this.description,
    this.content,
    this.actions = const [],
    this.constraints,
    this.expandCrossSide,
    this.closeIcon,
    this.closeIconSrc,
    this.closeIconPosition,
    this.radius,
    this.backgroundColor,
    this.expandActionsWhenTiny,
    this.padding,
    this.gap,
    this.actionsAxis,
    this.actionsMainAxisSize,
    this.actionsMainAxisAlignment,
    this.actionsVerticalDirection,
    this.border,
    this.shadows,
    this.removeBorderRadiusIfTiny,
    this.titleStyle,
    this.descriptionStyle,
    this.titleTextAlign,
    this.descriptionTextAlign,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.scrollable,
    this.scrollPadding,
  });

  final Widget? title;
  final Widget? description;
  final Widget? content;
  final List<Widget> actions;
  final BoxConstraints? constraints;
  final bool? expandCrossSide;
  final Widget? closeIcon;
  final TwixIconImageSrc? closeIconSrc;
  final TwixPosition? closeIconPosition;
  final BorderRadius? radius;
  final Color? backgroundColor;
  final bool? expandActionsWhenTiny;
  final EdgeInsets? padding;
  final double? gap;
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
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final bool? scrollable;
  final EdgeInsets? scrollPadding;

  @override
  Widget build(BuildContext context) {
    final theme = TwixTheme.of(context);
    final side = TwixSheetInheritedWidget.of(context);
    final screenSize = MediaQuery.sizeOf(context);

    final effectiveExpandCrossSide = expandCrossSide ?? theme.sheetTheme.expandCrossSide ?? true;
    final effectiveRadius = radius ?? theme.sheetTheme.radius ?? BorderRadius.zero;
    final effectiveBackgroundColor =
        backgroundColor ?? theme.sheetTheme.backgroundColor ?? theme.colorScheme.background;

    final effectiveExpandActionsWhenTiny = expandActionsWhenTiny ?? theme.sheetTheme.expandActionsWhenTiny ?? true;

    final defaultConstraints = switch (side) {
      TwixSheetSide.top || TwixSheetSide.bottom => BoxConstraints(minWidth: screenSize.width),
      TwixSheetSide.left || TwixSheetSide.right => BoxConstraints(minHeight: screenSize.height)
    };

    final defaultCrossAxisAlignment = switch (side) {
      TwixSheetSide.top || TwixSheetSide.bottom => CrossAxisAlignment.stretch,
      TwixSheetSide.left || TwixSheetSide.right => CrossAxisAlignment.start,
    };

    final defaultMainAxisAlignment = switch (side) {
      TwixSheetSide.top || TwixSheetSide.bottom => MainAxisAlignment.start,
      TwixSheetSide.left || TwixSheetSide.right => MainAxisAlignment.end,
    };

    final effectiveMainAxisAlignment =
        mainAxisAlignment ?? theme.sheetTheme.mainAxisAlignment ?? defaultMainAxisAlignment;
    final effectiveCrossAxisAlignment =
        crossAxisAlignment ?? theme.sheetTheme.crossAxisAlignment ?? defaultCrossAxisAlignment;
    var effectiveConstraints =
        constraints ?? theme.sheetTheme.constraints ?? (effectiveExpandCrossSide ? defaultConstraints : null);
    if (effectiveExpandCrossSide) {
      effectiveConstraints = effectiveConstraints?.enforce(defaultConstraints);
    }
    final effectiveBorder = border ?? theme.sheetTheme.border ?? Border.all(color: theme.colorScheme.border);
    final effectiveShadows = shadows ?? theme.sheetTheme.shadows;
    final effectiveRemoveBorderRadiusIfTiny = removeBorderRadiusIfTiny ?? theme.sheetTheme.removeBorderRadiusIfTiny;
    final effectivePadding = padding ?? theme.sheetTheme.padding;
    final effectiveGap = gap ?? theme.sheetTheme.gap;
    final effectiveTitleStyle = titleStyle ?? theme.sheetTheme.titleStyle;
    final effectiveDescriptionStyle = descriptionStyle ?? theme.sheetTheme.descriptionStyle;
    final effectiveCloseIconSrc = closeIconSrc ?? theme.sheetTheme.closeIconSrc;
    final effectiveCloseIconPosition = closeIconPosition ?? theme.sheetTheme.closeIconPosition;
    final effectiveActionsAxis = actionsAxis ?? theme.sheetTheme.actionsAxis;
    final effectiveActionsMainAxisSize = actionsMainAxisSize ?? theme.sheetTheme.actionsMainAxisSize;
    final effectiveActionsMainAxisAlignment = actionsMainAxisAlignment ?? theme.sheetTheme.actionsMainAxisAlignment;
    final effectiveActionsVerticalDirection = actionsVerticalDirection ?? theme.sheetTheme.actionsVerticalDirection;
    final effectiveTitleTextAlign = titleTextAlign ?? theme.sheetTheme.titleTextAlign;
    final effectiveDescriptionTextAlign = descriptionTextAlign ?? theme.sheetTheme.descriptionTextAlign;
    final effectiveScrollable = scrollable ?? theme.sheetTheme.scrollable ?? true;
    final effectiveScrollPadding = scrollPadding ?? theme.sheetTheme.scrollPadding ?? MediaQuery.viewInsetsOf(context);

    return TwixDialog(
      title: title,
      description: description,
      alignment: side.toAlignment(),
      constraints: effectiveConstraints,
      content: content,
      actions: actions,
      radius: effectiveRadius,
      closeIcon: closeIcon,
      closeIconSrc: effectiveCloseIconSrc,
      closeIconPosition: effectiveCloseIconPosition,
      backgroundColor: effectiveBackgroundColor,
      expandActionsWhenTiny: effectiveExpandActionsWhenTiny,
      padding: effectivePadding,
      insetPadding: EdgeInsets.zero,
      gap: effectiveGap,
      actionsAxis: effectiveActionsAxis,
      actionsMainAxisSize: effectiveActionsMainAxisSize,
      actionsMainAxisAlignment: effectiveActionsMainAxisAlignment,
      actionsVerticalDirection: effectiveActionsVerticalDirection,
      border: effectiveBorder,
      shadows: effectiveShadows,
      removeBorderRadiusIfTiny: effectiveRemoveBorderRadiusIfTiny,
      titleStyle: effectiveTitleStyle,
      descriptionStyle: effectiveDescriptionStyle,
      titleTextAlign: effectiveTitleTextAlign,
      descriptionTextAlign: effectiveDescriptionTextAlign,
      crossAxisAlignment: effectiveCrossAxisAlignment,
      mainAxisAlignment: effectiveMainAxisAlignment,
      scrollable: effectiveScrollable,
      scrollPadding: effectiveScrollPadding,
    );
  }
}
