import 'package:flutter/material.dart';

import 'package:twix_ui/twix_ui.dart';

final profile = [
  (title: 'Name', value: 'Alexandru'),
  (title: 'Username', value: 'nank1ro'),
];

class DialogPage extends StatelessWidget {
  const DialogPage({
    super.key,
    required this.style,
  });

  final TwixDialogType style;

  @override
  Widget build(BuildContext context) {
    final theme = TwixTheme.of(context);
    return Scaffold(
      body: Center(
        child: () {
          return switch (style) {
            TwixDialogType.primary => TwixButton.outline(
                text: const Text('Edit Profile'),
                onPressed: () {
                  showTwixDialog(
                    context: context,
                    builder: (context) => TwixDialog(
                      title: const Text('Edit Profile'),
                      description: const Text("Make changes to your profile here. Click save when you're done"),
                      crossAxisAlignment: CrossAxisAlignment.start,
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: profile
                            .map(
                              (p) => Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      p.title,
                                      textAlign: TextAlign.start,
                                      style: theme.textTheme.titleSmall,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    flex: 3,
                                    child: TwixInput(initialValue: p.value),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                      actions: const [TwixButton.filled(text: Text('Save changes'))],
                    ),
                  );
                },
              ),
            TwixDialogType.alert => TwixButton.outline(
                text: const Text('Show Dialog'),
                onPressed: () {
                  showTwixDialog(
                    context: context,
                    builder: (context) => TwixDialog.alert(
                      title: const Text('Are you absolutely sure?'),
                      description: const Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text(
                          'This action cannot be undone. This will permanently delete your account and remove your data from our servers.',
                        ),
                      ),
                      actions: [
                        TwixButton.outline(
                          text: const Text('Cancel'),
                          onPressed: () => Navigator.of(context).pop(false),
                        ),
                        TwixButton.filled(
                          text: const Text('Continue'),
                          onPressed: () => Navigator.of(context).pop(true),
                        ),
                      ],
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
