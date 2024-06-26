import 'package:flutter/material.dart';
import 'package:twix_ui/twix_ui.dart';

enum PlagroundButtonStyle {
  primary,
  outline,
  link,
  icon,
  textIcon,
  loading,
  gradientShadow,
}

class ButtonPage extends StatelessWidget {
  const ButtonPage({super.key, required this.style});

  final PlagroundButtonStyle style;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: () {
          return switch (style) {
            PlagroundButtonStyle.primary => TwixButton.filled(
                text: const Text('Filled Button'),
                onPressed: () {},
              ),
            PlagroundButtonStyle.outline => TwixButton.outline(
                text: const Text('Outline'),
                onPressed: () {},
              ),
            PlagroundButtonStyle.link => TwixButton.link(
                text: const Text('Link'),
                onPressed: () {},
              ),
            PlagroundButtonStyle.icon => TwixButton.icon(
                backgroundColor: TwixTheme.of(context).colorScheme.primary.withOpacity(0.2),
                icon: const Icon(
                  Icons.chevron_right,
                  size: 16,
                ),
                onPressed: () {},
              ),
            PlagroundButtonStyle.textIcon => TwixButton.filled(
                onPressed: () {},
                text: const Text('Login with Email'),
                icon: const Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Icon(
                    Icons.mail_outlined,
                    size: 16,
                  ),
                ),
              ),
            PlagroundButtonStyle.loading => TwixButton.filled(
                onPressed: () {},
                text: const Text('Please wait'),
                icon: const Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: SizedBox.square(
                    dimension: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  ),
                ),
              ),
            PlagroundButtonStyle.gradientShadow => TwixButton.filled(
                onPressed: () {},
                gradient: const LinearGradient(colors: [
                  Colors.cyan,
                  Colors.indigo,
                ]),
                shadows: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(.4),
                    spreadRadius: 4,
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
                text: const Text('Gradient with Shadow'),
              ),
          };
        }(),
      ),
    );
  }
}
