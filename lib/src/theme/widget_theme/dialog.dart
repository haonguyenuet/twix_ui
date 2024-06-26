import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:twix_ui/src/utils/position.dart';
import 'package:twix_ui/src/widgets/image.dart';

class TwixDialogTheme {
  const TwixDialogTheme({
    this.merge = true,
    this.closeIconSrc,
    this.closeIconPosition = const TwixPosition(top: 8, right: 8),
    this.radius,
    this.backgroundColor,
    this.expandActionsWhenTiny = true,
    this.padding = const EdgeInsets.all(24),
    this.insetPadding = const EdgeInsets.all(16),
    this.gap,
    this.animateIn,
    this.animateOut,
    this.constraints = const BoxConstraints(maxWidth: 512),
    this.border,
    this.shadows,
    this.removeBorderRadiusIfTiny = true,
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
  });

  final bool merge;
  final TwixIconImageSrc? closeIconSrc;
  final TwixPosition closeIconPosition;
  final BorderRadius? radius;
  final Color? backgroundColor;
  final bool expandActionsWhenTiny;
  final EdgeInsets padding;
  final EdgeInsets insetPadding;
  final double? gap;
  final List<Effect<dynamic>>? animateIn;
  final List<Effect<dynamic>>? animateOut;
  final BoxConstraints constraints;
  final Axis? actionsAxis;
  final MainAxisSize? actionsMainAxisSize;
  final MainAxisAlignment? actionsMainAxisAlignment;
  final VerticalDirection? actionsVerticalDirection;
  final BoxBorder? border;
  final List<BoxShadow>? shadows;
  final bool removeBorderRadiusIfTiny;
  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;
  final TextAlign? titleTextAlign;
  final TextAlign? descriptionTextAlign;
  final Alignment? alignment;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final bool? scrollable;
  final EdgeInsets? scrollPadding;

  static TwixDialogTheme lerp(
    TwixDialogTheme a,
    TwixDialogTheme b,
    double t,
  ) {
    if (identical(a, b)) return a;
    return TwixDialogTheme(
      merge: b.merge,
      closeIconSrc: b.closeIconSrc,
      closeIconPosition: TwixPosition.lerp(a.closeIconPosition, b.closeIconPosition, t)!,
      radius: BorderRadius.lerp(a.radius, b.radius, t),
      backgroundColor: Color.lerp(a.backgroundColor, b.backgroundColor, t),
      expandActionsWhenTiny: b.expandActionsWhenTiny,
      padding: EdgeInsets.lerp(a.padding, b.padding, t)!,
      insetPadding: EdgeInsets.lerp(a.insetPadding, b.insetPadding, t)!,
      gap: lerpDouble(a.gap, b.gap, t),
      animateIn: b.animateIn,
      animateOut: b.animateOut,
      constraints: b.constraints,
      border: b.border,
      shadows: b.shadows,
      removeBorderRadiusIfTiny: b.removeBorderRadiusIfTiny,
      actionsAxis: b.actionsAxis,
      actionsMainAxisSize: b.actionsMainAxisSize,
      actionsMainAxisAlignment: b.actionsMainAxisAlignment,
      actionsVerticalDirection: b.actionsVerticalDirection,
      titleStyle: TextStyle.lerp(a.titleStyle, b.titleStyle, t),
      descriptionStyle: TextStyle.lerp(a.descriptionStyle, b.descriptionStyle, t),
      titleTextAlign: b.titleTextAlign,
      descriptionTextAlign: b.descriptionTextAlign,
      alignment: Alignment.lerp(a.alignment, b.alignment, t),
      mainAxisAlignment: t < 0.5 ? a.mainAxisAlignment : b.mainAxisAlignment,
      crossAxisAlignment: t < 0.5 ? a.crossAxisAlignment : b.crossAxisAlignment,
      scrollable: t < 0.5 ? a.scrollable : b.scrollable,
      scrollPadding: EdgeInsets.lerp(a.scrollPadding, b.scrollPadding, t),
    );
  }

  TwixDialogTheme copyWith({
    bool? merge,
    TwixIconImageSrc? closeIconSrc,
    TwixPosition? closeIconPosition,
    BorderRadius? radius,
    Color? backgroundColor,
    bool? expandActionsWhenTiny,
    EdgeInsets? padding,
    EdgeInsets? insetPadding,
    double? gap,
    List<Effect<dynamic>>? animateIn,
    List<Effect<dynamic>>? animateOut,
    BoxConstraints? constraints,
    BoxBorder? border,
    List<BoxShadow>? shadows,
    bool? removeBorderRadiusIfTiny,
    Axis? actionsAxis,
    MainAxisSize? actionsMainAxisSize,
    MainAxisAlignment? actionsMainAxisAlignment,
    VerticalDirection? actionsVerticalDirection,
    TextStyle? titleStyle,
    TextStyle? descriptionStyle,
    TextAlign? titleTextAlign,
    TextAlign? descriptionTextAlign,
    Alignment? alignment,
    MainAxisAlignment? mainAxisAlignment,
    CrossAxisAlignment? crossAxisAlignment,
    bool? scrollable,
    EdgeInsets? scrollPadding,
  }) {
    return TwixDialogTheme(
      merge: merge ?? this.merge,
      closeIconSrc: closeIconSrc,
      closeIconPosition: closeIconPosition ?? this.closeIconPosition,
      radius: radius,
      backgroundColor: backgroundColor,
      expandActionsWhenTiny: expandActionsWhenTiny ?? this.expandActionsWhenTiny,
      padding: padding ?? this.padding,
      insetPadding: insetPadding ?? this.insetPadding,
      gap: gap,
      animateIn: animateIn,
      animateOut: animateOut,
      constraints: constraints ?? this.constraints,
      border: border,
      shadows: shadows,
      removeBorderRadiusIfTiny: removeBorderRadiusIfTiny ?? this.removeBorderRadiusIfTiny,
      actionsAxis: actionsAxis,
      actionsMainAxisSize: actionsMainAxisSize,
      actionsMainAxisAlignment: actionsMainAxisAlignment,
      actionsVerticalDirection: actionsVerticalDirection,
      titleStyle: titleStyle,
      descriptionStyle: descriptionStyle,
      titleTextAlign: titleTextAlign,
      descriptionTextAlign: descriptionTextAlign,
      alignment: alignment,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      scrollable: scrollable,
      scrollPadding: scrollPadding,
    );
  }

  TwixDialogTheme mergeWith(TwixDialogTheme? other) {
    if (other == null) return this;
    if (!other.merge) return other;
    return copyWith(
      closeIconSrc: other.closeIconSrc,
      closeIconPosition: other.closeIconPosition,
      radius: other.radius,
      backgroundColor: other.backgroundColor,
      expandActionsWhenTiny: other.expandActionsWhenTiny,
      padding: other.padding,
      insetPadding: other.insetPadding,
      gap: other.gap,
      animateIn: other.animateIn,
      animateOut: other.animateOut,
      constraints: other.constraints,
      border: other.border,
      shadows: other.shadows,
      removeBorderRadiusIfTiny: other.removeBorderRadiusIfTiny,
      actionsAxis: other.actionsAxis,
      actionsMainAxisSize: other.actionsMainAxisSize,
      actionsMainAxisAlignment: other.actionsMainAxisAlignment,
      actionsVerticalDirection: other.actionsVerticalDirection,
      titleStyle: other.titleStyle,
      descriptionStyle: other.descriptionStyle,
      titleTextAlign: other.titleTextAlign,
      descriptionTextAlign: other.descriptionTextAlign,
      alignment: other.alignment,
      mainAxisAlignment: other.mainAxisAlignment,
      crossAxisAlignment: other.crossAxisAlignment,
      scrollable: other.scrollable,
      scrollPadding: other.scrollPadding,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TwixDialogTheme &&
        other.merge == merge &&
        other.closeIconSrc == closeIconSrc &&
        other.closeIconPosition == closeIconPosition &&
        other.radius == radius &&
        other.backgroundColor == backgroundColor &&
        other.expandActionsWhenTiny == expandActionsWhenTiny &&
        other.padding == padding &&
        other.gap == gap &&
        listEquals(other.animateIn, animateIn) &&
        listEquals(other.animateOut, animateOut) &&
        other.constraints == constraints &&
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
        other.alignment == alignment &&
        other.mainAxisAlignment == mainAxisAlignment &&
        other.crossAxisAlignment == crossAxisAlignment &&
        other.scrollable == scrollable &&
        other.scrollPadding == scrollPadding;
  }

  @override
  int get hashCode {
    return merge.hashCode ^
        closeIconSrc.hashCode ^
        closeIconPosition.hashCode ^
        radius.hashCode ^
        backgroundColor.hashCode ^
        expandActionsWhenTiny.hashCode ^
        padding.hashCode ^
        gap.hashCode ^
        animateIn.hashCode ^
        animateOut.hashCode ^
        constraints.hashCode ^
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
        alignment.hashCode ^
        mainAxisAlignment.hashCode ^
        crossAxisAlignment.hashCode ^
        scrollable.hashCode ^
        scrollPadding.hashCode;
  }
}
