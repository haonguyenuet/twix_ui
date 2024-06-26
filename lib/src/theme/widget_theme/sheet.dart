import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:twix_ui/twix_ui.dart';

@immutable
class TwixSheetTheme {
  const TwixSheetTheme({
    this.merge = true,
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

  final bool merge;
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

  static TwixSheetTheme lerp(
    TwixSheetTheme a,
    TwixSheetTheme b,
    double t,
  ) {
    if (identical(a, b)) return a;
    return TwixSheetTheme(
      merge: b.merge,
      closeIconSrc: b.closeIconSrc,
      closeIconPosition: TwixPosition.lerp(a.closeIconPosition, b.closeIconPosition, t),
      radius: BorderRadius.lerp(a.radius, b.radius, t),
      backgroundColor: Color.lerp(a.backgroundColor, b.backgroundColor, t),
      expandActionsWhenTiny: b.expandActionsWhenTiny,
      padding: EdgeInsets.lerp(a.padding, b.padding, t),
      gap: lerpDouble(a.gap, b.gap, t),
      actionsAxis: b.actionsAxis,
      actionsMainAxisSize: b.actionsMainAxisSize,
      actionsMainAxisAlignment: b.actionsMainAxisAlignment,
      actionsVerticalDirection: b.actionsVerticalDirection,
      titleStyle: TextStyle.lerp(a.titleStyle, b.titleStyle, t),
      descriptionStyle: TextStyle.lerp(a.descriptionStyle, b.descriptionStyle, t),
      titleTextAlign: b.titleTextAlign,
      descriptionTextAlign: b.descriptionTextAlign,
      constraints: b.constraints,
      border: b.border,
      shadows: b.shadows,
      removeBorderRadiusIfTiny: b.removeBorderRadiusIfTiny,
      closeIcon: b.closeIcon,
      mainAxisAlignment: t < 0.5 ? a.mainAxisAlignment : b.mainAxisAlignment,
      crossAxisAlignment: t < 0.5 ? a.crossAxisAlignment : b.crossAxisAlignment,
      scrollable: t < 0.5 ? a.scrollable : b.scrollable,
      scrollPadding: EdgeInsets.lerp(a.scrollPadding, b.scrollPadding, t),
    );
  }

  TwixSheetTheme copyWith({
    bool? merge,
    BoxConstraints? constraints,
    bool? expandCrossSide,
    Widget? closeIcon,
    TwixIconImageSrc? closeIconSrc,
    TwixPosition? closeIconPosition,
    BorderRadius? radius,
    Color? backgroundColor,
    bool? expandActionsWhenTiny,
    EdgeInsets? padding,
    double? gap,
    Axis? actionsAxis,
    MainAxisSize? actionsMainAxisSize,
    MainAxisAlignment? actionsMainAxisAlignment,
    VerticalDirection? actionsVerticalDirection,
    BoxBorder? border,
    List<BoxShadow>? shadows,
    bool? removeBorderRadiusIfTiny,
    TextStyle? titleStyle,
    TextStyle? descriptionStyle,
    TextAlign? titleTextAlign,
    TextAlign? descriptionTextAlign,
    List<Effect<dynamic>>? animateIn,
    List<Effect<dynamic>>? animateOut,
    MainAxisAlignment? mainAxisAlignment,
    CrossAxisAlignment? crossAxisAlignment,
    bool? scrollable,
    EdgeInsets? scrollPadding,
  }) {
    return TwixSheetTheme(
      merge: merge ?? this.merge,
      constraints: constraints ?? this.constraints,
      expandCrossSide: expandCrossSide ?? this.expandCrossSide,
      closeIcon: closeIcon ?? this.closeIcon,
      closeIconSrc: closeIconSrc ?? this.closeIconSrc,
      closeIconPosition: closeIconPosition ?? this.closeIconPosition,
      radius: radius ?? this.radius,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      expandActionsWhenTiny: expandActionsWhenTiny ?? this.expandActionsWhenTiny,
      padding: padding ?? this.padding,
      gap: gap ?? this.gap,
      actionsAxis: actionsAxis ?? this.actionsAxis,
      actionsMainAxisSize: actionsMainAxisSize ?? this.actionsMainAxisSize,
      actionsMainAxisAlignment: actionsMainAxisAlignment ?? this.actionsMainAxisAlignment,
      actionsVerticalDirection: actionsVerticalDirection ?? this.actionsVerticalDirection,
      border: border ?? this.border,
      shadows: shadows ?? this.shadows,
      removeBorderRadiusIfTiny: removeBorderRadiusIfTiny ?? this.removeBorderRadiusIfTiny,
      titleStyle: titleStyle ?? this.titleStyle,
      descriptionStyle: descriptionStyle ?? this.descriptionStyle,
      titleTextAlign: titleTextAlign ?? this.titleTextAlign,
      descriptionTextAlign: descriptionTextAlign ?? this.descriptionTextAlign,
      mainAxisAlignment: mainAxisAlignment ?? this.mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment ?? this.crossAxisAlignment,
      scrollable: scrollable ?? this.scrollable,
      scrollPadding: scrollPadding ?? this.scrollPadding,
    );
  }

  TwixSheetTheme mergeWith(TwixSheetTheme? other) {
    if (other == null) return this;
    if (!other.merge) return other;
    return copyWith(
      closeIconSrc: other.closeIconSrc,
      closeIconPosition: other.closeIconPosition,
      radius: other.radius,
      backgroundColor: other.backgroundColor,
      expandActionsWhenTiny: other.expandActionsWhenTiny,
      padding: other.padding,
      gap: other.gap,
      actionsAxis: other.actionsAxis,
      actionsMainAxisSize: other.actionsMainAxisSize,
      actionsMainAxisAlignment: other.actionsMainAxisAlignment,
      actionsVerticalDirection: other.actionsVerticalDirection,
      border: other.border,
      shadows: other.shadows,
      removeBorderRadiusIfTiny: other.removeBorderRadiusIfTiny,
      titleStyle: other.titleStyle,
      descriptionStyle: other.descriptionStyle,
      titleTextAlign: other.titleTextAlign,
      descriptionTextAlign: other.descriptionTextAlign,
      mainAxisAlignment: other.mainAxisAlignment,
      crossAxisAlignment: other.crossAxisAlignment,
      scrollable: other.scrollable,
      scrollPadding: other.scrollPadding,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TwixSheetTheme &&
        other.merge == merge &&
        other.constraints == constraints &&
        other.expandCrossSide == expandCrossSide &&
        other.closeIcon == closeIcon &&
        other.closeIconSrc == closeIconSrc &&
        other.closeIconPosition == closeIconPosition &&
        other.radius == radius &&
        other.backgroundColor == backgroundColor &&
        other.expandActionsWhenTiny == expandActionsWhenTiny &&
        other.padding == padding &&
        other.gap == gap &&
        other.actionsAxis == actionsAxis &&
        other.actionsMainAxisSize == actionsMainAxisSize &&
        other.actionsMainAxisAlignment == actionsMainAxisAlignment &&
        other.actionsVerticalDirection == actionsVerticalDirection &&
        other.border == border &&
        listEquals(other.shadows, shadows) &&
        other.removeBorderRadiusIfTiny == removeBorderRadiusIfTiny &&
        other.titleStyle == titleStyle &&
        other.descriptionStyle == descriptionStyle &&
        other.titleTextAlign == titleTextAlign &&
        other.descriptionTextAlign == descriptionTextAlign &&
        other.mainAxisAlignment == mainAxisAlignment &&
        other.crossAxisAlignment == crossAxisAlignment &&
        other.scrollable == scrollable &&
        other.scrollPadding == scrollPadding;
  }

  @override
  int get hashCode {
    return merge.hashCode ^
        constraints.hashCode ^
        expandCrossSide.hashCode ^
        closeIcon.hashCode ^
        closeIconSrc.hashCode ^
        closeIconPosition.hashCode ^
        radius.hashCode ^
        backgroundColor.hashCode ^
        expandActionsWhenTiny.hashCode ^
        padding.hashCode ^
        gap.hashCode ^
        actionsAxis.hashCode ^
        actionsMainAxisSize.hashCode ^
        actionsMainAxisAlignment.hashCode ^
        actionsVerticalDirection.hashCode ^
        border.hashCode ^
        shadows.hashCode ^
        removeBorderRadiusIfTiny.hashCode ^
        titleStyle.hashCode ^
        descriptionStyle.hashCode ^
        titleTextAlign.hashCode ^
        descriptionTextAlign.hashCode ^
        mainAxisAlignment.hashCode ^
        crossAxisAlignment.hashCode ^
        scrollable.hashCode ^
        scrollPadding.hashCode;
  }
}
