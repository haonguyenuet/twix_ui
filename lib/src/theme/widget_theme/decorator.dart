import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:twix_ui/src/theme/theme.dart';

class TwixDecorator extends StatelessWidget {
  const TwixDecorator({
    super.key,
    this.child,
    this.decoration,
    this.hasError = false,
    this.isFocused = false,
    this.label,
    this.error,
    this.description,
  });

  final Widget? child;
  final TwixDecoration? decoration;
  final bool isFocused;
  final bool hasError;
  final Widget? label;
  final Widget? error;
  final Widget? description;

  @override
  Widget build(BuildContext context) {
    final theme = TwixTheme.of(context);
    final effectiveDecoration = theme.decoration.mergeWith(decoration);

    final border = switch (hasError) {
      true => effectiveDecoration.errorBorder ?? effectiveDecoration.border,
      false => switch (isFocused) {
          true => effectiveDecoration.focusedBorder ?? effectiveDecoration.border,
          false => effectiveDecoration.border,
        }
    };

    final secondaryBorder = switch (hasError) {
      true => effectiveDecoration.secondaryErrorBorder ?? effectiveDecoration.secondaryBorder,
      false => switch (isFocused) {
          true => effectiveDecoration.secondaryFocusedBorder ?? effectiveDecoration.secondaryBorder,
          false => effectiveDecoration.secondaryBorder,
        }
    };

    final effectiveLabelStyle = effectiveDecoration.labelStyle ??
        theme.textTheme.labelLarge.copyWith(fontWeight: FontWeight.w500, color: theme.colorScheme.foreground);

    final effectiveDescriptionStyle =
        effectiveDecoration.descriptionStyle ?? theme.textTheme.bodySmall.copyWith(color: theme.colorScheme.foreground);

    final effectiveErrorStyle =
        effectiveDecoration.errorStyle ?? theme.textTheme.bodySmall.copyWith(color: theme.colorScheme.error);

    Widget decorated = Container(
      decoration: BoxDecoration(
        border: border?.width == null && border?.color == null
            ? null
            : Border.all(
                color: border?.color ?? Colors.black,
                width: border?.width ?? 1.0,
              ),
        borderRadius: effectiveDecoration.shape == BoxShape.circle ? null : border?.radius,
        color: effectiveDecoration.color,
        shape: effectiveDecoration.shape ?? BoxShape.rectangle,
        backgroundBlendMode: effectiveDecoration.backgroundBlendMode,
        boxShadow: effectiveDecoration.shadows,
        gradient: effectiveDecoration.gradient,
        image: effectiveDecoration.image,
      ),
      padding: border?.padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null)
            Padding(
              padding: effectiveDecoration.labelPadding ?? const EdgeInsets.only(bottom: 8),
              child: DefaultTextStyle(
                style: effectiveLabelStyle,
                child: label!,
              ),
            ),
          if (child != null) child!,
          if (description != null)
            Padding(
              padding: effectiveDecoration.descriptionPadding ?? const EdgeInsets.only(top: 8),
              child: DefaultTextStyle(
                style: effectiveDescriptionStyle,
                child: description!,
              ),
            ),
          if (error != null)
            Padding(
              padding: effectiveDecoration.errorPadding ?? const EdgeInsets.only(top: 8),
              child: DefaultTextStyle(
                style: effectiveErrorStyle,
                child: error!,
              ),
            ),
        ],
      ),
    );

    if (secondaryBorder != null && !theme.disableSecondaryBorder) {
      decorated = Container(
        decoration: BoxDecoration(
          border: secondaryBorder.width == null && secondaryBorder.color == null
              ? null
              : Border.all(
                  color: secondaryBorder.color ?? Colors.black,
                  width: secondaryBorder.width ?? 1.0,
                ),
          borderRadius: secondaryBorder.radius,
        ),
        padding: secondaryBorder.padding,
        child: decorated,
      );
    }

    return decorated;
  }
}

class TwixDecoration {
  const TwixDecoration({
    this.merge = true,
    this.border,
    this.focusedBorder,
    this.errorBorder,
    this.secondaryBorder,
    this.secondaryFocusedBorder,
    this.secondaryErrorBorder,
    this.labelStyle,
    this.errorLabelStyle,
    this.errorStyle,
    this.descriptionStyle,
    this.labelPadding,
    this.descriptionPadding,
    this.errorPadding,
    this.color,
    this.image,
    this.shadows,
    this.gradient,
    this.backgroundBlendMode,
    this.shape,
  });

  static const TwixDecoration none = TwixDecoration(merge: false);

  final bool merge;
  final TextStyle? labelStyle;
  final TextStyle? errorLabelStyle;
  final TwixBorder? border;
  final TwixBorder? focusedBorder;
  final TwixBorder? errorBorder;
  final TwixBorder? secondaryBorder;
  final TwixBorder? secondaryFocusedBorder;
  final TwixBorder? secondaryErrorBorder;
  final TextStyle? errorStyle;
  final TextStyle? descriptionStyle;
  final EdgeInsets? labelPadding;
  final EdgeInsets? descriptionPadding;
  final EdgeInsets? errorPadding;
  final Color? color;
  final DecorationImage? image;
  final List<BoxShadow>? shadows;
  final Gradient? gradient;
  final BlendMode? backgroundBlendMode;
  final BoxShape? shape;

  static TwixDecoration? lerp(TwixDecoration? a, TwixDecoration? b, double t) {
    if (a == null && b == null) return null;
    return TwixDecoration(
      border: TwixBorder.lerp(a?.border, b?.border, t),
      focusedBorder: TwixBorder.lerp(a?.focusedBorder, b?.focusedBorder, t),
      errorBorder: TwixBorder.lerp(a?.errorBorder, b?.errorBorder, t),
      secondaryBorder: TwixBorder.lerp(a?.secondaryBorder, b?.secondaryBorder, t),
      secondaryFocusedBorder: TwixBorder.lerp(a?.secondaryFocusedBorder, b?.secondaryFocusedBorder, t),
      secondaryErrorBorder: TwixBorder.lerp(a?.secondaryErrorBorder, b?.secondaryErrorBorder, t),
      labelStyle: TextStyle.lerp(a?.labelStyle, b?.labelStyle, t),
      errorLabelStyle: TextStyle.lerp(a?.errorLabelStyle, b?.errorLabelStyle, t),
      errorStyle: TextStyle.lerp(a?.errorStyle, b?.errorStyle, t),
      descriptionStyle: TextStyle.lerp(a?.descriptionStyle, b?.descriptionStyle, t),
      labelPadding: EdgeInsets.lerp(a?.labelPadding, b?.labelPadding, t),
      descriptionPadding: EdgeInsets.lerp(a?.descriptionPadding, b?.descriptionPadding, t),
      errorPadding: EdgeInsets.lerp(a?.errorPadding, b?.errorPadding, t),
      color: Color.lerp(a?.color, b?.color, t),
      image: DecorationImage.lerp(a?.image, b?.image, t),
      shadows: BoxShadow.lerpList(a?.shadows, b?.shadows, t),
      gradient: Gradient.lerp(a?.gradient, b?.gradient, t),
      backgroundBlendMode: t < 0.5 ? a?.backgroundBlendMode : b?.backgroundBlendMode,
      shape: t < 0.5 ? a?.shape : b?.shape,
    );
  }

  TwixDecoration mergeWith(TwixDecoration? other) {
    if (other == null) return this;
    if (!other.merge) return other;
    return copyWith(
      border: border?.mergeWith(other.border) ?? other.border,
      focusedBorder: focusedBorder?.mergeWith(other.focusedBorder) ?? other.focusedBorder,
      errorBorder: errorBorder?.mergeWith(other.errorBorder) ?? other.errorBorder,
      secondaryBorder: secondaryBorder?.mergeWith(other.secondaryBorder) ?? other.secondaryBorder,
      secondaryFocusedBorder:
          secondaryFocusedBorder?.mergeWith(other.secondaryFocusedBorder) ?? other.secondaryFocusedBorder,
      secondaryErrorBorder: secondaryErrorBorder?.mergeWith(other.secondaryErrorBorder) ?? other.secondaryErrorBorder,
      labelStyle: other.labelStyle ?? labelStyle,
      errorLabelStyle: other.errorLabelStyle ?? errorLabelStyle,
      errorStyle: other.errorStyle ?? errorStyle,
      descriptionStyle: other.descriptionStyle ?? descriptionStyle,
      labelPadding: other.labelPadding ?? labelPadding,
      descriptionPadding: other.descriptionPadding ?? descriptionPadding,
      errorPadding: other.errorPadding ?? errorPadding,
      color: other.color ?? color,
      shape: other.shape ?? shape,
      backgroundBlendMode: other.backgroundBlendMode ?? backgroundBlendMode,
      shadows: other.shadows ?? shadows,
      gradient: other.gradient ?? gradient,
      image: other.image ?? image,
    );
  }

  TwixDecoration copyWith({
    TwixBorder? border,
    TwixBorder? focusedBorder,
    TwixBorder? errorBorder,
    TwixBorder? secondaryBorder,
    TwixBorder? secondaryFocusedBorder,
    TwixBorder? secondaryErrorBorder,
    TextStyle? labelStyle,
    TextStyle? errorLabelStyle,
    TextStyle? errorStyle,
    TextStyle? descriptionStyle,
    EdgeInsets? labelPadding,
    EdgeInsets? descriptionPadding,
    EdgeInsets? errorPadding,
    Color? color,
    BoxShape? shape,
    BlendMode? backgroundBlendMode,
    List<BoxShadow>? shadows,
    Gradient? gradient,
    DecorationImage? image,
  }) {
    return TwixDecoration(
      border: border ?? this.border,
      focusedBorder: focusedBorder ?? this.focusedBorder,
      errorBorder: errorBorder ?? this.errorBorder,
      secondaryBorder: secondaryBorder ?? this.secondaryBorder,
      secondaryFocusedBorder: secondaryFocusedBorder ?? this.secondaryFocusedBorder,
      secondaryErrorBorder: secondaryErrorBorder ?? this.secondaryErrorBorder,
      labelStyle: labelStyle ?? this.labelStyle,
      errorLabelStyle: errorLabelStyle ?? this.errorLabelStyle,
      errorStyle: errorStyle ?? this.errorStyle,
      descriptionStyle: descriptionStyle ?? this.descriptionStyle,
      labelPadding: labelPadding ?? this.labelPadding,
      descriptionPadding: descriptionPadding ?? this.descriptionPadding,
      errorPadding: errorPadding ?? this.errorPadding,
      color: color ?? this.color,
      shape: shape ?? this.shape,
      backgroundBlendMode: backgroundBlendMode ?? this.backgroundBlendMode,
      shadows: shadows ?? this.shadows,
      gradient: gradient ?? this.gradient,
      image: image ?? this.image,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TwixDecoration &&
        other.border == border &&
        other.focusedBorder == focusedBorder &&
        other.errorBorder == errorBorder &&
        other.secondaryBorder == secondaryBorder &&
        other.secondaryFocusedBorder == secondaryFocusedBorder &&
        other.secondaryErrorBorder == secondaryErrorBorder &&
        other.labelStyle == labelStyle &&
        other.errorLabelStyle == errorLabelStyle &&
        other.errorStyle == errorStyle &&
        other.descriptionStyle == descriptionStyle &&
        other.labelPadding == labelPadding &&
        other.descriptionPadding == descriptionPadding &&
        other.errorPadding == errorPadding &&
        other.color == color &&
        other.shape == shape &&
        other.backgroundBlendMode == backgroundBlendMode &&
        other.shadows == shadows &&
        other.gradient == gradient &&
        other.image == image;
  }

  @override
  int get hashCode =>
      border.hashCode ^
      focusedBorder.hashCode ^
      errorBorder.hashCode ^
      secondaryBorder.hashCode ^
      secondaryFocusedBorder.hashCode ^
      secondaryErrorBorder.hashCode ^
      labelStyle.hashCode ^
      errorLabelStyle.hashCode ^
      errorStyle.hashCode ^
      descriptionStyle.hashCode ^
      labelPadding.hashCode ^
      descriptionPadding.hashCode ^
      errorPadding.hashCode ^
      color.hashCode ^
      shape.hashCode ^
      backgroundBlendMode.hashCode ^
      shadows.hashCode ^
      gradient.hashCode ^
      image.hashCode;
}

class TwixBorder {
  const TwixBorder({this.merge = true, this.width, this.color, this.radius, this.padding});

  static const TwixBorder none = TwixBorder(merge: false);

  final double? width;
  final Color? color;
  final BorderRadiusGeometry? radius;
  final EdgeInsets? padding;
  final bool merge;

  static TwixBorder? lerp(TwixBorder? a, TwixBorder? b, double t) {
    if (a == null && b == null) return null;
    return TwixBorder(
      width: lerpDouble(a?.width, b?.width, t),
      color: Color.lerp(a?.color, b?.color, t),
      radius: BorderRadiusGeometry.lerp(a?.radius, b?.radius, t),
      padding: EdgeInsets.lerp(a?.padding, b?.padding, t),
    );
  }

  TwixBorder mergeWith(TwixBorder? other) {
    if (other == null) return this;
    if (!other.merge) return other;
    return copyWith(
      width: other.width ?? width,
      color: other.color ?? color,
      radius: other.radius ?? radius,
      padding: other.padding ?? padding,
    );
  }

  TwixBorder copyWith({
    double? width,
    Color? color,
    BorderRadiusGeometry? radius,
    EdgeInsets? padding,
  }) {
    return TwixBorder(
      width: width ?? this.width,
      color: color ?? this.color,
      radius: radius ?? this.radius,
      padding: padding ?? this.padding,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TwixBorder &&
        other.width == width &&
        other.color == color &&
        other.radius == radius &&
        other.padding == padding;
  }

  @override
  int get hashCode {
    return width.hashCode ^ color.hashCode ^ radius.hashCode ^ padding.hashCode;
  }
}
