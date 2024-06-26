import 'package:flutter/widgets.dart';
import 'package:twix_ui/src/theme/widget_theme/decorator.dart';

class TwixInputTheme {
  const TwixInputTheme({
    this.merge = true,
    this.decoration,
    this.padding,
    this.backgroundColor,
    this.style,
    this.placeholderStyle,
    this.placeholderAlignment,
    this.inputPadding,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
  });

  final bool merge;
  final TwixDecoration? decoration;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final TextStyle? style;
  final TextStyle? placeholderStyle;
  final Alignment? placeholderAlignment;
  final EdgeInsets? inputPadding;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;

  static TwixInputTheme lerp(
    TwixInputTheme a,
    TwixInputTheme b,
    double t,
  ) {
    if (identical(a, b)) return a;
    return TwixInputTheme(
      merge: b.merge,
      decoration: TwixDecoration.lerp(a.decoration, b.decoration, t),
      padding: EdgeInsets.lerp(a.padding, b.padding, t),
      backgroundColor: Color.lerp(a.backgroundColor, b.backgroundColor, t),
      style: TextStyle.lerp(a.style, b.style, t),
      placeholderStyle: TextStyle.lerp(a.placeholderStyle, b.placeholderStyle, t),
      inputPadding: EdgeInsets.lerp(a.inputPadding, b.inputPadding, t),
      mainAxisAlignment: t < 0.5 ? a.mainAxisAlignment : b.mainAxisAlignment,
      crossAxisAlignment: t < 0.5 ? a.crossAxisAlignment : b.crossAxisAlignment,
    );
  }

  TwixInputTheme copyWith({
    bool? merge,
    TwixDecoration? decoration,
    EdgeInsets? padding,
    Color? backgroundColor,
    TextStyle? style,
    TextStyle? placeholderStyle,
    EdgeInsets? inputPadding,
    MainAxisAlignment? mainAxisAlignment,
    CrossAxisAlignment? crossAxisAlignment,
  }) {
    return TwixInputTheme(
      merge: merge ?? this.merge,
      decoration: decoration ?? this.decoration,
      padding: padding ?? this.padding,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      style: style ?? this.style,
      placeholderStyle: placeholderStyle ?? this.placeholderStyle,
      inputPadding: inputPadding ?? this.inputPadding,
      mainAxisAlignment: mainAxisAlignment ?? this.mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment ?? this.crossAxisAlignment,
    );
  }

  TwixInputTheme mergeWith(TwixInputTheme? other) {
    if (other == null) return this;
    if (!other.merge) return other;
    return copyWith(
      decoration: decoration?.mergeWith(other.decoration) ?? other.decoration,
      padding: other.padding,
      backgroundColor: other.backgroundColor,
      style: other.style,
      placeholderStyle: other.placeholderStyle,
      inputPadding: other.inputPadding,
      mainAxisAlignment: other.mainAxisAlignment,
      crossAxisAlignment: other.crossAxisAlignment,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TwixInputTheme &&
        other.merge == merge &&
        other.decoration == decoration &&
        other.padding == padding &&
        other.backgroundColor == backgroundColor &&
        other.style == style &&
        other.placeholderStyle == placeholderStyle &&
        other.inputPadding == inputPadding &&
        other.mainAxisAlignment == mainAxisAlignment &&
        other.crossAxisAlignment == crossAxisAlignment;
  }

  @override
  int get hashCode {
    return merge.hashCode ^
        decoration.hashCode ^
        padding.hashCode ^
        backgroundColor.hashCode ^
        style.hashCode ^
        placeholderStyle.hashCode ^
        inputPadding.hashCode ^
        mainAxisAlignment.hashCode ^
        crossAxisAlignment.hashCode;
  }
}
