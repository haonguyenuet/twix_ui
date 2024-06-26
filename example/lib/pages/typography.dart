import 'package:flutter/material.dart';
import 'package:twix_ui/twix_ui.dart';

enum TypographyStyle {
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
}

class TypographyPage extends StatelessWidget {
  const TypographyPage({
    super.key,
    required this.style,
  });

  final TypographyStyle style;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: () {
            return switch (style) {
              TypographyStyle.displayLarge => Text(
                  'Taxing Laughter: The Joke Tax Chronicles',
                  style: TwixTheme.of(context).textTheme.displayLarge,
                ),
              TypographyStyle.displayMedium => Text(
                  'Taxing Laughter: The Joke Tax Chronicles',
                  style: TwixTheme.of(context).textTheme.displayMedium,
                ),
              TypographyStyle.displaySmall => Text(
                  'The People of the Kingdom',
                  style: TwixTheme.of(context).textTheme.displaySmall,
                ),
              TypographyStyle.headlineLarge => Text(
                  'The Joke Tax',
                  style: TwixTheme.of(context).textTheme.headlineLarge,
                ),
              TypographyStyle.headlineMedium => Text(
                  'People stopped telling jokes',
                  style: TwixTheme.of(context).textTheme.headlineMedium,
                ),
              TypographyStyle.headlineSmall => Text(
                  'The king, seeing how much happier his subjects were, realized the error of his ways and repealed the joke tax.',
                  style: TwixTheme.of(context).textTheme.headlineSmall,
                ),
              TypographyStyle.titleLarge => Text(
                  '"After all," he said, "everyone enjoys a good joke, so it\'s only fair that they should pay for the privilege."',
                  style: TwixTheme.of(context).textTheme.titleLarge,
                ),
              TypographyStyle.titleMedium => Text(
                  "King's Treasury",
                  style: TwixTheme.of(context).textTheme.titleMedium,
                ),
              TypographyStyle.titleSmall => Text(
                  '1st level of puns: 5 gold coins',
                  style: TwixTheme.of(context).textTheme.titleSmall,
                ),
              TypographyStyle.bodyLarge => Text(
                  'A modal dialog that interrupts the user with important content and expects a response.',
                  style: TwixTheme.of(context).textTheme.bodyLarge,
                ),
              TypographyStyle.bodyMedium => Text(
                  'Are you absolutely sure?',
                  style: TwixTheme.of(context).textTheme.bodyMedium,
                ),
              TypographyStyle.bodySmall => Text(
                  'Email address',
                  style: TwixTheme.of(context).textTheme.bodySmall,
                ),
              TypographyStyle.labelLarge => Text(
                  'A modal dialog that interrupts the user with important content and expects a response.',
                  style: TwixTheme.of(context).textTheme.labelLarge,
                ),
              TypographyStyle.labelMedium => Text(
                  'Are you absolutely sure?',
                  style: TwixTheme.of(context).textTheme.labelMedium,
                ),
              TypographyStyle.labelSmall => Text(
                  'Email address',
                  style: TwixTheme.of(context).textTheme.labelSmall,
                ),
            };
          }(),
        ),
      ),
    );
  }
}
