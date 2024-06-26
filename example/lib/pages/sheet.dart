import 'package:flutter/material.dart';
import 'package:twix_ui/twix_ui.dart';

enum SheetStyle {
  primary,
  side,
}

class SheetPage extends StatelessWidget {
  const SheetPage({
    super.key,
    required this.style,
  });

  final SheetStyle style;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: () {
            return switch (style) {
              SheetStyle.primary => TwixButton.outline(
                  text: const Text('Open'),
                  onPressed: () => showTwixSheet(
                    side: TwixSheetSide.right,
                    context: context,
                    builder: (context) => const EditProfileSheet(
                      side: TwixSheetSide.right,
                    ),
                  ),
                ),
              SheetStyle.side => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TwixButton.outline(
                          width: 100,
                          text: const Text('Top'),
                          onPressed: () => showTwixSheet(
                            side: TwixSheetSide.top,
                            context: context,
                            builder: (context) => const EditProfileSheet(side: TwixSheetSide.top),
                          ),
                        ),
                        TwixButton.outline(
                          width: 100,
                          text: const Text('Bottom'),
                          onPressed: () => showTwixSheet(
                            side: TwixSheetSide.bottom,
                            context: context,
                            builder: (context) => const EditProfileSheet(side: TwixSheetSide.bottom),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TwixButton.outline(
                          width: 100,
                          text: const Text('Right'),
                          onPressed: () => showTwixSheet(
                            side: TwixSheetSide.right,
                            context: context,
                            builder: (context) => const EditProfileSheet(side: TwixSheetSide.right),
                          ),
                        ),
                        TwixButton.outline(
                          width: 100,
                          text: const Text('Left'),
                          onPressed: () => showTwixSheet(
                            side: TwixSheetSide.left,
                            context: context,
                            builder: (context) => const EditProfileSheet(side: TwixSheetSide.left),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
            };
          }(),
        ),
      ),
    );
  }
}

final profile = [
  (title: 'Name', value: 'Alexandru'),
  (title: 'Username', value: 'nank1ro'),
];

class EditProfileSheet extends StatelessWidget {
  const EditProfileSheet({
    super.key,
    required this.side,
  });

  final TwixSheetSide side;

  @override
  Widget build(BuildContext context) {
    final theme = TwixTheme.of(context);
    return TwixSheet(
      constraints:
          side == TwixSheetSide.left || side == TwixSheetSide.right ? const BoxConstraints(maxWidth: 512) : null,
      title: const Text('Edit Profile'),
      description: const Text("Make changes to your profile here. Click save when you're done"),
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: profile
              .map(
                (p) => Row(
                  children: [
                    Expanded(
                      child: Text(
                        p.title,
                        textAlign: TextAlign.end,
                        style: theme.textTheme.titleSmall,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 5,
                      child: TwixInput(initialValue: p.value),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
      actions: const [
        TwixButton.filled(text: Text('Save changes')),
      ],
    );
  }
}
