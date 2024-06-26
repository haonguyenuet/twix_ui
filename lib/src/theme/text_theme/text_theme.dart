import 'package:flutter/material.dart';
import 'package:twix_ui/src/theme/text_theme/typography_default.dart';

@immutable
class TwixTextTheme {
  factory TwixTextTheme({
    TextStyle? displayLarge,
    TextStyle? displayMedium,
    TextStyle? displaySmall,
    TextStyle? headlineLarge,
    TextStyle? headlineMedium,
    TextStyle? headlineSmall,
    TextStyle? titleLarge,
    TextStyle? titleMedium,
    TextStyle? titleSmall,
    TextStyle? bodyLarge,
    TextStyle? bodyMedium,
    TextStyle? bodySmall,
    TextStyle? labelLarge,
    TextStyle? labelMedium,
    TextStyle? labelSmall,
    String? family,
    String? package,
  }) {
    var effectiveFamily = family ?? kDefaultFontFamily;
    if (package != null && package.isNotEmpty) {
      effectiveFamily = 'packages/$package/$effectiveFamily';
    }
    return TwixTextTheme.custom(
      displayLarge: displayLarge ?? TwixTypographyDefault.displayLarge(family: effectiveFamily),
      displayMedium: displayMedium ?? TwixTypographyDefault.displayMedium(family: effectiveFamily),
      displaySmall: displaySmall ?? TwixTypographyDefault.displaySmall(family: effectiveFamily),
      headlineLarge: headlineLarge ?? TwixTypographyDefault.headlineLarge(family: effectiveFamily),
      headlineMedium: headlineMedium ?? TwixTypographyDefault.headlineMedium(family: effectiveFamily),
      headlineSmall: headlineSmall ?? TwixTypographyDefault.headlineSmall(family: effectiveFamily),
      titleLarge: titleLarge ?? TwixTypographyDefault.titleLarge(family: effectiveFamily),
      titleMedium: titleMedium ?? TwixTypographyDefault.titleMedium(family: effectiveFamily),
      titleSmall: titleSmall ?? TwixTypographyDefault.titleSmall(family: effectiveFamily),
      bodyLarge: bodyLarge ?? TwixTypographyDefault.bodyLarge(family: effectiveFamily),
      bodyMedium: bodyMedium ?? TwixTypographyDefault.bodyMedium(family: effectiveFamily),
      bodySmall: bodySmall ?? TwixTypographyDefault.bodySmall(family: effectiveFamily),
      labelLarge: labelLarge ?? TwixTypographyDefault.labelLarge(family: effectiveFamily),
      labelMedium: labelMedium ?? TwixTypographyDefault.labelMedium(family: effectiveFamily),
      labelSmall: labelSmall ?? TwixTypographyDefault.labelSmall(family: effectiveFamily),
      family: effectiveFamily,
    );
  }

  const TwixTextTheme.custom({
    required this.displayLarge,
    required this.displayMedium,
    required this.displaySmall,
    required this.headlineLarge,
    required this.headlineMedium,
    required this.headlineSmall,
    required this.titleLarge,
    required this.titleMedium,
    required this.titleSmall,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
    required this.labelLarge,
    required this.labelMedium,
    required this.labelSmall,
    required this.family,
    this.merge = true,
  });

  final TextStyle displayLarge;
  final TextStyle displayMedium;
  final TextStyle displaySmall;
  final TextStyle headlineLarge;
  final TextStyle headlineMedium;
  final TextStyle headlineSmall;
  final TextStyle titleLarge;
  final TextStyle titleMedium;
  final TextStyle titleSmall;
  final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle bodySmall;
  final TextStyle labelLarge;
  final TextStyle labelMedium;
  final TextStyle labelSmall;

  /// The font family of the theme.
  final String family;
  final bool merge;

  static TwixTextTheme lerp(
    TwixTextTheme? a,
    TwixTextTheme? b,
    double t,
  ) {
    if (identical(a, b) && a != null) {
      return a;
    }
    return TwixTextTheme.custom(
      displayLarge: TextStyle.lerp(a?.displayLarge, b?.displayLarge, t)!,
      displayMedium: TextStyle.lerp(a?.displayMedium, b?.displayMedium, t)!,
      displaySmall: TextStyle.lerp(a?.displaySmall, b?.displaySmall, t)!,
      headlineLarge: TextStyle.lerp(a?.headlineLarge, b?.headlineLarge, t)!,
      headlineMedium: TextStyle.lerp(a?.headlineMedium, b?.headlineMedium, t)!,
      headlineSmall: TextStyle.lerp(a?.headlineSmall, b?.headlineSmall, t)!,
      titleLarge: TextStyle.lerp(a?.titleLarge, b?.titleLarge, t)!,
      titleMedium: TextStyle.lerp(a?.titleMedium, b?.titleMedium, t)!,
      titleSmall: TextStyle.lerp(a?.titleSmall, b?.titleSmall, t)!,
      bodyLarge: TextStyle.lerp(a?.bodyLarge, b?.bodyLarge, t)!,
      bodyMedium: TextStyle.lerp(a?.bodyMedium, b?.bodyMedium, t)!,
      bodySmall: TextStyle.lerp(a?.bodySmall, b?.bodySmall, t)!,
      labelLarge: TextStyle.lerp(a?.labelLarge, b?.labelLarge, t)!,
      labelMedium: TextStyle.lerp(a?.labelMedium, b?.labelMedium, t)!,
      labelSmall: TextStyle.lerp(a?.labelSmall, b?.labelSmall, t)!,
      family: b?.family ?? '',
    );
  }

  TwixTextTheme mergeWith(TwixTextTheme? other) {
    if (other == null) return this;
    if (!other.merge) return other;

    return copyWith(
      displayLarge: displayLarge.merge(other.displayLarge),
      displayMedium: displayMedium.merge(other.displayMedium),
      displaySmall: displaySmall.merge(other.displaySmall),
      headlineLarge: headlineLarge.merge(other.headlineLarge),
      headlineMedium: headlineMedium.merge(other.headlineMedium),
      headlineSmall: headlineSmall.merge(other.headlineSmall),
      titleLarge: titleLarge.merge(other.titleLarge),
      titleMedium: titleMedium.merge(other.titleMedium),
      titleSmall: titleSmall.merge(other.titleSmall),
      bodyLarge: bodyLarge.merge(other.bodyLarge),
      bodyMedium: bodyMedium.merge(other.bodyMedium),
      bodySmall: bodySmall.merge(other.bodySmall),
      labelLarge: labelLarge.merge(other.labelLarge),
      labelMedium: labelMedium.merge(other.labelMedium),
      labelSmall: labelSmall.merge(other.labelSmall),
      family: other.family,
    );
  }

  TwixTextTheme copyWith({
    TextStyle? displayLarge,
    TextStyle? displayMedium,
    TextStyle? displaySmall,
    TextStyle? headlineLarge,
    TextStyle? headlineMedium,
    TextStyle? headlineSmall,
    TextStyle? titleLarge,
    TextStyle? titleMedium,
    TextStyle? titleSmall,
    TextStyle? bodyLarge,
    TextStyle? bodyMedium,
    TextStyle? bodySmall,
    TextStyle? labelLarge,
    TextStyle? labelMedium,
    TextStyle? labelSmall,
    String? family,
    String? package,
  }) {
    var effectiveFamily = family ?? kDefaultFontFamily;
    if (package != null && package != '') {
      effectiveFamily = 'packages/$package/$effectiveFamily';
    }

    return TwixTextTheme.custom(
      displayLarge: displayLarge ?? TwixTypographyDefault.displayLarge(family: effectiveFamily),
      displayMedium: displayMedium ?? TwixTypographyDefault.displayMedium(family: effectiveFamily),
      displaySmall: displaySmall ?? TwixTypographyDefault.displaySmall(family: effectiveFamily),
      headlineLarge: headlineLarge ?? TwixTypographyDefault.headlineLarge(family: effectiveFamily),
      headlineMedium: headlineMedium ?? TwixTypographyDefault.headlineMedium(family: effectiveFamily),
      headlineSmall: headlineSmall ?? TwixTypographyDefault.headlineSmall(family: effectiveFamily),
      titleLarge: titleLarge ?? TwixTypographyDefault.titleLarge(family: effectiveFamily),
      titleMedium: titleMedium ?? TwixTypographyDefault.titleMedium(family: effectiveFamily),
      titleSmall: titleSmall ?? TwixTypographyDefault.titleSmall(family: effectiveFamily),
      bodyLarge: bodyLarge ?? TwixTypographyDefault.bodyLarge(family: effectiveFamily),
      bodyMedium: bodyMedium ?? TwixTypographyDefault.bodyMedium(family: effectiveFamily),
      bodySmall: bodySmall ?? TwixTypographyDefault.bodySmall(family: effectiveFamily),
      labelLarge: labelLarge ?? TwixTypographyDefault.labelLarge(family: effectiveFamily),
      labelMedium: labelMedium ?? TwixTypographyDefault.labelMedium(family: effectiveFamily),
      labelSmall: labelSmall ?? TwixTypographyDefault.labelSmall(family: effectiveFamily),
      family: effectiveFamily,
      merge: merge,
    );
  }

  TwixTextTheme apply({
    String? family,
    String? package,
    double fontSizeFactor = 1.0,
    double fontSizeDelta = 0.0,
    Color? displayColor,
    Color? headlineColor,
    Color? titleColor,
    Color? bodyColor,
    Color? labelColor,
    Color? decorationColor,
    TextDecoration? decoration,
    TextDecorationStyle? decorationStyle,
  }) {
    final effectiveFamily = family ?? this.family;
    return TwixTextTheme.custom(
      merge: merge,
      family: effectiveFamily,
      displayLarge: displayLarge.apply(
        fontFamily: effectiveFamily,
        package: package,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
        color: displayColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
      ),
      displayMedium: displayMedium.apply(
        fontFamily: effectiveFamily,
        package: package,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
        color: displayColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
      ),
      displaySmall: displaySmall.apply(
        fontFamily: effectiveFamily,
        package: package,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
        color: displayColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
      ),
      headlineLarge: headlineLarge.apply(
        fontFamily: effectiveFamily,
        package: package,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
        color: headlineColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
      ),
      headlineMedium: headlineMedium.apply(
        fontFamily: effectiveFamily,
        package: package,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
        color: headlineColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
      ),
      headlineSmall: headlineSmall.apply(
        fontFamily: effectiveFamily,
        package: package,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
        color: headlineColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
      ),
      titleLarge: titleLarge.apply(
        fontFamily: effectiveFamily,
        package: package,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
        color: titleColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
      ),
      titleMedium: titleMedium.apply(
        fontFamily: effectiveFamily,
        package: package,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
        color: titleColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
      ),
      titleSmall: titleSmall.apply(
        fontFamily: effectiveFamily,
        package: package,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
        color: titleColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
      ),
      bodyLarge: bodyLarge.apply(
        fontFamily: effectiveFamily,
        package: package,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
        color: bodyColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
      ),
      bodyMedium: bodyMedium.apply(
        fontFamily: effectiveFamily,
        package: package,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        color: bodyColor,
      ),
      bodySmall: bodySmall.apply(
        fontFamily: effectiveFamily,
        package: package,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        color: bodyColor,
      ),
      labelLarge: labelLarge.apply(
        fontFamily: effectiveFamily,
        package: package,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
        color: labelColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
      ),
      labelMedium: labelMedium.apply(
        fontFamily: effectiveFamily,
        package: package,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
        color: labelColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
      ),
      labelSmall: labelSmall.apply(
        fontFamily: effectiveFamily,
        package: package,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
        color: labelColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
      ),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is TwixTextTheme &&
        other.displayLarge == displayLarge &&
        other.displayMedium == displayMedium &&
        other.displaySmall == displaySmall &&
        other.headlineLarge == headlineLarge &&
        other.headlineMedium == headlineMedium &&
        other.headlineSmall == headlineSmall &&
        other.titleLarge == titleLarge &&
        other.titleMedium == titleMedium &&
        other.titleSmall == titleSmall &&
        other.bodyLarge == bodyLarge &&
        other.bodyMedium == bodyMedium &&
        other.bodySmall == bodySmall &&
        other.labelLarge == labelLarge &&
        other.labelMedium == labelMedium &&
        other.labelSmall == labelSmall &&
        other.family == family;
  }

  @override
  int get hashCode {
    return Object.hash(
      displayLarge,
      displayMedium,
      displaySmall,
      headlineLarge,
      headlineMedium,
      headlineSmall,
      titleLarge,
      titleMedium,
      titleSmall,
      bodyLarge,
      bodyMedium,
      bodySmall,
      labelLarge,
      labelMedium,
      labelSmall,
      family,
      merge,
    );
  }
}
