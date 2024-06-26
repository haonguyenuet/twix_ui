import 'package:flutter/material.dart';
import 'package:twix_ui/src/utils/provider.dart';

class TwixCursorController extends ChangeNotifier {
  TwixCursorController({MouseCursor cursor = MouseCursor.defer}) : _cursor = cursor;

  late MouseCursor _cursor;

  MouseCursor get cursor => _cursor;

  set cursor(MouseCursor cursor) {
    if (cursor == _cursor) return;
    _cursor = cursor;
    notifyListeners();
  }
}

class TwixCursorProvider extends StatefulWidget {
  const TwixCursorProvider({super.key, this.controller, required this.child});

  final Widget child;
  final TwixCursorController? controller;

  @override
  State<TwixCursorProvider> createState() => TwixCursorProviderState();
}

class TwixCursorProviderState extends State<TwixCursorProvider> {
  TwixCursorController? _internalController;

  TwixCursorController get _effectiveController {
    return widget.controller ?? (_internalController ??= TwixCursorController());
  }

  @override
  void dispose() {
    _internalController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TwixProvider(
      data: _effectiveController,
      child: ListenableBuilder(
        listenable: _effectiveController,
        builder: (context, child) {
          return MouseRegion(
            cursor: _effectiveController.cursor,
            child: child,
          );
        },
        child: widget.child,
      ),
    );
  }
}
