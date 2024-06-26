import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:twix_ui/src/theme/theme.dart';

class TwixBreakpoints {
  TwixBreakpoints({
    double tiny = 0,
    double small = 640,
    double medium = 768,
    double large = 1024,
    double extraLarge = 1280,
    double extraExtraLarge = 1536,
  })  : tiny = TwixBreakpointTiny(tiny),
        small = TwixBreakpointSmall(small),
        medium = TwixBreakpointMedium(medium),
        large = TwixBreakpointLarge(large),
        extraLarge = TwixBreakpointExtraLarge(extraLarge),
        extraExtraLarge = TwixBreakpointExtraExtraLarge(extraExtraLarge);

  final TwixBreakpoint tiny;
  final TwixBreakpoint small;
  final TwixBreakpoint medium;
  final TwixBreakpoint large;
  final TwixBreakpoint extraLarge;
  final TwixBreakpoint extraExtraLarge;

  TwixBreakpoint fromWidth(double width) {
    if (width < small.value) return tiny;
    if (width < medium.value) return small;
    if (width < large.value) return medium;
    if (width < extraLarge.value) return large;
    if (width < extraExtraLarge.value) return extraLarge;
    return extraExtraLarge;
  }

  static TwixBreakpoints lerp(
    TwixBreakpoints? a,
    TwixBreakpoints? b,
    double t,
  ) {
    return TwixBreakpoints(
      tiny: TwixBreakpoint.lerp(a!.tiny, b!.tiny, t),
      small: TwixBreakpoint.lerp(a.small, b.small, t),
      medium: TwixBreakpoint.lerp(a.medium, b.medium, t),
      large: TwixBreakpoint.lerp(a.large, b.large, t),
      extraLarge: TwixBreakpoint.lerp(a.extraLarge, b.extraLarge, t),
      extraExtraLarge: TwixBreakpoint.lerp(a.extraExtraLarge, b.extraExtraLarge, t),
    );
  }
}

sealed class TwixBreakpoint {
  const TwixBreakpoint(this.value);

  final double value;

  bool operator <(TwixBreakpoint other) {
    return value < other.value;
  }

  bool operator >(TwixBreakpoint other) {
    return value > other.value;
  }

  bool operator <=(TwixBreakpoint other) {
    return value <= other.value;
  }

  bool operator >=(TwixBreakpoint other) {
    return value >= other.value;
  }

  static double lerp(TwixBreakpoint a, TwixBreakpoint b, double t) {
    return lerpDouble(a.value, b.value, t)!;
  }
}

class TwixBreakpointTiny extends TwixBreakpoint {
  const TwixBreakpointTiny(super.value);
}

class TwixBreakpointSmall extends TwixBreakpoint {
  const TwixBreakpointSmall(super.value);
}

class TwixBreakpointMedium extends TwixBreakpoint {
  const TwixBreakpointMedium(super.value);
}

class TwixBreakpointLarge extends TwixBreakpoint {
  const TwixBreakpointLarge(super.value);
}

class TwixBreakpointExtraLarge extends TwixBreakpoint {
  const TwixBreakpointExtraLarge(super.value);
}

class TwixBreakpointExtraExtraLarge extends TwixBreakpoint {
  const TwixBreakpointExtraExtraLarge(super.value);
}

typedef ResponsiveWidgetBuilder = Widget Function(
  BuildContext context,
  TwixBreakpoint breakpoint,
);

class TwixResponsiveBuilder extends StatelessWidget {
  const TwixResponsiveBuilder({
    super.key,
    required this.builder,
  });

  final ResponsiveWidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final breakpoints = TwixTheme.of(context).breakpoints;
    final breakpoint = breakpoints.fromWidth(width);
    return builder(context, breakpoint);
  }
}
