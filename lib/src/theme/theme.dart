import 'package:flutter/widgets.dart';
import 'package:twix_ui/src/theme/theme_data.dart';

class TwixTheme extends StatelessWidget {
  const TwixTheme({
    super.key,
    required this.child,
    required this.data,
  });

  final Widget child;
  final TwixThemeData data;

  static TwixThemeData of(BuildContext context, {bool listen = true}) {
    return maybeOf(context, listen: listen)!;
  }

  static TwixThemeData? maybeOf(
    BuildContext context, {
    bool listen = true,
  }) {
    if (listen) {
      return context.dependOnInheritedWidgetOfExactType<TwixInheritedTheme>()?.theme.data;
    }
    final provider = context.getElementForInheritedWidgetOfExactType<TwixInheritedTheme>()?.widget;
    return (provider as TwixInheritedTheme?)?.theme.data;
  }

  @override
  Widget build(BuildContext context) {
    return TwixInheritedTheme(
      theme: this,
      child: child,
    );
  }
}

class TwixInheritedTheme extends InheritedTheme {
  const TwixInheritedTheme({
    super.key,
    required this.theme,
    required super.child,
  });

  final TwixTheme theme;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return TwixTheme(data: theme.data, child: child);
  }

  @override
  bool updateShouldNotify(TwixInheritedTheme oldWidget) => theme.data != oldWidget.theme.data;
}

/// An interpolation between two [TwixThemeData]s.
///
/// This class specializes the interpolation of [Tween<TwixThemeData>] to call
/// the [TwixThemeData.lerp] method.
///
/// See [Tween] for a discussion on how to use interpolation objects.
class TwixThemeDataTween extends Tween<TwixThemeData> {
  /// Creates a [TwixThemeData] tween.
  ///
  /// The [begin] and [end] properties must be non-null before the tween is
  /// first used, but the arguments can be null if the values are going to be
  /// filled in later.
  TwixThemeDataTween({super.begin, super.end});

  @override
  TwixThemeData lerp(double t) => TwixThemeData.lerp(begin!, end!, t);
}

/// Animated version of [TwixTheme] which automatically transitions the colors
/// etc, over a given duration whenever the given theme changes.
class TwixAnimatedTheme extends ImplicitlyAnimatedWidget {
  /// Creates an animated theme.
  ///
  /// By default, the theme transition uses a linear curve.
  const TwixAnimatedTheme({
    super.key,
    required this.data,
    required this.child,
    super.curve,
    super.duration = const Duration(milliseconds: 200),
    super.onEnd,
  });

  /// Specifies the color and typography values for descendant widgets.
  final TwixThemeData data;

  /// The widget below this widget in the tree.
  final Widget child;

  @override
  AnimatedWidgetBaseState<TwixAnimatedTheme> createState() => _TwixAnimatedThemeState();
}

class _TwixAnimatedThemeState extends AnimatedWidgetBaseState<TwixAnimatedTheme> {
  TwixThemeDataTween? _data;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _data = visitor(
      _data,
      widget.data,
      (dynamic value) => TwixThemeDataTween(begin: value as TwixThemeData),
    )! as TwixThemeDataTween;
  }

  @override
  Widget build(BuildContext context) {
    return TwixTheme(
      data: _data!.evaluate(animation),
      child: widget.child,
    );
  }
}
