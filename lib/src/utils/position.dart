import 'package:flutter/widgets.dart';

@immutable
class TwixPosition {
  const TwixPosition({
    this.top,
    this.left,
    this.right,
    this.bottom,
  });

  final double? top;
  final double? left;
  final double? right;
  final double? bottom;

  static TwixPosition? lerp(
    TwixPosition? a,
    TwixPosition? b,
    double t,
  ) {
    if (identical(a, b)) return a;
    return TwixPosition(
      top: b?.top,
      left: b?.left,
      right: b?.right,
      bottom: b?.bottom,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TwixPosition &&
        other.top == top &&
        other.left == left &&
        other.right == right &&
        other.bottom == bottom;
  }

  @override
  int get hashCode => Object.hashAll([top, left, right, bottom]);
}

extension PositionedExt on Widget {
  Widget positionedWith(TwixPosition position) {
    return Positioned(
      top: position.top,
      left: position.left,
      right: position.right,
      bottom: position.bottom,
      child: this,
    );
  }
}
