import 'package:flutter/material.dart';
import 'package:twix_ui/twix_ui.dart';

class PopoverPage extends StatefulWidget {
  const PopoverPage({super.key});

  @override
  State<PopoverPage> createState() => _PopoverPageState();
}

class _PopoverPageState extends State<PopoverPage> {
  final popoverController = TwixPopoverController();

  final List<({String name, String initialValue})> layer = [
    (name: 'Width', initialValue: '100%'),
    (name: 'Max. width', initialValue: '300px'),
    (name: 'Height', initialValue: '25px'),
    (name: 'Max. height', initialValue: 'none'),
  ];

  @override
  void dispose() {
    popoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = TwixTheme.of(context).textTheme;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Align(
          alignment: Alignment.topCenter,
          child: TwixPopover(
            controller: popoverController,
            popoverBuilder: (_) => SizedBox(
              width: 288,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Dimensions',
                    style: textTheme.titleSmall,
                  ),
                  Text(
                    'Set the dimensions for the layer.',
                    style: textTheme.bodySmall,
                  ),
                  const SizedBox(height: 4),
                  ...layer.map(
                    (e) => Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                          e.name,
                          textAlign: TextAlign.start,
                        )),
                        Expanded(
                          flex: 2,
                          child: TwixInput(
                            initialValue: e.initialValue,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            child: TwixButton.outline(
              text: const Text('Open popover'),
              onPressed: popoverController.toggle,
            ),
          ),
        ),
      ),
    );
  }
}
