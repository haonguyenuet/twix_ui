import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:twix_ui/src/theme/widget_theme/decorator.dart';
import 'package:twix_ui/src/utils/gesture_detector.dart';

/// The theme for ShadButton.
///
/// Use this class to override some properties to all buttons in just one place.
@immutable
class TwixButtonTheme {
  const TwixButtonTheme({
    this.merge = true,
    this.applyIconColorFilter = true,
    this.cursor,
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
    this.width,
    this.height,
    this.padding,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.longPressDuration,
    this.hoverStrategies,
  });

  final bool merge;
  final bool applyIconColorFilter;
  final MouseCursor? cursor;
  final Color? backgroundColor;
  final Color? hoverBackgroundColor;
  final Color? foregroundColor;
  final Color? hoverForegroundColor;
  final Color? pressedBackgroundColor;
  final Color? pressedForegroundColor;
  final List<BoxShadow>? shadows;
  final Gradient? gradient;
  final TextDecoration? textDecoration;
  final TextDecoration? hoverTextDecoration;
  final TwixDecoration? decoration;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final Duration? longPressDuration;
  final TwixHoverStrategies? hoverStrategies;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  static TwixButtonTheme lerp(TwixButtonTheme a, TwixButtonTheme b, double t) {
    if (identical(a, b)) return a;
    return TwixButtonTheme(
      applyIconColorFilter: b.applyIconColorFilter,
      backgroundColor: Color.lerp(a.backgroundColor, b.backgroundColor, t),
      hoverBackgroundColor: Color.lerp(a.hoverBackgroundColor, b.hoverBackgroundColor, t),
      foregroundColor: Color.lerp(a.foregroundColor, b.foregroundColor, t),
      hoverForegroundColor: Color.lerp(a.hoverForegroundColor, b.hoverForegroundColor, t),
      pressedBackgroundColor: Color.lerp(a.pressedBackgroundColor, b.pressedBackgroundColor, t),
      pressedForegroundColor: Color.lerp(a.pressedForegroundColor, b.pressedForegroundColor, t),
      shadows: b.shadows,
      gradient: b.gradient,
      textDecoration: b.textDecoration,
      hoverTextDecoration: b.hoverTextDecoration,
      cursor: b.cursor,
      decoration: TwixDecoration.lerp(a.decoration, b.decoration, t),
      width: lerpDouble(a.width, b.width, t),
      height: lerpDouble(a.height, b.height, t),
      padding: EdgeInsets.lerp(a.padding, b.padding, t),
      mainAxisAlignment: b.mainAxisAlignment,
      crossAxisAlignment: b.crossAxisAlignment,
      longPressDuration: a.longPressDuration != null && b.longPressDuration != null
          ? lerpDuration(a.longPressDuration!, b.longPressDuration!, t)
          : b.longPressDuration,
      hoverStrategies: b.hoverStrategies,
    );
  }

  TwixButtonTheme mergeWith(TwixButtonTheme? other) {
    if (other == null) return this;
    if (!other.merge) return other;
    return copyWith(
      applyIconColorFilter: other.applyIconColorFilter,
      cursor: other.cursor,
      backgroundColor: other.backgroundColor,
      hoverBackgroundColor: other.hoverBackgroundColor,
      foregroundColor: other.foregroundColor,
      hoverForegroundColor: other.hoverForegroundColor,
      pressedBackgroundColor: other.pressedBackgroundColor,
      pressedForegroundColor: other.pressedForegroundColor,
      shadows: other.shadows,
      gradient: other.gradient,
      textDecoration: other.textDecoration,
      hoverTextDecoration: other.hoverTextDecoration,
      decoration: decoration?.mergeWith(other.decoration) ?? other.decoration,
      width: other.width,
      height: other.height,
      padding: other.padding,
      mainAxisAlignment: other.mainAxisAlignment,
      crossAxisAlignment: other.crossAxisAlignment,
      longPressDuration: other.longPressDuration,
      hoverStrategies: other.hoverStrategies,
    );
  }

  TwixButtonTheme copyWith({
    bool? applyIconColorFilter,
    MouseCursor? cursor,
    MouseCursor? disabledCursor,
    Color? backgroundColor,
    Color? hoverBackgroundColor,
    Color? foregroundColor,
    Color? hoverForegroundColor,
    Color? pressedBackgroundColor,
    Color? pressedForegroundColor,
    List<BoxShadow>? shadows,
    Gradient? gradient,
    TextDecoration? textDecoration,
    TextDecoration? hoverTextDecoration,
    TwixDecoration? decoration,
    double? width,
    double? height,
    EdgeInsets? padding,
    MainAxisAlignment? mainAxisAlignment,
    CrossAxisAlignment? crossAxisAlignment,
    Duration? longPressDuration,
    TwixHoverStrategies? hoverStrategies,
  }) {
    return TwixButtonTheme(
      applyIconColorFilter: applyIconColorFilter ?? this.applyIconColorFilter,
      cursor: cursor ?? this.cursor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      hoverBackgroundColor: hoverBackgroundColor ?? this.hoverBackgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      hoverForegroundColor: hoverForegroundColor ?? this.hoverForegroundColor,
      pressedBackgroundColor: pressedBackgroundColor ?? this.pressedBackgroundColor,
      pressedForegroundColor: pressedForegroundColor ?? this.pressedForegroundColor,
      shadows: shadows ?? this.shadows,
      gradient: gradient ?? this.gradient,
      textDecoration: textDecoration ?? this.textDecoration,
      hoverTextDecoration: hoverTextDecoration ?? this.hoverTextDecoration,
      decoration: decoration ?? this.decoration,
      width: width ?? this.width,
      height: height ?? this.height,
      padding: padding ?? this.padding,
      mainAxisAlignment: mainAxisAlignment ?? this.mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment ?? this.crossAxisAlignment,
      longPressDuration: longPressDuration ?? this.longPressDuration,
      hoverStrategies: hoverStrategies ?? this.hoverStrategies,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TwixButtonTheme &&
        other.applyIconColorFilter == applyIconColorFilter &&
        other.cursor == cursor &&
        other.backgroundColor == backgroundColor &&
        other.hoverBackgroundColor == hoverBackgroundColor &&
        other.foregroundColor == foregroundColor &&
        other.hoverForegroundColor == hoverForegroundColor &&
        other.pressedBackgroundColor == pressedBackgroundColor &&
        other.pressedForegroundColor == pressedForegroundColor &&
        listEquals(other.shadows, shadows) &&
        other.gradient == gradient &&
        other.textDecoration == textDecoration &&
        other.hoverTextDecoration == hoverTextDecoration &&
        other.decoration == decoration &&
        other.width == width &&
        other.height == height &&
        other.padding == padding &&
        other.mainAxisAlignment == mainAxisAlignment &&
        other.crossAxisAlignment == crossAxisAlignment &&
        other.longPressDuration == longPressDuration &&
        other.hoverStrategies == hoverStrategies;
  }

  @override
  int get hashCode {
    return applyIconColorFilter.hashCode ^
        cursor.hashCode ^
        backgroundColor.hashCode ^
        hoverBackgroundColor.hashCode ^
        foregroundColor.hashCode ^
        hoverForegroundColor.hashCode ^
        pressedBackgroundColor.hashCode ^
        pressedForegroundColor.hashCode ^
        shadows.hashCode ^
        gradient.hashCode ^
        textDecoration.hashCode ^
        hoverTextDecoration.hashCode ^
        decoration.hashCode ^
        width.hashCode ^
        height.hashCode ^
        padding.hashCode ^
        mainAxisAlignment.hashCode ^
        crossAxisAlignment.hashCode ^
        longPressDuration.hashCode ^
        hoverStrategies.hashCode;
  }
}
