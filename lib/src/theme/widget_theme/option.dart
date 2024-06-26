import 'package:flutter/widgets.dart';

class TwixOptionTheme {
  const TwixOptionTheme({
    this.merge = true,
    this.hoveredBackgroundColor,
    this.padding,
    this.radius,
  });

  final bool merge;
  final Color? hoveredBackgroundColor;
  final EdgeInsets? padding;
  final BorderRadius? radius;

  static TwixOptionTheme lerp(
    TwixOptionTheme a,
    TwixOptionTheme b,
    double t,
  ) {
    if (identical(a, b)) return a;
    return TwixOptionTheme(
      merge: b.merge,
      hoveredBackgroundColor: Color.lerp(a.hoveredBackgroundColor, b.hoveredBackgroundColor, t),
      padding: EdgeInsets.lerp(a.padding, b.padding, t),
      radius: BorderRadius.lerp(a.radius, b.radius, t),
    );
  }

  TwixOptionTheme mergeWith(TwixOptionTheme? other) {
    if (other == null) return this;
    if (!other.merge) return other;
    return copyWith(
      hoveredBackgroundColor: other.hoveredBackgroundColor,
      padding: other.padding,
      radius: other.radius,
    );
  }

  TwixOptionTheme copyWith({
    bool? merge,
    Color? hoveredBackgroundColor,
    EdgeInsets? padding,
    BorderRadius? radius,
  }) {
    return TwixOptionTheme(
      merge: merge ?? this.merge,
      hoveredBackgroundColor: hoveredBackgroundColor ?? this.hoveredBackgroundColor,
      padding: padding ?? this.padding,
      radius: radius ?? this.radius,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TwixOptionTheme &&
        other.merge == merge &&
        other.hoveredBackgroundColor == hoveredBackgroundColor &&
        other.padding == padding &&
        other.radius == radius;
  }

  @override
  int get hashCode {
    return merge.hashCode ^ hoveredBackgroundColor.hashCode ^ padding.hashCode ^ radius.hashCode;
  }
}
