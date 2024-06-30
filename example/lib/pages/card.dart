import 'package:flutter/material.dart';
import 'package:twix_ui/twix_ui.dart';

enum CardStyle {
  project,
  notifications,
}

class CardPage extends StatelessWidget {
  const CardPage({
    super.key,
    required this.style,
  });

  final CardStyle style;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: () {
          return switch (style) {
            CardStyle.project => const CardProject(),
            CardStyle.notifications => const CardNotifications(),
          };
        }(),
      ),
    );
  }
}

const frameworks = {
  'next': 'Next.js',
  'react': 'React',
  'astro': 'Astro',
  'nuxt': 'Nuxt.js',
};

class CardProject extends StatelessWidget {
  const CardProject({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = TwixTheme.of(context);
    return TwixCard(
      width: 350,
      title: Text('Hào Nguyễn'),
      description: Text('Deploy your new project in one-click.'),
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Name'),
            const TwixInput(placeholder: Text('Name of your project')),
            const SizedBox(height: 6),
            const Text('Framework'),
            TwixSelect<String>(
              placeholder: const Text('Select'),
              options: frameworks.entries.map((e) => TwixOption(value: e.key, child: Text(e.value))).toList(),
              selectedOptionBuilder: (context, value) {
                return Text(frameworks[value]!);
              },
              onChanged: (value) {},
            ),
          ],
        ),
      ),
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TwixButton.outline(
            text: const Text('Cancel'),
            onPressed: () {},
          ),
          TwixButton.filled(
            text: const Text('Deploy'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

const notifications = [
  (
    title: "Your call has been confirmed.",
    description: "1 hour ago",
  ),
  (
    title: "You have a new message!",
    description: "1 hour ago",
  ),
  (
    title: "Your subscription is expiring soon!",
    description: "2 hours ago",
  ),
];

class CardNotifications extends StatefulWidget {
  const CardNotifications({super.key});

  @override
  State<CardNotifications> createState() => _CardNotificationsState();
}

class _CardNotificationsState extends State<CardNotifications> {
  final pushNotifications = ValueNotifier(false);

  @override
  void dispose() {
    pushNotifications.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = TwixTheme.of(context);
    return TwixCard(
      width: 380,
      title: const Text('Notifications'),
      description: const Text('You have 3 unread messages.'),
      content: Column(
        children: [
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: theme.radius,
              border: Border.all(color: theme.colorScheme.border),
            ),
            child: Row(
              children: [
                TwixIconImage.square(
                  LucideIcons.bellRing,
                  size: 24,
                  color: theme.colorScheme.foreground,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Push Notifications',
                          style: theme.textTheme.titleSmall,
                        ),
                        Text(
                          'Send notifications to device.',
                          style: theme.textTheme.bodySmall,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ...notifications
              .map(
                (n) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.only(top: 4),
                      decoration: const BoxDecoration(
                        color: Color(0xFF0CA5E9),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Your call has been confirmed.', style: theme.textTheme.titleSmall),
                            const SizedBox(height: 4),
                            Text(n.description, style: theme.textTheme.bodyMedium),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
              .separatedBy(const SizedBox(height: 8)),
          const SizedBox(height: 16),
        ],
      ),
      footer: TwixButton.filled(
        width: double.infinity,
        text: const Text('Mark all as read'),
        icon: const Padding(
          padding: EdgeInsets.only(right: 8),
          child: TwixIconImage.square(LucideIcons.check, size: 16),
        ),
        onPressed: () {},
      ),
    );
  }
}
