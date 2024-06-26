import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

typedef TwixIconImageSrc = Object;

class TwixIconImage<T extends TwixIconImageSrc> extends StatelessWidget {
  const TwixIconImage(
    this.src, {
    super.key,
    this.width,
    this.height,
    this.radius,
    this.color,
    this.gradient,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.placeholder,
    this.semanticLabel,
  }) : assert(
          src is String || src is IconData,
          'src must be a String or IconData',
        );

  const TwixIconImage.square(
    this.src, {
    super.key,
    required double size,
    this.radius,
    this.color,
    this.gradient,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.placeholder,
    this.semanticLabel,
  })  : width = size,
        height = size,
        assert(
          src is String || src is IconData,
          'src must be a String or IconData',
        );

  /// Accepted data:
  /// - assets/home_icon.svg
  final T src;

  final double? width;
  final double? height;
  final double? radius;
  final Color? color;
  final Gradient? gradient;
  final BoxFit fit;
  final Widget? placeholder;
  final Alignment alignment;
  final String? semanticLabel;

  bool get isRemote => Uri.tryParse(src as String)?.host.isNotEmpty ?? false;

  bool get isSvg => (src as String).contains('.svg');

  @override
  Widget build(BuildContext context) {
    final imageColor = gradient != null ? Colors.white : color;
    final Widget image;
    if (src is IconData) {
      image = Icon(
        src as IconData,
        size: width,
        color: imageColor,
        semanticLabel: semanticLabel,
      );
    } else {
      final sourceString = src as String;
      final colorFilter = imageColor != null ? ColorFilter.mode(imageColor, BlendMode.srcIn) : null;
      if (isRemote) {
        if (isSvg) {
          image = SvgPicture.network(
            sourceString,
            width: width,
            height: height,
            fit: fit,
            colorFilter: colorFilter,
            clipBehavior: Clip.antiAlias,
            alignment: alignment,
            placeholderBuilder: placeholder != null ? (_) => placeholder! : null,
            semanticsLabel: semanticLabel,
          );
        } else {
          image = CachedNetworkImage(
            imageUrl: sourceString,
            width: width,
            height: height,
            fit: fit,
            color: imageColor,
            alignment: alignment,
            placeholder: (_, __) => placeholder ?? const SizedBox.shrink(),
          );
        }
      } else if (isSvg) {
        image = SvgPicture.asset(
          sourceString,
          width: width,
          height: height,
          fit: fit,
          colorFilter: colorFilter,
          clipBehavior: Clip.antiAlias,
          alignment: alignment,
          placeholderBuilder: placeholder != null ? (_) => placeholder! : null,
          semanticsLabel: semanticLabel,
        );
      } else {
        image = Image.asset(
          sourceString,
          width: width,
          height: height,
          fit: fit,
          color: imageColor,
          alignment: alignment,
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            if (frame == null) {
              return placeholder ?? const SizedBox.shrink();
            }
            return child;
          },
          semanticLabel: semanticLabel,
        );
      }
    }

    final Widget radiusImage = ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 0),
      child: image,
    );

    if (gradient == null) return radiusImage;

    return ShaderMask(
      shaderCallback: (bounds) => gradient!.createShader(Offset.zero & bounds.size),
      child: radiusImage,
    );
  }
}
