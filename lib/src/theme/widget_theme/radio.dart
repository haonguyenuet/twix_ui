import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:twix_ui/src/theme/widget_theme/decorator.dart';

class TwixRadioTheme {
  const TwixRadioTheme({
    this.merge = true,
    this.color,
    this.duration,
    this.decoration,
    this.size,
    this.padding,
    this.circleSize,
  });

  final bool merge;
  final Color? color;
  final double? size;
  final Duration? duration;
  final TwixDecoration? decoration;
  final EdgeInsets? padding;
  final double? circleSize;

  static TwixRadioTheme lerp(
    TwixRadioTheme a,
    TwixRadioTheme b,
    double t,
  ) {
    if (identical(a, b)) return a;
    return TwixRadioTheme(
      merge: b.merge,
      color: Color.lerp(a.color, b.color, t),
      duration: b.duration,
      decoration: TwixDecoration.lerp(a.decoration, b.decoration, t),
      size: lerpDouble(a.size, b.size, t),
      padding: EdgeInsets.lerp(a.padding, b.padding, t),
      circleSize: lerpDouble(a.circleSize, b.circleSize, t),
    );
  }

  TwixRadioTheme mergeWith(TwixRadioTheme? other) {
    if (other == null) return this;
    if (!other.merge) return other;
    return copyWith(
      color: other.color,
      duration: other.duration,
      decoration: decoration?.mergeWith(other.decoration) ?? other.decoration,
      size: other.size,
      padding: other.padding,
      circleSize: other.circleSize,
    );
  }

  TwixRadioTheme copyWith({
    bool? merge,
    Color? color,
    double? size,
    Duration? duration,
    TwixDecoration? decoration,
    EdgeInsets? padding,
    double? circleSize,
  }) {
    return TwixRadioTheme(
      merge: merge ?? this.merge,
      duration: duration ?? this.duration,
      decoration: decoration ?? this.decoration,
      size: size ?? this.size,
      color: color ?? this.color,
      padding: padding ?? this.padding,
      circleSize: circleSize ?? this.circleSize,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TwixRadioTheme &&
        other.merge == merge &&
        other.color == color &&
        other.size == size &&
        other.duration == duration &&
        other.decoration == decoration &&
        other.padding == padding &&
        other.circleSize == circleSize;
  }

  @override
  int get hashCode {
    return merge.hashCode ^
        color.hashCode ^
        size.hashCode ^
        duration.hashCode ^
        decoration.hashCode ^
        padding.hashCode ^
        circleSize.hashCode;
  }
}
