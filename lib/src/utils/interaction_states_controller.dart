import 'package:flutter/widgets.dart';

enum TwixInteractionState {
  hovered,
  pressed,
  disabled,
}

class TwixInteractionStatesController extends ValueNotifier<Set<TwixInteractionState>> {
  TwixInteractionStatesController([Set<TwixInteractionState>? value]) : super(<TwixInteractionState>{...?value});

  /// Adds [state] to [value] if [add] is true, and removes it otherwise,
  /// and notifies listeners if [value] has changed.
  void update(TwixInteractionState state, bool add) {
    final valueChanged = add ? value.add(state) : value.remove(state);
    if (valueChanged) {
      notifyListeners();
    }
  }
}
