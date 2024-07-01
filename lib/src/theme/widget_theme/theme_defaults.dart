import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:twix_ui/src/theme/color_scheme/base.dart';
import 'package:twix_ui/src/theme/text_theme/text_theme.dart';
import 'package:twix_ui/src/theme/text_theme/typography_default.dart';
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
import 'package:twix_ui/src/theme/widget_theme/shadows.dart';
import 'package:twix_ui/src/theme/widget_theme/sheet.dart';
import 'package:twix_ui/src/theme/widget_theme/toast.dart';
import 'package:twix_ui/src/utils/gesture_detector.dart';
import 'package:twix_ui/src/utils/position.dart';
import 'package:twix_ui/src/widgets/portal.dart';

abstract class TwixWidgetThemeDefault {
  static TwixButtonTheme filledButtonTheme({required TwixColorScheme? colorScheme, required BorderRadius radius}) {
    return TwixButtonTheme(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      backgroundColor: colorScheme?.primary,
      hoverBackgroundColor: colorScheme?.primary.withOpacity(.9),
      foregroundColor: colorScheme?.primaryForeground,
      hoverForegroundColor: colorScheme?.primaryForeground,
      decoration: TwixDecoration(border: TwixBorder(radius: radius)),
    );
  }

  static TwixButtonTheme outlineButtonTheme({
    required TwixColorScheme? colorScheme,
    required BorderRadius radius,
  }) {
    return TwixButtonTheme(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      hoverBackgroundColor: colorScheme?.accent,
      foregroundColor: colorScheme?.primary,
      hoverForegroundColor: colorScheme?.accentForeground,
      decoration: TwixDecoration(
        border: TwixBorder(radius: radius, color: colorScheme?.input),
      ),
    );
  }

  static TwixButtonTheme iconButtonTheme({
    required TwixColorScheme? colorScheme,
    required BorderRadius radius,
  }) {
    return TwixButtonTheme(
      width: 32,
      height: 32,
      padding: EdgeInsets.zero,
      hoverBackgroundColor: colorScheme?.accent,
      foregroundColor: colorScheme?.primary,
      hoverForegroundColor: colorScheme?.accentForeground,
      decoration: TwixDecoration(border: TwixBorder(radius: radius)),
    );
  }

  static TwixButtonTheme linkButtonTheme({
    required TwixColorScheme? colorScheme,
  }) {
    return TwixButtonTheme(
      foregroundColor: colorScheme?.primary,
      hoverForegroundColor: colorScheme?.primary,
      hoverTextDecoration: TextDecoration.underline,
    );
  }

  static TwixPopoverTheme popoverTheme({
    required TwixColorScheme? colorScheme,
    required BorderRadius radius,
  }) {
    return TwixPopoverTheme(
      effects: const [
        FadeEffect(),
        ScaleEffect(begin: Offset(.95, .95), end: Offset(1, 1)),
        MoveEffect(begin: Offset(0, 2), end: Offset.zero),
      ],
      shadows: TwixShadowsDefault.md,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: TwixDecoration(
        color: colorScheme?.popover,
        shadows: TwixShadowsDefault.md,
        border: TwixBorder(
          radius: radius,
          color: colorScheme?.border,
        ),
      ),
      anchor: const TwixAnchorAuto(preferBelow: true, verticalOffset: 24),
    );
  }

  static TwixDecoration decorationTheme({
    required TwixColorScheme? colorScheme,
    required BorderRadius radius,
    required TwixTextTheme textTheme,
  }) {
    return TwixDecoration(
      secondaryBorder: const TwixBorder(padding: EdgeInsets.all(4)),
      secondaryFocusedBorder: TwixBorder(
        width: 2,
        color: colorScheme?.ring,
        radius: radius.add(radius / 2),
        padding: const EdgeInsets.all(2),
      ),
      labelStyle: textTheme.bodyMedium.copyWith(
        fontWeight: FontWeight.w500,
        color: colorScheme?.foreground,
      ),
      errorStyle: textTheme.bodyMedium.copyWith(
        fontWeight: FontWeight.w500,
        color: colorScheme?.error,
      ),
      labelPadding: const EdgeInsets.only(bottom: 8),
      descriptionStyle: textTheme.bodyMedium,
      descriptionPadding: const EdgeInsets.only(top: 8),
      errorPadding: const EdgeInsets.only(top: 8),
      errorLabelStyle: textTheme.bodyMedium.copyWith(
        fontWeight: FontWeight.w500,
        color: colorScheme?.error,
      ),
    );
  }

  static TwixTextTheme textTheme() {
    const defaultFontFamily = 'packages/twix_ui/$kDefaultFontFamily';
    return TwixTextTheme.custom(
      displayLarge: TwixTypographyDefault.displayLarge(family: defaultFontFamily),
      displayMedium: TwixTypographyDefault.displayMedium(family: defaultFontFamily),
      displaySmall: TwixTypographyDefault.displaySmall(family: defaultFontFamily),
      headlineLarge: TwixTypographyDefault.headlineLarge(family: defaultFontFamily),
      headlineMedium: TwixTypographyDefault.headlineMedium(family: defaultFontFamily),
      headlineSmall: TwixTypographyDefault.headlineSmall(family: defaultFontFamily),
      titleLarge: TwixTypographyDefault.titleLarge(family: defaultFontFamily),
      titleMedium: TwixTypographyDefault.titleMedium(family: defaultFontFamily),
      titleSmall: TwixTypographyDefault.titleSmall(family: defaultFontFamily),
      bodyLarge: TwixTypographyDefault.bodyLarge(family: defaultFontFamily),
      bodyMedium: TwixTypographyDefault.bodyMedium(family: defaultFontFamily),
      bodySmall: TwixTypographyDefault.bodySmall(family: defaultFontFamily),
      labelLarge: TwixTypographyDefault.labelLarge(family: defaultFontFamily),
      labelMedium: TwixTypographyDefault.labelMedium(family: defaultFontFamily),
      labelSmall: TwixTypographyDefault.labelSmall(family: defaultFontFamily),
      family: defaultFontFamily,
    );
  }

  static TwixSelectTheme selectTheme({
    required TwixColorScheme? colorScheme,
    required BorderRadius radius,
  }) {
    return TwixSelectTheme(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: TwixDecoration(
        border: TwixBorder(radius: radius, color: colorScheme?.input),
      ),
      optionsPadding: const EdgeInsets.all(4),
      showScrollToTopChevron: true,
      showScrollToBottomChevron: true,
      anchor: const TwixAnchor(
        childAlignment: Alignment.bottomLeft,
        overlayAlignment: Alignment.topLeft,
        offset: Offset.zero,
      ),
      searchPadding: const EdgeInsets.all(12),
    );
  }

  static TwixOptionTheme optionTheme({
    required TwixColorScheme? colorScheme,
  }) {
    return TwixOptionTheme(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      hoveredBackgroundColor: colorScheme?.accent,
    );
  }

  static TwixCardTheme cardTheme({
    required TwixColorScheme? colorScheme,
  }) {
    return TwixCardTheme(
      backgroundColor: colorScheme?.card,
      padding: const EdgeInsets.all(24),
      border: Border.all(color: colorScheme?.border ?? Colors.transparent),
      radius: const BorderRadius.all(Radius.circular(8)),
      shadows: TwixShadowsDefault.sm,
      rowMainAxisSize: MainAxisSize.min,
      rowCrossAxisAlignment: CrossAxisAlignment.start,
      rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
      columnMainAxisSize: MainAxisSize.min,
      columnCrossAxisAlignment: CrossAxisAlignment.start,
      columnMainAxisAlignment: MainAxisAlignment.start,
    );
  }

  static TwixCheckboxTheme checkboxTheme({
    required TwixColorScheme? colorScheme,
    required BorderRadius radius,
  }) {
    return TwixCheckboxTheme(
      size: 16,
      duration: 100.milliseconds,
      color: colorScheme?.primary,
      padding: const EdgeInsets.only(left: 8),
      decoration: TwixDecoration(
        border: TwixBorder(
          width: 1,
          color: colorScheme?.primary,
          radius: radius,
        ),
      ),
    );
  }

  static TwixInputTheme inputTheme({
    required TwixColorScheme? colorScheme,
    required BorderRadius radius,
    required TwixTextTheme textTheme,
  }) {
    return TwixInputTheme(
      style: textTheme.bodyMedium.copyWith(color: colorScheme?.foreground),
      placeholderStyle: textTheme.bodyMedium,
      placeholderAlignment: Alignment.topLeft,
      inputPadding: EdgeInsets.zero,
      decoration: TwixDecoration(
        border: TwixBorder(
          width: 2,
          color: colorScheme?.border,
          radius: radius,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }

  static TwixRadioTheme radioTheme({
    required TwixColorScheme? colorScheme,
  }) {
    const circleSize = 10.0;
    const radius = BorderRadius.all(Radius.circular(circleSize));
    return TwixRadioTheme(
      size: 16,
      circleSize: circleSize,
      duration: 100.milliseconds,
      color: colorScheme?.primary,
      padding: const EdgeInsets.only(left: 8),
      decoration: TwixDecoration(
        shape: BoxShape.circle,
        border: TwixBorder(
          width: 1,
          color: colorScheme?.primary,
        ),
        secondaryFocusedBorder: TwixBorder(radius: radius.add(radius / 2)),
      ),
    );
  }

  static TwixToastTheme primaryToastTheme({
    required TwixColorScheme? colorScheme,
    required BorderRadius radius,
    required TwixTextTheme textTheme,
  }) {
    return TwixToastTheme(
      alignment: Alignment.bottomRight,
      closeIconSrc: LucideIcons.x,
      titleStyle: textTheme.titleSmall,
      descriptionStyle: textTheme.bodySmall,
      actionPadding: const EdgeInsets.only(left: 16),
      border: Border.all(color: colorScheme?.border ?? Colors.transparent),
      shadows: TwixShadowsDefault.lg,
      backgroundColor: colorScheme?.background,
      crossAxisAlignment: CrossAxisAlignment.center,
      padding: const EdgeInsets.fromLTRB(24, 24, 32, 24),
    );
  }

  static TwixToastTheme errorToastTheme({
    required TwixColorScheme? colorScheme,
    required BorderRadius radius,
    required TwixTextTheme textTheme,
  }) {
    return TwixToastTheme(
      alignment: Alignment.bottomRight,
      closeIconSrc: LucideIcons.x,
      titleStyle: textTheme.titleSmall.copyWith(
        fontWeight: FontWeight.w500,
        color: colorScheme?.errorForeground,
      ),
      descriptionStyle: textTheme.bodySmall.copyWith(
        color: colorScheme?.errorForeground.withOpacity(.8),
      ),
      actionPadding: const EdgeInsets.only(left: 16),
      border: Border.all(color: colorScheme?.border ?? Colors.transparent),
      shadows: TwixShadowsDefault.lg,
      backgroundColor: colorScheme?.error,
      crossAxisAlignment: CrossAxisAlignment.center,
      padding: const EdgeInsets.fromLTRB(24, 24, 32, 24),
    );
  }

  static TwixDialogTheme primaryDialogTheme({
    required TwixColorScheme? colorScheme,
    required BorderRadius radius,
    required TwixTextTheme textTheme,
  }) {
    return TwixDialogTheme(
      closeIconSrc: LucideIcons.x,
      radius: const BorderRadius.all(Radius.circular(8)),
      backgroundColor: colorScheme?.background,
      removeBorderRadiusIfTiny: false,
      expandActionsWhenTiny: true,
      closeIconPosition: const TwixPosition(top: 8, right: 8),
      animateIn: const [
        FadeEffect(),
        ScaleEffect(begin: Offset(.95, .95), end: Offset(1, 1)),
      ],
      animateOut: const [
        FadeEffect(begin: 1, end: 0),
        ScaleEffect(begin: Offset(1, 1), end: Offset(.95, .95)),
      ],
      constraints: const BoxConstraints(maxWidth: 512),
      shadows: TwixShadowsDefault.lg,
      padding: const EdgeInsets.all(24),
      gap: 8,
      titleStyle: textTheme.titleMedium,
      descriptionStyle: textTheme.bodyMedium.copyWith(color: colorScheme?.mutedForeground),
      alignment: Alignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
    );
  }

  static TwixDialogTheme alertDialogTheme({
    required TwixColorScheme? colorScheme,
    required BorderRadius radius,
    required TwixTextTheme textTheme,
  }) {
    return TwixDialogTheme(
      backgroundColor: colorScheme?.background,
      radius: const BorderRadius.all(Radius.circular(8)),
      removeBorderRadiusIfTiny: false,
      expandActionsWhenTiny: true,
      closeIconPosition: const TwixPosition(top: 8, right: 8),
      animateIn: const [
        FadeEffect(),
        ScaleEffect(begin: Offset(.95, .95), end: Offset(1, 1)),
      ],
      animateOut: const [
        FadeEffect(begin: 1, end: 0),
        ScaleEffect(begin: Offset(1, 1), end: Offset(.95, .95)),
      ],
      constraints: const BoxConstraints(maxWidth: 512),
      shadows: TwixShadowsDefault.lg,
      padding: const EdgeInsets.all(24),
      gap: 8,
      titleStyle: textTheme.titleMedium,
      descriptionStyle: textTheme.bodyMedium,
      alignment: Alignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
    );
  }

  static TwixSheetTheme sheetTheme({
    required TwixColorScheme? colorScheme,
    required TwixTextTheme textTheme,
  }) {
    return const TwixSheetTheme(
      radius: BorderRadius.zero,
      expandCrossSide: true,
    );
  }

  static TwixAccordionTheme accordionTheme({
    required TwixColorScheme? colorScheme,
    required TwixTextTheme textTheme,
  }) {
    const bezierCurve = Cubic(0.87, 0, 0.13, 1);
    const duration = Duration(milliseconds: 300);
    return TwixAccordionTheme(
      iconSrc: LucideIcons.chevronDown,
      padding: const EdgeInsets.symmetric(vertical: 12),
      showUnderlineTitleOnHover: true,
      duration: duration,
      maintainState: false,
      iconEffects: const [
        RotateEffect(
          begin: 0,
          end: .5,
          duration: duration,
          curve: bezierCurve,
        ),
      ],
      curve: bezierCurve,
      titleStyle: textTheme.titleMedium,
    );
  }

  static TwixHoverStrategies hoverStrategies() {
    return const TwixHoverStrategies(
      hover: {
        TwixHoverStrategy.onTapDown,
        TwixHoverStrategy.onLongPressDown,
        TwixHoverStrategy.onLongPressStart,
      },
      unhover: {
        TwixHoverStrategy.onTapUp,
        TwixHoverStrategy.onTapCancel,
        TwixHoverStrategy.onLongPressUp,
        TwixHoverStrategy.onLongPressEnd,
        TwixHoverStrategy.onLongPressCancel,
      },
    );
  }
}
