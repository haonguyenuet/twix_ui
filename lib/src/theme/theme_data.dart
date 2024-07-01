import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:twix_ui/src/theme/color_scheme/base.dart';
import 'package:twix_ui/src/theme/color_scheme/collection.dart';
import 'package:twix_ui/src/theme/text_theme/text_theme.dart';
import 'package:twix_ui/src/theme/widget_theme/accordion.dart';
import 'package:twix_ui/src/theme/widget_theme/button.dart';
import 'package:twix_ui/src/theme/widget_theme/card.dart';
import 'package:twix_ui/src/theme/widget_theme/checkbox.dart';
import 'package:twix_ui/src/theme/widget_theme/decorator.dart';
import 'package:twix_ui/src/theme/widget_theme/dialog.dart';
import 'package:twix_ui/src/theme/widget_theme/input.dart';
import 'package:twix_ui/src/theme/widget_theme/option.dart';
import 'package:twix_ui/src/theme/widget_theme/popover.dart';
import 'package:twix_ui/src/theme/widget_theme/radio.dart';
import 'package:twix_ui/src/theme/widget_theme/select.dart';
import 'package:twix_ui/src/theme/widget_theme/sheet.dart';
import 'package:twix_ui/src/theme/widget_theme/theme_defaults.dart';
import 'package:twix_ui/src/theme/widget_theme/toast.dart';
import 'package:twix_ui/src/utils/gesture_detector.dart';
import 'package:twix_ui/src/utils/responsive.dart';

@immutable
class TwixThemeData {
  factory TwixThemeData({
    required Brightness brightness,
    TwixColorScheme? colorScheme,
    Iterable<ThemeExtension<dynamic>>? extensions,
    TwixButtonTheme? filledButtonTheme,
    TwixButtonTheme? outlineButtonTheme,
    TwixButtonTheme? iconButtonTheme,
    TwixButtonTheme? linkButtonTheme,
    BorderRadius? radius,
    TwixPopoverTheme? popoverTheme,
    TwixDecoration? decoration,
    TwixTextTheme? textTheme,
    double? disabledOpacity,
    TwixSelectTheme? selectTheme,
    TwixOptionTheme? optionTheme,
    TwixCardTheme? cardTheme,
    TwixCheckboxTheme? checkboxTheme,
    TwixInputTheme? inputTheme,
    TwixRadioTheme? radioTheme,
    TwixToastTheme? primaryToastTheme,
    TwixToastTheme? errorToastTheme,
    TwixBreakpoints? breakpoints,
    TwixDialogTheme? primaryDialogTheme,
    TwixDialogTheme? alertDialogTheme,
    TwixSheetTheme? sheetTheme,
    TwixAccordionTheme? accordionTheme,
    TwixHoverStrategies? hoverStrategies,
    bool? disableSecondaryBorder,
  }) {
    final effectiveColorScheme = colorScheme ?? const TwixColorSchemeCollection.light();
    final effectiveRadius = radius ?? const BorderRadius.all(Radius.circular(6));
    var effectiveTextTheme = TwixWidgetThemeDefault.textTheme().mergeWith(textTheme);
    effectiveTextTheme = effectiveTextTheme.copyWith(
      displayLarge: effectiveTextTheme.displayLarge.copyWith(
        color: effectiveTextTheme.displayLarge.color ?? effectiveColorScheme.foreground,
      ),
      displayMedium: effectiveTextTheme.displayMedium.copyWith(
        color: effectiveTextTheme.displayMedium.color ?? effectiveColorScheme.foreground,
      ),
      displaySmall: effectiveTextTheme.displaySmall.copyWith(
        color: effectiveTextTheme.displaySmall.color ?? effectiveColorScheme.foreground,
      ),
      headlineLarge: effectiveTextTheme.headlineLarge.copyWith(
        color: effectiveTextTheme.headlineLarge.color ?? effectiveColorScheme.foreground,
      ),
      headlineMedium: effectiveTextTheme.headlineMedium.copyWith(
        color: effectiveTextTheme.headlineMedium.color ?? effectiveColorScheme.foreground,
      ),
      headlineSmall: effectiveTextTheme.headlineSmall.copyWith(
        color: effectiveTextTheme.headlineSmall.color ?? effectiveColorScheme.foreground,
      ),
      titleLarge: effectiveTextTheme.titleLarge.copyWith(
        color: effectiveTextTheme.titleLarge.color ?? effectiveColorScheme.foreground,
      ),
      titleMedium: effectiveTextTheme.titleMedium.copyWith(
        color: effectiveTextTheme.titleMedium.color ?? effectiveColorScheme.foreground,
      ),
      titleSmall: effectiveTextTheme.titleSmall.copyWith(
        color: effectiveTextTheme.titleSmall.color ?? effectiveColorScheme.foreground,
      ),
      bodyLarge: effectiveTextTheme.bodyLarge.copyWith(
        color: effectiveTextTheme.bodyLarge.color ?? effectiveColorScheme.foreground,
      ),
      bodyMedium: effectiveTextTheme.bodyMedium.copyWith(
        color: effectiveTextTheme.bodyMedium.color ?? effectiveColorScheme.foreground,
      ),
      bodySmall: effectiveTextTheme.bodySmall.copyWith(
        color: effectiveTextTheme.bodySmall.color ?? effectiveColorScheme.mutedForeground,
      ),
      labelLarge: effectiveTextTheme.labelLarge.copyWith(
        color: effectiveTextTheme.labelLarge.color ?? effectiveColorScheme.mutedForeground,
      ),
      labelMedium: effectiveTextTheme.labelMedium.copyWith(
        color: effectiveTextTheme.labelMedium.color ?? effectiveColorScheme.foreground,
      ),
      labelSmall: effectiveTextTheme.labelSmall.copyWith(
        color: effectiveTextTheme.labelSmall.color ?? effectiveColorScheme.foreground,
      ),
    );
    final effectiveDisableSecondaryBorder = disableSecondaryBorder ?? false;
    return TwixThemeData._internal(
      colorScheme: effectiveColorScheme,
      brightness: brightness,
      extensions: extensions,
      filledButtonTheme: TwixWidgetThemeDefault.filledButtonTheme(
        colorScheme: effectiveColorScheme,
        radius: effectiveRadius,
      ).mergeWith(filledButtonTheme),
      outlineButtonTheme: TwixWidgetThemeDefault.outlineButtonTheme(
        colorScheme: effectiveColorScheme,
        radius: effectiveRadius,
      ).mergeWith(outlineButtonTheme),
      iconButtonTheme: TwixWidgetThemeDefault.iconButtonTheme(
        colorScheme: effectiveColorScheme,
        radius: effectiveRadius,
      ).mergeWith(iconButtonTheme),
      linkButtonTheme: TwixWidgetThemeDefault.linkButtonTheme(
        colorScheme: effectiveColorScheme,
      ).mergeWith(linkButtonTheme),
      radius: effectiveRadius,
      popoverTheme: TwixWidgetThemeDefault.popoverTheme(
        colorScheme: effectiveColorScheme,
        radius: effectiveRadius,
      ).mergeWith(popoverTheme),
      decoration: TwixWidgetThemeDefault.decorationTheme(
        colorScheme: effectiveColorScheme,
        radius: effectiveRadius,
        textTheme: effectiveTextTheme,
      ).mergeWith(decoration),
      textTheme: effectiveTextTheme,
      disabledOpacity: disabledOpacity ?? .5,
      selectTheme: TwixWidgetThemeDefault.selectTheme(
        colorScheme: effectiveColorScheme,
        radius: effectiveRadius,
      ).mergeWith(selectTheme),
      optionTheme: TwixWidgetThemeDefault.optionTheme(
        colorScheme: effectiveColorScheme,
      ).mergeWith(optionTheme),
      cardTheme: TwixWidgetThemeDefault.cardTheme(
        colorScheme: effectiveColorScheme,
      ).mergeWith(cardTheme),
      checkboxTheme: TwixWidgetThemeDefault.checkboxTheme(
        colorScheme: effectiveColorScheme,
        radius: effectiveRadius,
      ).mergeWith(checkboxTheme),
      inputTheme: TwixWidgetThemeDefault.inputTheme(
        colorScheme: effectiveColorScheme,
        radius: effectiveRadius,
        textTheme: effectiveTextTheme,
      ).mergeWith(inputTheme),
      radioTheme: TwixWidgetThemeDefault.radioTheme(
        colorScheme: effectiveColorScheme,
      ).mergeWith(radioTheme),
      primaryToastTheme: TwixWidgetThemeDefault.primaryToastTheme(
        colorScheme: effectiveColorScheme,
        radius: effectiveRadius,
        textTheme: effectiveTextTheme,
      ).mergeWith(primaryToastTheme),
      errorToastTheme: TwixWidgetThemeDefault.errorToastTheme(
        colorScheme: effectiveColorScheme,
        radius: effectiveRadius,
        textTheme: effectiveTextTheme,
      ).mergeWith(errorToastTheme),
      breakpoints: breakpoints ?? TwixBreakpoints(),
      primaryDialogTheme: TwixWidgetThemeDefault.primaryDialogTheme(
        colorScheme: effectiveColorScheme,
        textTheme: effectiveTextTheme,
        radius: effectiveRadius,
      ).mergeWith(primaryDialogTheme),
      alertDialogTheme: TwixWidgetThemeDefault.alertDialogTheme(
        colorScheme: effectiveColorScheme,
        textTheme: effectiveTextTheme,
        radius: effectiveRadius,
      ).mergeWith(alertDialogTheme),
      sheetTheme: TwixWidgetThemeDefault.sheetTheme(
        colorScheme: effectiveColorScheme,
        textTheme: effectiveTextTheme,
      ).mergeWith(sheetTheme),
      accordionTheme: TwixWidgetThemeDefault.accordionTheme(
        colorScheme: effectiveColorScheme,
        textTheme: effectiveTextTheme,
      ).mergeWith(accordionTheme),
      hoverStrategies: hoverStrategies ?? TwixWidgetThemeDefault.hoverStrategies(),
      disableSecondaryBorder: effectiveDisableSecondaryBorder,
    );
  }

  const TwixThemeData._internal({
    required this.colorScheme,
    required this.brightness,
    required this.extensions,
    required this.filledButtonTheme,
    required this.outlineButtonTheme,
    required this.iconButtonTheme,
    required this.linkButtonTheme,
    required this.radius,
    required this.popoverTheme,
    required this.decoration,
    required this.textTheme,
    required this.disabledOpacity,
    required this.selectTheme,
    required this.optionTheme,
    required this.cardTheme,
    required this.checkboxTheme,
    required this.inputTheme,
    required this.radioTheme,
    required this.primaryToastTheme,
    required this.errorToastTheme,
    required this.breakpoints,
    required this.primaryDialogTheme,
    required this.alertDialogTheme,
    required this.sheetTheme,
    required this.accordionTheme,
    required this.hoverStrategies,
    required this.disableSecondaryBorder,
  });

  final TwixColorScheme colorScheme;
  final Brightness brightness;
  final Iterable<ThemeExtension<dynamic>>? extensions;
  final TwixButtonTheme filledButtonTheme;
  final TwixButtonTheme outlineButtonTheme;
  final TwixButtonTheme iconButtonTheme;
  final TwixButtonTheme linkButtonTheme;
  final BorderRadius radius;
  final TwixPopoverTheme popoverTheme;
  final TwixDecoration decoration;
  final TwixTextTheme textTheme;
  final double disabledOpacity;
  final TwixSelectTheme selectTheme;
  final TwixOptionTheme optionTheme;
  final TwixCardTheme cardTheme;
  final TwixCheckboxTheme checkboxTheme;
  final TwixInputTheme inputTheme;
  final TwixRadioTheme radioTheme;
  final TwixToastTheme primaryToastTheme;
  final TwixToastTheme errorToastTheme;
  final TwixBreakpoints breakpoints;
  final TwixDialogTheme primaryDialogTheme;
  final TwixDialogTheme alertDialogTheme;
  final TwixSheetTheme sheetTheme;
  final TwixAccordionTheme accordionTheme;
  final TwixHoverStrategies hoverStrategies;
  final bool disableSecondaryBorder;

  static TwixThemeData lerp(TwixThemeData a, TwixThemeData b, double t) {
    if (identical(a, b)) {
      return a;
    }
    return TwixThemeData(
      colorScheme: TwixColorScheme.lerp(a.colorScheme, b.colorScheme, t),
      brightness: b.brightness,
      filledButtonTheme: TwixButtonTheme.lerp(a.filledButtonTheme, b.filledButtonTheme, t),
      outlineButtonTheme: TwixButtonTheme.lerp(a.outlineButtonTheme, b.outlineButtonTheme, t),
      iconButtonTheme: TwixButtonTheme.lerp(a.iconButtonTheme, b.iconButtonTheme, t),
      linkButtonTheme: TwixButtonTheme.lerp(a.linkButtonTheme, b.linkButtonTheme, t),
      radius: BorderRadius.lerp(a.radius, b.radius, t),
      popoverTheme: TwixPopoverTheme.lerp(a.popoverTheme, b.popoverTheme, t),
      decoration: TwixDecoration.lerp(a.decoration, b.decoration, t),
      textTheme: TwixTextTheme.lerp(a.textTheme, b.textTheme, t),
      disabledOpacity: lerpDouble(a.disabledOpacity, b.disabledOpacity, t),
      selectTheme: TwixSelectTheme.lerp(a.selectTheme, b.selectTheme, t),
      optionTheme: TwixOptionTheme.lerp(a.optionTheme, b.optionTheme, t),
      cardTheme: TwixCardTheme.lerp(a.cardTheme, b.cardTheme, t),
      checkboxTheme: TwixCheckboxTheme.lerp(a.checkboxTheme, b.checkboxTheme, t),
      inputTheme: TwixInputTheme.lerp(a.inputTheme, b.inputTheme, t),
      radioTheme: TwixRadioTheme.lerp(a.radioTheme, b.radioTheme, t),
      primaryToastTheme: TwixToastTheme.lerp(a.primaryToastTheme, b.primaryToastTheme, t),
      errorToastTheme: TwixToastTheme.lerp(a.errorToastTheme, b.errorToastTheme, t),
      breakpoints: TwixBreakpoints.lerp(a.breakpoints, b.breakpoints, t),
      primaryDialogTheme: TwixDialogTheme.lerp(a.primaryDialogTheme, b.primaryDialogTheme, t),
      alertDialogTheme: TwixDialogTheme.lerp(a.alertDialogTheme, b.alertDialogTheme, t),
      sheetTheme: TwixSheetTheme.lerp(a.sheetTheme, b.sheetTheme, t),
      accordionTheme: TwixAccordionTheme.lerp(a.accordionTheme, b.accordionTheme, t),
      hoverStrategies: t < .5 ? a.hoverStrategies : b.hoverStrategies,
      disableSecondaryBorder: t < .5 ? a.disableSecondaryBorder : b.disableSecondaryBorder,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TwixThemeData &&
        other.colorScheme == colorScheme &&
        other.brightness == brightness &&
        other.filledButtonTheme == filledButtonTheme &&
        other.outlineButtonTheme == outlineButtonTheme &&
        other.iconButtonTheme == iconButtonTheme &&
        other.linkButtonTheme == linkButtonTheme &&
        other.radius == radius &&
        other.popoverTheme == popoverTheme &&
        other.decoration == decoration &&
        other.textTheme == textTheme &&
        other.disabledOpacity == disabledOpacity &&
        other.selectTheme == selectTheme &&
        other.optionTheme == optionTheme &&
        other.cardTheme == cardTheme &&
        other.optionTheme == optionTheme &&
        other.checkboxTheme == checkboxTheme &&
        other.inputTheme == inputTheme &&
        other.radioTheme == radioTheme &&
        other.primaryToastTheme == primaryToastTheme &&
        other.errorToastTheme == errorToastTheme &&
        other.breakpoints == breakpoints &&
        other.primaryDialogTheme == primaryDialogTheme &&
        other.alertDialogTheme == alertDialogTheme &&
        other.sheetTheme == sheetTheme &&
        other.accordionTheme == accordionTheme &&
        other.hoverStrategies == hoverStrategies &&
        other.disableSecondaryBorder == disableSecondaryBorder;
  }

  @override
  int get hashCode {
    return colorScheme.hashCode ^
        brightness.hashCode ^
        filledButtonTheme.hashCode ^
        outlineButtonTheme.hashCode ^
        iconButtonTheme.hashCode ^
        linkButtonTheme.hashCode ^
        radius.hashCode ^
        popoverTheme.hashCode ^
        decoration.hashCode ^
        textTheme.hashCode ^
        disabledOpacity.hashCode ^
        selectTheme.hashCode ^
        optionTheme.hashCode ^
        cardTheme.hashCode ^
        optionTheme.hashCode ^
        checkboxTheme.hashCode ^
        inputTheme.hashCode ^
        radioTheme.hashCode ^
        primaryToastTheme.hashCode ^
        errorToastTheme.hashCode ^
        breakpoints.hashCode ^
        primaryDialogTheme.hashCode ^
        alertDialogTheme.hashCode ^
        sheetTheme.hashCode ^
        accordionTheme.hashCode ^
        hoverStrategies.hashCode ^
        disableSecondaryBorder.hashCode;
  }

  TwixThemeData copyWith({
    TwixColorScheme? colorScheme,
    TwixButtonTheme? filledButtonTheme,
    TwixButtonTheme? secondaryButtonTheme,
    TwixButtonTheme? errorButtonTheme,
    TwixButtonTheme? outlineButtonTheme,
    TwixButtonTheme? iconButtonTheme,
    TwixButtonTheme? linkButtonTheme,
    Brightness? brightness,
    Iterable<ThemeExtension<dynamic>>? extensions,
    BorderRadius? radius,
    TwixPopoverTheme? popoverTheme,
    TwixDecoration? decoration,
    TwixTextTheme? textTheme,
    double? disabledOpacity,
    TwixSelectTheme? selectTheme,
    TwixOptionTheme? optionTheme,
    TwixCardTheme? cardTheme,
    TwixCheckboxTheme? checkboxTheme,
    TwixInputTheme? inputTheme,
    TwixRadioTheme? radioTheme,
    TwixToastTheme? primaryToastTheme,
    TwixToastTheme? errorToastTheme,
    TwixBreakpoints? breakpoints,
    TwixDialogTheme? primaryDialogTheme,
    TwixDialogTheme? alertDialogTheme,
    TwixSheetTheme? sheetTheme,
    TwixAccordionTheme? accordionTheme,
    TwixHoverStrategies? hoverStrategies,
    bool? disableSecondaryBorder,
  }) {
    return TwixThemeData(
      colorScheme: colorScheme ?? this.colorScheme,
      extensions: extensions ?? this.extensions,
      brightness: brightness ?? this.brightness,
      filledButtonTheme: filledButtonTheme ?? this.filledButtonTheme,
      outlineButtonTheme: outlineButtonTheme ?? this.outlineButtonTheme,
      iconButtonTheme: iconButtonTheme ?? this.iconButtonTheme,
      linkButtonTheme: linkButtonTheme ?? this.linkButtonTheme,
      radius: radius ?? this.radius,
      popoverTheme: popoverTheme ?? this.popoverTheme,
      decoration: decoration ?? this.decoration,
      textTheme: textTheme ?? this.textTheme,
      disabledOpacity: disabledOpacity ?? this.disabledOpacity,
      selectTheme: selectTheme ?? this.selectTheme,
      optionTheme: optionTheme ?? this.optionTheme,
      cardTheme: cardTheme ?? this.cardTheme,
      checkboxTheme: checkboxTheme ?? this.checkboxTheme,
      inputTheme: inputTheme ?? this.inputTheme,
      radioTheme: radioTheme ?? this.radioTheme,
      primaryToastTheme: primaryToastTheme ?? this.primaryToastTheme,
      errorToastTheme: errorToastTheme ?? this.errorToastTheme,
      breakpoints: breakpoints ?? this.breakpoints,
      primaryDialogTheme: primaryDialogTheme ?? this.primaryDialogTheme,
      alertDialogTheme: alertDialogTheme ?? this.alertDialogTheme,
      sheetTheme: sheetTheme ?? this.sheetTheme,
      accordionTheme: accordionTheme ?? this.accordionTheme,
      hoverStrategies: hoverStrategies ?? this.hoverStrategies,
      disableSecondaryBorder: disableSecondaryBorder ?? this.disableSecondaryBorder,
    );
  }
}
