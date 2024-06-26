import 'package:flutter/widgets.dart';

const kDefaultFontFamily = 'Geist';

// https://m3.material.io/styles/typography/type-scale-tokens
abstract class TwixTypographyDefault {
  static TextStyle displayLarge({
    required String family,
  }) {
    return TextStyle(
      fontFamily: family,
      fontWeight: FontWeight.w400,
      fontSize: 57,
      letterSpacing: -0.25,
      height: 64 / 48,
      inherit: false,
      decoration: TextDecoration.none,
      fontStyle: FontStyle.normal,
      textBaseline: TextBaseline.alphabetic,
      leadingDistribution: TextLeadingDistribution.even,
    );
  }

  static TextStyle displayMedium({
    required String family,
  }) {
    return TextStyle(
      fontFamily: family,
      fontWeight: FontWeight.w400,
      fontSize: 45,
      letterSpacing: 0,
      height: 52 / 45,
      inherit: false,
      decoration: TextDecoration.none,
      fontStyle: FontStyle.normal,
      textBaseline: TextBaseline.alphabetic,
      leadingDistribution: TextLeadingDistribution.even,
    );
  }

  static TextStyle displaySmall({
    required String family,
  }) {
    return TextStyle(
      fontFamily: family,
      fontWeight: FontWeight.w400,
      fontSize: 36,
      letterSpacing: 0,
      height: 44 / 36,
      inherit: false,
      decoration: TextDecoration.none,
      fontStyle: FontStyle.normal,
      textBaseline: TextBaseline.alphabetic,
      leadingDistribution: TextLeadingDistribution.even,
    );
  }

  static TextStyle headlineLarge({
    required String family,
  }) {
    return TextStyle(
      fontFamily: family,
      fontWeight: FontWeight.w400,
      fontSize: 32,
      letterSpacing: 0,
      height: 40 / 32,
      inherit: false,
      decoration: TextDecoration.none,
      fontStyle: FontStyle.normal,
      textBaseline: TextBaseline.alphabetic,
      leadingDistribution: TextLeadingDistribution.even,
    );
  }

  static TextStyle headlineMedium({
    required String family,
  }) {
    return TextStyle(
      fontFamily: family,
      fontWeight: FontWeight.w400,
      fontSize: 28,
      letterSpacing: 0,
      height: 36 / 28,
      inherit: false,
      decoration: TextDecoration.none,
      fontStyle: FontStyle.normal,
      textBaseline: TextBaseline.alphabetic,
      leadingDistribution: TextLeadingDistribution.even,
    );
  }

  static TextStyle headlineSmall({
    required String family,
  }) {
    return TextStyle(
      fontFamily: family,
      fontWeight: FontWeight.w400,
      fontSize: 24,
      letterSpacing: 0,
      height: 32 / 24,
      inherit: false,
      decoration: TextDecoration.none,
      fontStyle: FontStyle.normal,
      textBaseline: TextBaseline.alphabetic,
      leadingDistribution: TextLeadingDistribution.even,
    );
  }

  static TextStyle titleLarge({
    required String family,
  }) {
    return TextStyle(
      fontFamily: family,
      fontWeight: FontWeight.w700,
      fontSize: 22,
      letterSpacing: 0,
      height: 30 / 22,
      inherit: false,
      decoration: TextDecoration.none,
      fontStyle: FontStyle.normal,
      textBaseline: TextBaseline.alphabetic,
      leadingDistribution: TextLeadingDistribution.even,
    );
  }

  static TextStyle titleMedium({
    required String family,
  }) {
    return TextStyle(
      fontFamily: family,
      fontWeight: FontWeight.w700,
      fontSize: 16,
      letterSpacing: 0.15,
      height: 24 / 16,
      inherit: false,
      decoration: TextDecoration.none,
      fontStyle: FontStyle.normal,
      textBaseline: TextBaseline.alphabetic,
      leadingDistribution: TextLeadingDistribution.even,
    );
  }

  static TextStyle titleSmall({
    required String family,
  }) {
    return TextStyle(
      fontFamily: family,
      fontWeight: FontWeight.w500,
      fontSize: 14,
      letterSpacing: 0.1,
      height: 20 / 14,
      inherit: false,
      decoration: TextDecoration.none,
      fontStyle: FontStyle.normal,
      textBaseline: TextBaseline.alphabetic,
      leadingDistribution: TextLeadingDistribution.even,
    );
  }

  static TextStyle bodyLarge({
    required String family,
  }) {
    return TextStyle(
      fontFamily: family,
      fontWeight: FontWeight.w400,
      fontSize: 16,
      letterSpacing: 0.5,
      height: 24 / 16,
      inherit: false,
      decoration: TextDecoration.none,
      fontStyle: FontStyle.normal,
      textBaseline: TextBaseline.alphabetic,
      leadingDistribution: TextLeadingDistribution.even,
    );
  }

  static TextStyle bodyMedium({
    required String family,
  }) {
    return TextStyle(
      fontFamily: family,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      letterSpacing: 0.25,
      height: 20 / 14,
      inherit: false,
      decoration: TextDecoration.none,
      fontStyle: FontStyle.normal,
      textBaseline: TextBaseline.alphabetic,
      leadingDistribution: TextLeadingDistribution.even,
    );
  }

  static TextStyle bodySmall({
    required String family,
  }) {
    return TextStyle(
      fontFamily: family,
      fontWeight: FontWeight.w400,
      fontSize: 12,
      letterSpacing: 0.4,
      height: 16 / 12,
      inherit: false,
      decoration: TextDecoration.none,
      fontStyle: FontStyle.normal,
      textBaseline: TextBaseline.alphabetic,
      leadingDistribution: TextLeadingDistribution.even,
    );
  }

  static TextStyle labelLarge({
    required String family,
  }) {
    return TextStyle(
      fontFamily: family,
      fontWeight: FontWeight.w700,
      fontSize: 14,
      letterSpacing: 0.1,
      height: 20 / 14,
      inherit: false,
      decoration: TextDecoration.none,
      fontStyle: FontStyle.normal,
      textBaseline: TextBaseline.alphabetic,
      leadingDistribution: TextLeadingDistribution.even,
    );
  }

  static TextStyle labelMedium({
    required String family,
  }) {
    return TextStyle(
      fontFamily: family,
      fontWeight: FontWeight.w700,
      fontSize: 12,
      letterSpacing: 0.5,
      height: 16 / 12,
      inherit: false,
      decoration: TextDecoration.none,
      fontStyle: FontStyle.normal,
      textBaseline: TextBaseline.alphabetic,
      leadingDistribution: TextLeadingDistribution.even,
    );
  }

  static TextStyle labelSmall({
    required String family,
  }) {
    return TextStyle(
      fontFamily: family,
      fontWeight: FontWeight.w500,
      fontSize: 11,
      letterSpacing: 0.5,
      height: 16 / 11,
      inherit: false,
      decoration: TextDecoration.none,
      fontStyle: FontStyle.normal,
      textBaseline: TextBaseline.alphabetic,
      leadingDistribution: TextLeadingDistribution.even,
    );
  }
}
