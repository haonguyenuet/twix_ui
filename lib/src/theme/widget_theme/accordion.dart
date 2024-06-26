import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:twix_ui/src/widgets/image.dart';

@immutable
class TwixAccordionTheme {
  const TwixAccordionTheme({
    this.merge = true,
    this.iconSrc,
    this.iconEffects,
    this.padding,
    this.showUnderlineTitleOnHover = true,
    this.titleStyle,
    this.curve,
    this.duration,
    this.maintainState,
    this.effects,
  });

  final bool merge;
  final TwixIconImageSrc? iconSrc;
  final List<Effect<dynamic>>? iconEffects;
  final EdgeInsets? padding;
  final bool showUnderlineTitleOnHover;
  final TextStyle? titleStyle;
  final Curve? curve;
  final Duration? duration;
  final bool? maintainState;
  final List<Effect<dynamic>>? effects;

  static TwixAccordionTheme lerp(
    TwixAccordionTheme a,
    TwixAccordionTheme b,
    double t,
  ) {
    if (identical(a, b)) return a;
    return TwixAccordionTheme(
      merge: t < 0.5 ? a.merge : b.merge,
      iconSrc: t < 0.5 ? a.iconSrc : b.iconSrc,
      iconEffects: t < 0.5 ? a.iconEffects : b.iconEffects,
      padding: EdgeInsets.lerp(a.padding, b.padding, t),
      showUnderlineTitleOnHover: t < 0.5 ? a.showUnderlineTitleOnHover : b.showUnderlineTitleOnHover,
      titleStyle: TextStyle.lerp(a.titleStyle, b.titleStyle, t),
      curve: t < 0.5 ? a.curve : b.curve,
      duration: t < 0.5 ? a.duration : b.duration,
      maintainState: t < 0.5 ? a.maintainState : b.maintainState,
      effects: t < 0.5 ? a.effects : b.effects,
    );
  }

  TwixAccordionTheme mergeWith(TwixAccordionTheme? other) {
    if (other == null) return this;
    if (!other.merge) return other;
    return copyWith(
      iconSrc: other.iconSrc,
      iconEffects: other.iconEffects,
      padding: other.padding,
      underlineTitleOnHover: other.showUnderlineTitleOnHover,
      titleStyle: other.titleStyle,
      curve: other.curve,
      duration: other.duration,
      maintainState: other.maintainState,
      effects: other.effects,
    );
  }

  TwixAccordionTheme copyWith({
    bool? merge,
    TwixIconImageSrc? iconSrc,
    List<Effect<dynamic>>? iconEffects,
    EdgeInsets? padding,
    bool? underlineTitleOnHover,
    TextStyle? titleStyle,
    Curve? curve,
    Duration? duration,
    bool? maintainState,
    List<Effect<dynamic>>? effects,
  }) {
    return TwixAccordionTheme(
      merge: merge ?? this.merge,
      iconSrc: iconSrc ?? this.iconSrc,
      iconEffects: iconEffects ?? this.iconEffects,
      padding: padding ?? this.padding,
      showUnderlineTitleOnHover: underlineTitleOnHover ?? this.showUnderlineTitleOnHover,
      titleStyle: titleStyle ?? this.titleStyle,
      curve: curve ?? this.curve,
      duration: duration ?? this.duration,
      maintainState: maintainState ?? this.maintainState,
      effects: effects ?? this.effects,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TwixAccordionTheme &&
        other.merge == merge &&
        other.iconSrc == iconSrc &&
        listEquals(other.iconEffects, iconEffects) &&
        other.padding == padding &&
        other.showUnderlineTitleOnHover == showUnderlineTitleOnHover &&
        other.titleStyle == titleStyle &&
        other.curve == curve &&
        other.duration == duration &&
        other.maintainState == maintainState &&
        listEquals(other.effects, effects);
  }

  @override
  int get hashCode {
    return merge.hashCode ^
        iconSrc.hashCode ^
        iconEffects.hashCode ^
        padding.hashCode ^
        showUnderlineTitleOnHover.hashCode ^
        titleStyle.hashCode ^
        curve.hashCode ^
        duration.hashCode ^
        maintainState.hashCode ^
        effects.hashCode;
  }
}
