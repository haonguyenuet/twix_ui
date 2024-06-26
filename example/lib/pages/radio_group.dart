import 'package:flutter/material.dart';
import 'package:twix_ui/twix_ui.dart';

class RadioGroupPage extends StatelessWidget {
  const RadioGroupPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: TwixRadioGroup<String>(
          items: [
            TwixRadio(
              title: Text('Default'),
              subTitle: Text("This is description"),
              value: 'default',
            ),
            TwixRadio(
              title: Text('Comfortable'),
              subTitle: Text("This is description"),
              value: 'comfortable',
            ),
            TwixRadio(
              title: Text('Nothing'),
              subTitle: Text("This is description"),
              value: 'nothing',
            ),
          ],
        ),
      ),
    );
  }
}
