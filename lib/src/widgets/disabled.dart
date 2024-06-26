import 'package:flutter/widgets.dart';
import 'package:twix_ui/src/theme/theme.dart';

class TwixDisabled extends StatelessWidget {
  const TwixDisabled({
    super.key,
    required this.disabled,
    required this.child,
    this.showForbiddenCursor = false,
    this.opacity,
  });

  final bool disabled;
  final bool showForbiddenCursor;
  final double? opacity;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = TwixTheme.of(context);

    Widget processedChild = AbsorbPointer(
      absorbing: disabled,
      child: child,
    );

    if (showForbiddenCursor && disabled) {
      processedChild = MouseRegion(cursor: SystemMouseCursors.forbidden, child: processedChild);
    }

    final effectiveDisabledOpacity = opacity ?? theme.disabledOpacity;

    return Opacity(
      opacity: disabled ? effectiveDisabledOpacity : 1,
      child: processedChild,
    );
  }
}
