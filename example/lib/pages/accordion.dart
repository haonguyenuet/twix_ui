import 'package:flutter/material.dart';

import 'package:twix_ui/twix_ui.dart';

final details = [
  (
    title: 'Is it acceptable?',
    content: 'Yes. It adheres to the WAI-ARIA design pattern.',
  ),
  (
    title: 'Is it styled?',
    content: "Yes. It comes with default styles that matches the other components' aesthetic.",
  ),
  (
    title: 'Is it animated?',
    content: "Yes. It's animated by default, but you can disable it if you prefer.",
  ),
];

class AccordionPage extends StatelessWidget {
  const AccordionPage({
    super.key,
    required this.style,
  });

  final TwixAccordionType style;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 600,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: () {
            return switch (style) {
              TwixAccordionType.single => TwixAccordion<({String content, String title})>.single(
                  children: details.map(
                    (detail) => TwixAccordionItem(
                      value: detail,
                      title: Text(detail.title),
                      content: Text(detail.content),
                    ),
                  ),
                ),
              TwixAccordionType.multiple => TwixAccordion<({String content, String title})>.multiple(
                  children: details.map(
                    (detail) => TwixAccordionItem(
                      value: detail,
                      title: Text(detail.title),
                      content: Text(detail.content),
                    ),
                  ),
                ),
            };
          }(),
        ),
      ),
    );
  }
}
