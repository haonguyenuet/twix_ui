import 'package:flutter/material.dart';
import 'package:twix_ui/twix_ui.dart';

extension BuildContextExt on BuildContext {
  TwixTextTheme get typography => TwixTheme.of(this).textTheme;

  TwixColorScheme get colors => TwixTheme.of(this).colorScheme;
}
