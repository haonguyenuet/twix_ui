import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:twix_ui/src/utils/position.dart';
import 'package:twix_ui/src/widgets/image.dart';

@immutable
class TwixToastTheme {
  const TwixToastTheme({
    this.merge = true,
    this.backgroundColor,
    this.closeIconSrc,
    this.alignment = Alignment.bottomRight,
    this.offset,
    this.duration,
    this.animateIn,
    this.animateOut,
    this.textDirection,
    this.crossAxisAlignment,
    this.titleStyle,
    this.descriptionStyle,
    this.actionPadding,
    this.border,
    this.radius,
    this.shadows,
    this.padding,
    this.constraints,
  });

  final bool merge;
  final Color? backgroundColor;
  final TwixIconImageSrc? closeIconSrc;
  final Alignment alignment;
  final Offset? offset;
  final Duration? duration;
  final List<Effect<dynamic>>? animateIn;
  final List<Effect<dynamic>>? animateOut;
  final TextDirection? textDirection;
  final CrossAxisAlignment? crossAxisAlignment;
  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;
  final EdgeInsets? actionPadding;
  final Border? border;
  final BorderRadius? radius;
  final List<BoxShadow>? shadows;
  final EdgeInsets? padding;
  final BoxConstraints? constraints;

  static TwixToastTheme lerp(
    TwixToastTheme a,
    TwixToastTheme b,
    double t,
  ) {
    if (identical(a, b)) return a;
    return TwixToastTheme(
      merge: b.merge,
      backgroundColor: Color.lerp(a.backgroundColor, b.backgroundColor, t),
      closeIconSrc: b.closeIconSrc,
      alignment: Alignment.lerp(a.alignment, b.alignment, t)!,
      offset: Offset.lerp(a.offset, b.offset, t),
      duration: b.duration,
      animateIn: b.animateIn,
      animateOut: b.animateOut,
      textDirection: b.textDirection,
      crossAxisAlignment: b.crossAxisAlignment,
      titleStyle: TextStyle.lerp(a.titleStyle, b.titleStyle, t),
      descriptionStyle: TextStyle.lerp(a.descriptionStyle, b.descriptionStyle, t),
      actionPadding: EdgeInsets.lerp(a.actionPadding, b.actionPadding, t),
      border: Border.lerp(a.border, b.border, t),
      radius: BorderRadius.lerp(a.radius, b.radius, t),
      shadows: b.shadows,
      padding: EdgeInsets.lerp(a.padding, b.padding, t),
      constraints: b.constraints,
    );
  }

  TwixToastTheme copyWith({
    bool? merge,
    Color? backgroundColor,
    TwixIconImageSrc? closeIconSrc,
    Alignment? alignment,
    Offset? offset,
    Duration? duration,
    List<Effect<dynamic>>? animateIn,
    List<Effect<dynamic>>? animateOut,
    TextDirection? textDirection,
    CrossAxisAlignment? crossAxisAlignment,
    bool? showCloseIconOnlyWhenHovered,
    TextStyle? titleStyle,
    TextStyle? descriptionStyle,
    EdgeInsets? actionPadding,
    Border? border,
    BorderRadius? radius,
    List<BoxShadow>? shadows,
    EdgeInsets? padding,
    TwixPosition? closeIconPosition,
    BoxConstraints? constraints,
  }) {
    return TwixToastTheme(
      merge: merge ?? this.merge,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      closeIconSrc: closeIconSrc ?? this.closeIconSrc,
      alignment: alignment ?? this.alignment,
      offset: offset ?? this.offset,
      duration: duration ?? this.duration,
      animateIn: animateIn ?? this.animateIn,
      animateOut: animateOut ?? this.animateOut,
      textDirection: textDirection ?? this.textDirection,
      crossAxisAlignment: crossAxisAlignment ?? this.crossAxisAlignment,
      titleStyle: titleStyle ?? this.titleStyle,
      descriptionStyle: descriptionStyle ?? this.descriptionStyle,
      actionPadding: actionPadding ?? this.actionPadding,
      border: border ?? this.border,
      radius: radius ?? this.radius,
      shadows: shadows ?? this.shadows,
      padding: padding ?? this.padding,
      constraints: constraints ?? this.constraints,
    );
  }

  TwixToastTheme mergeWith(TwixToastTheme? other) {
    if (other == null) return this;
    if (!other.merge) return other;
    return copyWith(
      backgroundColor: other.backgroundColor,
      closeIconSrc: other.closeIconSrc,
      alignment: other.alignment,
      offset: other.offset,
      duration: other.duration,
      animateIn: other.animateIn,
      animateOut: other.animateOut,
      textDirection: other.textDirection,
      crossAxisAlignment: other.crossAxisAlignment,
      titleStyle: other.titleStyle,
      descriptionStyle: other.descriptionStyle,
      actionPadding: other.actionPadding,
      border: other.border,
      radius: other.radius,
      shadows: other.shadows,
      padding: other.padding,
      constraints: other.constraints,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TwixToastTheme &&
        other.merge == merge &&
        other.backgroundColor == backgroundColor &&
        other.closeIconSrc == closeIconSrc &&
        other.alignment == alignment &&
        other.offset == offset &&
        other.duration == duration &&
        listEquals(other.animateIn, animateIn) &&
        listEquals(other.animateOut, animateOut) &&
        other.textDirection == textDirection &&
        other.crossAxisAlignment == crossAxisAlignment &&
        other.titleStyle == titleStyle &&
        other.descriptionStyle == descriptionStyle &&
        other.actionPadding == actionPadding &&
        other.border == border &&
        other.radius == radius &&
        listEquals(other.shadows, shadows) &&
        other.padding == padding &&
        other.constraints == constraints;
  }

  @override
  int get hashCode {
    return merge.hashCode ^
        backgroundColor.hashCode ^
        closeIconSrc.hashCode ^
        alignment.hashCode ^
        offset.hashCode ^
        duration.hashCode ^
        animateIn.hashCode ^
        animateOut.hashCode ^
        textDirection.hashCode ^
        crossAxisAlignment.hashCode ^
        titleStyle.hashCode ^
        descriptionStyle.hashCode ^
        actionPadding.hashCode ^
        border.hashCode ^
        radius.hashCode ^
        shadows.hashCode ^
        padding.hashCode ^
        constraints.hashCode;
  }
}
