import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:twix_ui/src/theme/widget_theme/decorator.dart';

@immutable
class TwixCheckboxTheme {
  const TwixCheckboxTheme({
    this.merge = true,
    this.color,
    this.duration,
    this.decoration,
    this.size,
    this.padding,
  });

  final bool merge;
  final Color? color;
  final double? size;
  final Duration? duration;
  final TwixDecoration? decoration;
  final EdgeInsets? padding;

  static TwixCheckboxTheme lerp(
    TwixCheckboxTheme a,
    TwixCheckboxTheme b,
    double t,
  ) {
    if (identical(a, b)) return a;
    return TwixCheckboxTheme(
      merge: b.merge,
      color: Color.lerp(a.color, b.color, t),
      duration: b.duration,
      decoration: TwixDecoration.lerp(a.decoration, b.decoration, t),
      size: lerpDouble(a.size, b.size, t),
      padding: EdgeInsets.lerp(a.padding, b.padding, t),
    );
  }

  TwixCheckboxTheme mergeWith(TwixCheckboxTheme? other) {
    if (other == null) return this;
    if (!other.merge) return other;
    return copyWith(
      color: other.color,
      duration: other.duration,
      decoration: decoration?.mergeWith(other.decoration) ?? other.decoration,
      size: other.size,
      padding: other.padding,
    );
  }

  TwixCheckboxTheme copyWith({
    bool? merge,
    Color? color,
    double? size,
    Duration? duration,
    TwixDecoration? decoration,
    EdgeInsets? padding,
  }) {
    return TwixCheckboxTheme(
      merge: merge ?? this.merge,
      duration: duration ?? this.duration,
      decoration: decoration ?? this.decoration,
      size: size ?? this.size,
      color: color ?? this.color,
      padding: padding ?? this.padding,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TwixCheckboxTheme &&
        other.merge == merge &&
        other.color == color &&
        other.size == size &&
        other.duration == duration &&
        other.decoration == decoration &&
        other.padding == padding;
  }

  @override
  int get hashCode {
    return merge.hashCode ^ color.hashCode ^ size.hashCode ^ duration.hashCode ^ decoration.hashCode ^ padding.hashCode;
  }
}
