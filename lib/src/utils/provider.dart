import 'package:flutter/cupertino.dart';

extension ProviderExt on BuildContext {
  T twixRead<T>() => TwixProvider.of<T>(this, listen: false);

  T twixWatch<T>() => TwixProvider.of<T>(this);
}

class TwixProvider<T> extends InheritedWidget {
  const TwixProvider({
    super.key,
    required super.child,
    required this.data,
    this.notifyUpdate,
  });

  final T data;
  final bool Function(TwixProvider<T> oldWidget)? notifyUpdate;

  static T of<T>(BuildContext context, {bool listen = true}) {
    final inherited = maybeOf<T>(context, listen: listen);
    if (inherited == null) {
      throw FlutterError(
        'Could not find $T InheritedWidget in the ancestor widget tree.',
      );
    }
    return inherited;
  }

  static T? maybeOf<T>(BuildContext context, {bool listen = true}) {
    if (listen) {
      return context.dependOnInheritedWidgetOfExactType<TwixProvider<T>>()?.data;
    }
    final provider = context.getElementForInheritedWidgetOfExactType<TwixProvider<T>>()?.widget;
    return (provider as TwixProvider<T>?)?.data;
  }

  @override
  bool updateShouldNotify(covariant TwixProvider<T> oldWidget) {
    return notifyUpdate?.call(oldWidget) ?? false;
  }
}
