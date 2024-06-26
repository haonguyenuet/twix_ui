import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:twix_ui/src/theme/widget_theme/decorator.dart';
import 'package:twix_ui/src/widgets/portal.dart';

@immutable
class TwixPopoverTheme {
  const TwixPopoverTheme({
    this.merge = true,
    this.waitDuration,
    this.showDuration,
    this.effects,
    this.shadows,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    this.decoration,
    this.anchor = const TwixAnchorAuto(verticalOffset: 24, preferBelow: true),
  });

  final bool merge;

  final Duration? waitDuration;
  final Duration? showDuration;
  final List<Effect<dynamic>>? effects;
  final List<BoxShadow>? shadows;
  final EdgeInsetsGeometry padding;
  final TwixDecoration? decoration;
  final TwixAnchorBase anchor;

  static TwixPopoverTheme lerp(
    TwixPopoverTheme a,
    TwixPopoverTheme b,
    double t,
  ) {
    if (identical(a, b)) return a;
    return TwixPopoverTheme(
      merge: b.merge,
      waitDuration: b.waitDuration,
      showDuration: b.showDuration,
      effects: b.effects,
      shadows: b.shadows,
      padding: EdgeInsetsGeometry.lerp(a.padding, b.padding, t)!,
      decoration: TwixDecoration.lerp(a.decoration, b.decoration, t),
      anchor: b.anchor,
    );
  }

  TwixPopoverTheme copyWith({
    bool? merge,
    Duration? waitDuration,
    Duration? showDuration,
    List<Effect<dynamic>>? effects,
    List<BoxShadow>? shadows,
    EdgeInsetsGeometry? padding,
    TwixDecoration? decoration,
    TwixAnchorBase? anchor,
  }) {
    return TwixPopoverTheme(
      merge: merge ?? this.merge,
      waitDuration: waitDuration ?? this.waitDuration,
      showDuration: showDuration ?? this.showDuration,
      effects: effects ?? this.effects,
      shadows: shadows ?? this.shadows,
      padding: padding ?? this.padding,
      decoration: decoration ?? this.decoration,
      anchor: anchor ?? this.anchor,
    );
  }

  TwixPopoverTheme mergeWith(TwixPopoverTheme? other) {
    if (other == null) return this;
    if (!other.merge) return other;
    return copyWith(
      waitDuration: other.waitDuration,
      showDuration: other.showDuration,
      effects: other.effects,
      shadows: other.shadows,
      padding: other.padding,
      decoration: decoration?.mergeWith(other.decoration) ?? other.decoration,
      anchor: other.anchor,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TwixPopoverTheme &&
        other.merge == merge &&
        other.waitDuration == waitDuration &&
        other.showDuration == showDuration &&
        listEquals(other.effects, effects) &&
        listEquals(other.shadows, shadows) &&
        other.padding == padding &&
        other.decoration == decoration &&
        other.anchor == anchor;
  }

  @override
  int get hashCode {
    return merge.hashCode ^
        waitDuration.hashCode ^
        showDuration.hashCode ^
        effects.hashCode ^
        shadows.hashCode ^
        padding.hashCode ^
        decoration.hashCode ^
        anchor.hashCode;
  }
}
