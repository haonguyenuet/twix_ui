import 'package:flutter/material.dart';
import 'package:twix_ui/twix_ui.dart';

class CheckboxPage extends StatefulWidget {
  const CheckboxPage({
    super.key,
  });

  @override
  State<CheckboxPage> createState() => _CheckboxPageState();
}

class _CheckboxPageState extends State<CheckboxPage> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TwixCheckbox(
          checked: value,
          onChanged: (v) => setState(() => value = v),
          title: const Text('Accept terms and conditions'),
          subTitle: const Text(
            'You agree to our Terms of Service and Privacy Policy.',
          ),
        ),
      ),
    );
  }
}
