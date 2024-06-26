import 'package:flutter/material.dart';
import 'package:twix_ui/twix_ui.dart';

enum ImageStyle {
  local,
  remote,
  svg,
}

class ImagePage extends StatelessWidget {
  const ImagePage({
    super.key,
    required this.style,
  });

  final ImageStyle style;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: () {
          return switch (style) {
            ImageStyle.local => const TwixIconImage(
                'assets/banner.png',
                height: 100,
                fit: BoxFit.fitHeight,
              ),
            ImageStyle.remote => const TwixIconImage.square(
                'https://avatars.githubusercontent.com/u/124599?v=4',
                size: 50,
              ),
            ImageStyle.svg => const TwixIconImage.square(
                'assets/flutter.svg',
                size: 50,
              ),
          };
        }(),
      ),
    );
  }
}
