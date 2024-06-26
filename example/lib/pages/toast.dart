import 'package:flutter/material.dart';
import 'package:twix_ui/twix_ui.dart';

enum ToastStyle {
  schedule,
  simple,
  withTitle,
  withAction,
}

class ToastPage extends StatelessWidget {
  const ToastPage({
    super.key,
    required this.style,
  });

  final ToastStyle style;

  @override
  Widget build(BuildContext context) {
    final theme = TwixTheme.of(context);
    return Scaffold(
      body: Center(
        child: () {
          return switch (style) {
            ToastStyle.schedule => TwixButton.outline(
                text: const Text('Add to calendar'),
                onPressed: () {
                  TwixToastManager.of(context).show(
                    TwixToast.error(
                      title: const Text('Scheduled: Catch up'),
                      description: const Text('Friday, February 10, 2023 at 5:57 PM'),
                      action: TwixButton.outline(
                        text: const Text('Undo'),
                        onPressed: () => TwixToastManager.of(context).hide(),
                      ),
                    ),
                  );
                },
              ),
            ToastStyle.simple => TwixButton.outline(
                text: const Text('Show Toast'),
                onPressed: () {
                  TwixToastManager.of(context).show(
                    const TwixToast(
                      description: Text('Your message has been sent.'),
                    ),
                  );
                },
              ),
            ToastStyle.withTitle => TwixButton.outline(
                text: const Text('Show Toast'),
                onPressed: () {
                  TwixToastManager.of(context).show(
                    const TwixToast(
                      title: Text('Uh oh! Something went wrong'),
                      description: Text('There was a problem with your request'),
                    ),
                  );
                },
              ),
            ToastStyle.withAction => TwixButton.outline(
                text: const Text('Show Toast'),
                onPressed: () {
                  TwixToastManager.of(context).show(
                    TwixToast(
                      title: const Text('Uh oh! Something went wrong'),
                      description: const Text('There was a problem with your request'),
                      action: TwixButton.outline(
                        text: const Text('Try again'),
                        onPressed: () => TwixToastManager.of(context).hide(),
                      ),
                    ),
                  );
                },
              ),
          };
        }(),
      ),
    );
  }
}
