import 'package:example/pages/accordion.dart';
import 'package:example/pages/button.dart';
import 'package:example/pages/card.dart';
import 'package:example/pages/checkbox.dart';
import 'package:example/pages/dialog.dart';
import 'package:example/pages/form.dart';
import 'package:example/pages/image.dart';
import 'package:example/pages/popover.dart';
import 'package:example/pages/radio_group.dart';
import 'package:example/pages/select.dart';
import 'package:example/pages/sheet.dart';
import 'package:example/pages/toast.dart';
import 'package:example/pages/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'package:twix_ui/twix_ui.dart';

void main() {
  usePathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Uri.base.queryParameters['theme'] ?? 'dark';
    return TwixApp.router(
      title: 'Twilight x UI',
      routerConfig: _router,
      themeMode: theme == 'dark' ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
    );
  }
}

// GoRouter configuration
final _router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/sheet?style=side',
  routes: [
    GoRoute(
      path: '/button',
      builder: (context, state) {
        final style = state.uri.queryParameters['style'] ?? 'primary';
        return ButtonPage(
          style: PlagroundButtonStyle.values.byName(style),
        );
      },
    ),
    // GoRoute(
    //   path: '/badge',
    //   builder: (context, state) {
    //     final style = state.uri.queryParameters['style'] ?? 'primary';
    //     return BadgePage(
    //       variant: TwixBadgeVariant.values.byName(style),
    //     );
    //   },
    // ),
    // GoRoute(
    //   path: '/avatar',
    //   builder: (context, state) => const AvatarPage(),
    // ),
    GoRoute(
      path: '/image',
      builder: (context, state) {
        final style = state.uri.queryParameters['style'] ?? 'local';
        return ImagePage(
          style: ImageStyle.values.byName(style),
        );
      },
    ),
    // GoRoute(
    //   path: '/tooltip',
    //   builder: (context, state) => const TooltipPage(),
    // ),
    // GoRoute(
    //   path: '/input',
    //   builder: (context, state) {
    //     final style =
    //         state.uri.queryParameters['style'] ?? InputStyle.email.name;
    //     return InputPage(
    //       style: InputStyle.values.byName(style),
    //     );
    //   },
    // ),
    GoRoute(
      path: '/popover',
      builder: (context, state) => const PopoverPage(),
    ),
    GoRoute(
      path: '/typography',
      builder: (context, state) {
        final style = state.uri.queryParameters['style'] ?? 'displayLarge';
        return TypographyPage(
          style: TypographyStyle.values.byName(style),
        );
      },
    ),
    GoRoute(
      path: '/select',
      builder: (context, state) {
        final style = state.uri.queryParameters['style'] ?? 'frameworks';
        return SelectPage(
          variant: SelectVariant.values.byName(style),
        );
      },
    ),
    GoRoute(
      path: '/card',
      builder: (context, state) {
        final style = state.uri.queryParameters['style'] ?? CardStyle.project.name;
        return CardPage(style: CardStyle.values.byName(style));
      },
    ),
    // GoRoute(
    //   path: '/switch',
    //   builder: (context, state) => const SwitchPage(),
    // ),
    GoRoute(
      path: '/checkbox',
      builder: (context, state) => const CheckboxPage(),
    ),
    GoRoute(
      path: '/form',
      builder: (context, state) {
        final style = state.uri.queryParameters['style'] ?? FormStyle.inputField.name;
        return FormPage(style: FormStyle.values.byName(style));
      },
    ),
    GoRoute(
      path: '/radio-group',
      builder: (context, state) => const RadioGroupPage(),
    ),
    GoRoute(
      path: '/toast',
      builder: (context, state) {
        final style = state.uri.queryParameters['style'] ?? ToastStyle.schedule.name;
        return ToastPage(
          style: ToastStyle.values.byName(style),
        );
      },
    ),
    // GoRoute(
    //   path: '/alert',
    //   builder: (context, state) {
    //     final style =
    //         state.uri.queryParameters['style'] ?? TwixAlertVariant.primary.name;
    //     return AlertPage(
    //       style: TwixAlertVariant.values.byName(style),
    //     );
    //   },
    // ),
    GoRoute(
      path: '/dialog',
      builder: (context, state) {
        final style = state.uri.queryParameters['style'] ?? TwixDialogType.primary.name;
        return DialogPage(
          style: TwixDialogType.values.byName(style),
        );
      },
    ),
    // GoRoute(
    //   path: '/slider',
    //   builder: (context, state) => const SliderPage(),
    // ),
    GoRoute(
      path: '/sheet',
      builder: (context, state) {
        final style = state.uri.queryParameters['style'] ?? SheetStyle.primary.name;
        return SheetPage(
          style: SheetStyle.values.byName(style),
        );
      },
    ),
    // GoRoute(
    //   path: '/progress',
    //   builder: (context, state) {
    //     final style = state.uri.queryParameters['style'] ??
    //         ProgressStyle.determinate.name;
    //     return ProgressPage(style: ProgressStyle.values.byName(style));
    //   },
    // ),
    GoRoute(
      path: '/accordion',
      builder: (context, state) {
        final style = state.uri.queryParameters['style'] ?? TwixAccordionType.single.name;
        return AccordionPage(
          style: TwixAccordionType.values.byName(style),
        );
      },
    ),
    // GoRoute(
    //   path: '/table',
    //   builder: (context, state) => const TablePage(),
    // ),
    // GoRoute(
    //   path: '/resizable',
    //   builder: (context, state) {
    //     final style =
    //         state.uri.queryParameters['style'] ?? TwixResizableStyle.basic.name;
    //     return ResizablePage(
    //       style: TwixResizableStyle.values.byName(style),
    //     );
    //   },
    // ),
  ],
);
