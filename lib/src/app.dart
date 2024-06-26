// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart'
    show GlobalCupertinoLocalizations, GlobalMaterialLocalizations, GlobalWidgetsLocalizations;
import 'package:twix_ui/src/theme/color_scheme/collection.dart';
import 'package:twix_ui/src/theme/theme.dart';
import 'package:twix_ui/src/theme/theme_data.dart';
import 'package:twix_ui/src/utils/cursor_provider.dart';
import 'package:twix_ui/src/widgets/toast.dart';

enum TwixAppType {
  twilight,
  material,
  cupertino,
}

class TwixApp extends StatefulWidget {
  const TwixApp({
    super.key,
    this.navigatorKey,
    this.onGenerateRoute,
    this.onGenerateInitialRoutes,
    this.onUnknownRoute,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.initialRoute,
    this.home,
    this.routes = const <String, WidgetBuilder>{},
    this.builder,
    this.title = '',
    this.onGenerateTitle,
    this.color,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.showPerformanceOverlay = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.theme,
    this.darkTheme,
    this.themeMode,
    this.restorationScopeId,
    this.scrollBehavior = const TwixScrollBehavior(),
    this.pageRouteBuilder,
    this.themeCurve = Curves.linear,
    this.materialThemeBuilder,
  })  : routeInformationProvider = null,
        routeInformationParser = null,
        routerDelegate = null,
        backButtonDispatcher = null,
        routerConfig = null,
        cupertinoThemeBuilder = null,
        type = TwixAppType.twilight;

  /// Creates a [TwixApp] that uses the [Router] instead of a [Navigator].
  const TwixApp.router({
    super.key,
    this.theme,
    this.darkTheme,
    this.themeMode,
    this.routeInformationProvider,
    this.routeInformationParser,
    this.routerDelegate,
    this.backButtonDispatcher,
    this.routerConfig,
    this.builder,
    this.title = '',
    this.onGenerateTitle,
    this.color,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.showPerformanceOverlay = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.restorationScopeId,
    this.scrollBehavior = const TwixScrollBehavior(),
    this.themeCurve = Curves.linear,
    this.materialThemeBuilder,
  })  : navigatorObservers = null,
        navigatorKey = null,
        onGenerateRoute = null,
        home = null,
        onGenerateInitialRoutes = null,
        onUnknownRoute = null,
        routes = null,
        initialRoute = null,
        pageRouteBuilder = null,
        cupertinoThemeBuilder = null,
        type = TwixAppType.twilight;

  /// Creates a [MaterialApp] wrapped by a [TwixTheme].
  const TwixApp.material({
    super.key,
    this.navigatorKey,
    this.onGenerateRoute,
    this.onGenerateInitialRoutes,
    this.onUnknownRoute,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.initialRoute,
    this.home,
    this.routes = const <String, WidgetBuilder>{},
    this.builder,
    this.title = '',
    this.onGenerateTitle,
    this.color,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.showPerformanceOverlay = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.theme,
    this.darkTheme,
    this.themeMode,
    this.restorationScopeId,
    this.scrollBehavior = const MaterialScrollBehavior(),
    this.pageRouteBuilder,
    this.themeCurve = Curves.linear,
    this.materialThemeBuilder,
  })  : routeInformationProvider = null,
        routeInformationParser = null,
        routerDelegate = null,
        backButtonDispatcher = null,
        routerConfig = null,
        cupertinoThemeBuilder = null,
        type = TwixAppType.material;

  /// Creates a [MaterialApp] wrapped by a [TwixTheme] that uses the [Router] instead of a [Navigator].
  const TwixApp.materialRouter({
    super.key,
    this.theme,
    this.darkTheme,
    this.themeMode,
    this.routeInformationProvider,
    this.routeInformationParser,
    this.routerDelegate,
    this.backButtonDispatcher,
    this.routerConfig,
    this.builder,
    this.title = '',
    this.onGenerateTitle,
    this.color,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.showPerformanceOverlay = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.restorationScopeId,
    this.scrollBehavior = const MaterialScrollBehavior(),
    this.themeCurve = Curves.linear,
    this.materialThemeBuilder,
  })  : navigatorObservers = null,
        navigatorKey = null,
        onGenerateRoute = null,
        home = null,
        onGenerateInitialRoutes = null,
        onUnknownRoute = null,
        routes = null,
        initialRoute = null,
        pageRouteBuilder = null,
        cupertinoThemeBuilder = null,
        type = TwixAppType.material;

  /// Creates a [CupertinoApp] wrapped by a [TwixTheme].
  const TwixApp.cupertino({
    super.key,
    this.navigatorKey,
    this.onGenerateRoute,
    this.onGenerateInitialRoutes,
    this.onUnknownRoute,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.initialRoute,
    this.home,
    this.routes = const <String, WidgetBuilder>{},
    this.builder,
    this.title = '',
    this.onGenerateTitle,
    this.color,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.showPerformanceOverlay = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.theme,
    this.darkTheme,
    this.themeMode,
    this.restorationScopeId,
    this.scrollBehavior = const CupertinoScrollBehavior(),
    this.pageRouteBuilder,
    this.themeCurve = Curves.linear,
    this.cupertinoThemeBuilder,
    this.materialThemeBuilder,
  })  : routeInformationProvider = null,
        routeInformationParser = null,
        routerDelegate = null,
        backButtonDispatcher = null,
        routerConfig = null,
        type = TwixAppType.cupertino;

  /// Creates a [CupertinoApp] wrapped by a [TwixTheme] that uses the [Router] instead of a [Navigator].
  const TwixApp.cupertinoRouter({
    super.key,
    this.theme,
    this.darkTheme,
    this.themeMode,
    this.routeInformationProvider,
    this.routeInformationParser,
    this.routerDelegate,
    this.backButtonDispatcher,
    this.routerConfig,
    this.builder,
    this.title = '',
    this.onGenerateTitle,
    this.color,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.showPerformanceOverlay = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.restorationScopeId,
    this.scrollBehavior = const CupertinoScrollBehavior(),
    this.themeCurve = Curves.linear,
    this.cupertinoThemeBuilder,
    this.materialThemeBuilder,
  })  : navigatorObservers = null,
        navigatorKey = null,
        onGenerateRoute = null,
        home = null,
        onGenerateInitialRoutes = null,
        onUnknownRoute = null,
        routes = null,
        initialRoute = null,
        pageRouteBuilder = null,
        type = TwixAppType.cupertino;

  final TwixAppType type;
  final TwixThemeData? theme;
  final TwixThemeData? darkTheme;
  final ThemeMode? themeMode;
  final GlobalKey<NavigatorState>? navigatorKey;
  final Widget? home;
  final Map<String, WidgetBuilder>? routes;
  final String? initialRoute;
  final RouteFactory? onGenerateRoute;
  final InitialRouteListFactory? onGenerateInitialRoutes;
  final RouteFactory? onUnknownRoute;
  final List<NavigatorObserver>? navigatorObservers;
  final RouteInformationProvider? routeInformationProvider;
  final RouteInformationParser<Object>? routeInformationParser;
  final RouterDelegate<Object>? routerDelegate;
  final BackButtonDispatcher? backButtonDispatcher;
  final RouterConfig<Object>? routerConfig;
  final PageRouteFactory? pageRouteBuilder;
  final TransitionBuilder? builder;
  final String title;
  final GenerateAppTitle? onGenerateTitle;
  final Color? color;
  final Locale? locale;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final LocaleListResolutionCallback? localeListResolutionCallback;
  final LocaleResolutionCallback? localeResolutionCallback;
  final Iterable<Locale> supportedLocales;
  final bool showPerformanceOverlay;
  final bool showSemanticsDebugger;
  final bool debugShowCheckedModeBanner;
  final Map<ShortcutActivator, Intent>? shortcuts;
  final Map<Type, Action<Intent>>? actions;
  final String? restorationScopeId;
  final ScrollBehavior scrollBehavior;
  final Curve themeCurve;

  final ThemeData Function(BuildContext context, ThemeData theme)? materialThemeBuilder;
  final CupertinoThemeData Function(BuildContext context, CupertinoThemeData theme)? cupertinoThemeBuilder;

  @override
  State<TwixApp> createState() => _TwixAppState();
}

class _TwixAppState extends State<TwixApp> {
  final HeroController _heroController = HeroController();

  bool get _usesRouter => widget.routerDelegate != null || widget.routerConfig != null;

  /// Combine the Localizations for Material, Cupertino with the ones
  /// contributed by the localizationsDelegates parameter, if any.
  ///
  /// The default value for the localizationsDelegates
  /// ```
  ///  DefaultMaterialLocalizations.delegate,
  ///  DefaultCupertinoLocalizations.delegate,
  ///  DefaultWidgetsLocalizations.delegate
  /// ```
  Iterable<LocalizationsDelegate<dynamic>> get localizationsDelegates sync* {
    final localizationsDelegates = widget.localizationsDelegates;
    if (localizationsDelegates != null) {
      yield* localizationsDelegates;
    }
    yield GlobalMaterialLocalizations.delegate;
    yield GlobalCupertinoLocalizations.delegate;
    yield GlobalWidgetsLocalizations.delegate;
  }

  @override
  void dispose() {
    _heroController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: widget.scrollBehavior,
      child: HeroControllerScope(
        controller: _heroController,
        child: TwixAnimatedTheme(
          data: _twilTheme(context),
          curve: widget.themeCurve,
          child: TwixCursorProvider(
            child: _buildApp(context),
          ),
        ),
      ),
    );
  }

  TwixThemeData _twilTheme(BuildContext context) {
    final mode = widget.themeMode ?? ThemeMode.system;
    final platformBrightness = MediaQuery.platformBrightnessOf(context);
    final useDarkStyle = mode == ThemeMode.dark || (mode == ThemeMode.system && platformBrightness == Brightness.dark);

    late TwixThemeData result;
    if (useDarkStyle) {
      result = widget.darkTheme ??
          TwixThemeData(
            colorScheme: const TwixColorSchemeCollection.dark(),
            brightness: Brightness.dark,
          );
    } else {
      result = widget.theme ??
          TwixThemeData(
            colorScheme: const TwixColorSchemeCollection.light(),
            brightness: Brightness.light,
          );
    }
    return result;
  }

  ThemeData _materialTheme(BuildContext context) {
    final themeData = _twilTheme(context);
    final materialTheme = ThemeData(
      fontFamily: themeData.textTheme.family,
      extensions: themeData.extensions,
      colorScheme: ColorScheme(
        brightness: themeData.brightness,
        primary: themeData.colorScheme.primary,
        onPrimary: themeData.colorScheme.primaryForeground,
        secondary: themeData.colorScheme.secondary,
        onSecondary: themeData.colorScheme.secondaryForeground,
        error: themeData.colorScheme.error,
        onError: themeData.colorScheme.errorForeground,
        background: themeData.colorScheme.background,
        onBackground: themeData.colorScheme.foreground,
        surface: themeData.colorScheme.card,
        onSurface: themeData.colorScheme.cardForeground,
      ),
      scaffoldBackgroundColor: themeData.colorScheme.background,
      brightness: themeData.brightness,
      dividerTheme: DividerThemeData(
        color: themeData.colorScheme.border,
        thickness: 1,
      ),
    );
    if (widget.materialThemeBuilder == null) {
      return materialTheme;
    }
    return widget.materialThemeBuilder!(context, materialTheme);
  }

  CupertinoThemeData _cupertinoTheme(BuildContext context) {
    final themeData = _twilTheme(context);
    final cupertinoTheme = CupertinoThemeData(
      primaryColor: themeData.colorScheme.primary,
      primaryContrastingColor: themeData.colorScheme.primaryForeground,
      scaffoldBackgroundColor: themeData.colorScheme.background,
      barBackgroundColor: themeData.colorScheme.primary,
      brightness: themeData.brightness,
    );

    if (widget.cupertinoThemeBuilder == null) {
      return cupertinoTheme;
    }
    return widget.cupertinoThemeBuilder!(context, cupertinoTheme);
  }

  Widget _builder(BuildContext context, Widget? child) {
    return TwixToastManager(
      child: widget.builder != null
          ? Builder(
              builder: (BuildContext context) {
                return widget.builder!(context, child);
              },
            )
          : child ?? const SizedBox.shrink(),
    );
  }

  Widget _buildApp(BuildContext context) {
    switch (widget.type) {
      case TwixAppType.twilight:
        if (_usesRouter) {
          return AnimatedTheme(
            data: _materialTheme(context),
            child: WidgetsApp.router(
              key: GlobalObjectKey(this),
              routeInformationProvider: widget.routeInformationProvider,
              routeInformationParser: widget.routeInformationParser,
              routerDelegate: widget.routerDelegate,
              routerConfig: widget.routerConfig,
              backButtonDispatcher: widget.backButtonDispatcher,
              builder: _builder,
              title: widget.title,
              onGenerateTitle: widget.onGenerateTitle,
              color: widget.color ?? Colors.blue,
              locale: widget.locale,
              localeResolutionCallback: widget.localeResolutionCallback,
              localeListResolutionCallback: widget.localeListResolutionCallback,
              supportedLocales: widget.supportedLocales,
              showPerformanceOverlay: widget.showPerformanceOverlay,
              showSemanticsDebugger: widget.showSemanticsDebugger,
              debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
              shortcuts: widget.shortcuts,
              actions: widget.actions,
              restorationScopeId: widget.restorationScopeId,
              localizationsDelegates: localizationsDelegates,
            ),
          );
        }

        return AnimatedTheme(
          data: _materialTheme(context),
          child: WidgetsApp(
            key: GlobalObjectKey(this),
            navigatorKey: widget.navigatorKey,
            navigatorObservers: widget.navigatorObservers!,
            home: widget.home,
            routes: widget.routes!,
            initialRoute: widget.initialRoute,
            onGenerateRoute: widget.onGenerateRoute,
            onGenerateInitialRoutes: widget.onGenerateInitialRoutes,
            onUnknownRoute: widget.onUnknownRoute,
            builder: _builder,
            title: widget.title,
            onGenerateTitle: widget.onGenerateTitle,
            color: widget.color ?? Colors.blue,
            locale: widget.locale,
            localeResolutionCallback: widget.localeResolutionCallback,
            localeListResolutionCallback: widget.localeListResolutionCallback,
            supportedLocales: widget.supportedLocales,
            showPerformanceOverlay: widget.showPerformanceOverlay,
            showSemanticsDebugger: widget.showSemanticsDebugger,
            debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
            shortcuts: widget.shortcuts,
            actions: widget.actions,
            restorationScopeId: widget.restorationScopeId,
            localizationsDelegates: localizationsDelegates,
            pageRouteBuilder: widget.pageRouteBuilder ??
                <T>(RouteSettings settings, WidgetBuilder builder) {
                  return MaterialPageRoute<T>(settings: settings, builder: builder);
                },
          ),
        );
      case TwixAppType.material:
        if (_usesRouter) {
          return MaterialApp.router(
            routeInformationProvider: widget.routeInformationProvider,
            routeInformationParser: widget.routeInformationParser,
            routerDelegate: widget.routerDelegate,
            routerConfig: widget.routerConfig,
            backButtonDispatcher: widget.backButtonDispatcher,
            builder: _builder,
            theme: _materialTheme(context),
            title: widget.title,
            onGenerateTitle: widget.onGenerateTitle,
            color: widget.color ?? Colors.blue,
            locale: widget.locale,
            localeResolutionCallback: widget.localeResolutionCallback,
            localeListResolutionCallback: widget.localeListResolutionCallback,
            supportedLocales: widget.supportedLocales,
            showPerformanceOverlay: widget.showPerformanceOverlay,
            showSemanticsDebugger: widget.showSemanticsDebugger,
            debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
            shortcuts: widget.shortcuts,
            actions: widget.actions,
            restorationScopeId: widget.restorationScopeId,
            localizationsDelegates: localizationsDelegates,
          );
        }
        return MaterialApp(
          navigatorKey: widget.navigatorKey,
          navigatorObservers: widget.navigatorObservers!,
          home: widget.home,
          routes: widget.routes!,
          initialRoute: widget.initialRoute,
          onGenerateRoute: widget.onGenerateRoute,
          onGenerateInitialRoutes: widget.onGenerateInitialRoutes,
          onUnknownRoute: widget.onUnknownRoute,
          builder: _builder,
          theme: _materialTheme(context),
          title: widget.title,
          onGenerateTitle: widget.onGenerateTitle,
          color: widget.color ?? Colors.blue,
          locale: widget.locale,
          localeResolutionCallback: widget.localeResolutionCallback,
          localeListResolutionCallback: widget.localeListResolutionCallback,
          supportedLocales: widget.supportedLocales,
          showPerformanceOverlay: widget.showPerformanceOverlay,
          showSemanticsDebugger: widget.showSemanticsDebugger,
          debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
          shortcuts: widget.shortcuts,
          actions: widget.actions,
          restorationScopeId: widget.restorationScopeId,
          localizationsDelegates: localizationsDelegates,
        );

      case TwixAppType.cupertino:
        if (_usesRouter) {
          return AnimatedTheme(
            data: _materialTheme(context),
            child: CupertinoApp.router(
              routeInformationProvider: widget.routeInformationProvider,
              routeInformationParser: widget.routeInformationParser,
              routerDelegate: widget.routerDelegate,
              routerConfig: widget.routerConfig,
              backButtonDispatcher: widget.backButtonDispatcher,
              builder: _builder,
              theme: _cupertinoTheme(context),
              title: widget.title,
              onGenerateTitle: widget.onGenerateTitle,
              color: widget.color ?? Colors.blue,
              locale: widget.locale,
              localeResolutionCallback: widget.localeResolutionCallback,
              localeListResolutionCallback: widget.localeListResolutionCallback,
              supportedLocales: widget.supportedLocales,
              showPerformanceOverlay: widget.showPerformanceOverlay,
              showSemanticsDebugger: widget.showSemanticsDebugger,
              debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
              shortcuts: widget.shortcuts,
              actions: widget.actions,
              restorationScopeId: widget.restorationScopeId,
              localizationsDelegates: localizationsDelegates,
            ),
          );
        }
        return AnimatedTheme(
          data: _materialTheme(context),
          child: CupertinoApp(
            navigatorKey: widget.navigatorKey,
            navigatorObservers: widget.navigatorObservers!,
            home: widget.home,
            routes: widget.routes!,
            initialRoute: widget.initialRoute,
            onGenerateRoute: widget.onGenerateRoute,
            onGenerateInitialRoutes: widget.onGenerateInitialRoutes,
            onUnknownRoute: widget.onUnknownRoute,
            builder: _builder,
            theme: _cupertinoTheme(context),
            title: widget.title,
            onGenerateTitle: widget.onGenerateTitle,
            color: widget.color ?? Colors.blue,
            locale: widget.locale,
            localeResolutionCallback: widget.localeResolutionCallback,
            localeListResolutionCallback: widget.localeListResolutionCallback,
            supportedLocales: widget.supportedLocales,
            showPerformanceOverlay: widget.showPerformanceOverlay,
            showSemanticsDebugger: widget.showSemanticsDebugger,
            debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
            shortcuts: widget.shortcuts,
            actions: widget.actions,
            restorationScopeId: widget.restorationScopeId,
            localizationsDelegates: localizationsDelegates,
          ),
        );
    }
  }
}

/// Describes how [Scrollable] widgets behave for [TwixApp]s.
///
/// {@macro flutter.widgets.scrollBehavior}
///
/// When using the desktop platform, if the [Scrollable] widget scrolls in the
/// [Axis.vertical], a [Scrollbar] is applied.
///
/// See also:
///
///  * [ScrollBehavior], the default scrolling behavior extended by this class.
/// By default we will use [CupertinoScrollbar] for iOS and macOS platforms
/// for windows and Linux [Scrollbar]
/// for Android and Fuchsia we will return the child
class TwixScrollBehavior extends ScrollBehavior {
  /// Creates a TwixScrollBehavior that decorates [Scrollable]s with
  /// [Scrollbar]s based on the current platform and provided
  /// [ScrollableDetails].
  const TwixScrollBehavior();

  @override
  Widget buildScrollbar(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    switch (axisDirectionToAxis(details.direction)) {
      case Axis.horizontal:
        return child;
      case Axis.vertical:
        switch (getPlatform(context)) {
          case TargetPlatform.macOS:
          case TargetPlatform.iOS:
            return CupertinoScrollbar(
              controller: details.controller,
              child: child,
            );
          case TargetPlatform.linux:
          case TargetPlatform.windows:
            return Scrollbar(
              controller: details.controller,
              child: child,
            );
          case TargetPlatform.android:
          case TargetPlatform.fuchsia:
            return child;
        }
    }
  }
}
