import 'package:flutter/material.dart';

/// The position of the [TwixPortal] in the global coordinate system.
sealed class TwixAnchorBase {
  const TwixAnchorBase();
}

/// Automatically infers the position of the [TwixPortal] in the global
/// coordinate system adjusting according to the [verticalOffset] and
/// [preferBelow] properties.
class TwixAnchorAuto extends TwixAnchorBase {
  const TwixAnchorAuto({
    required this.verticalOffset,
    required this.preferBelow,
  });

  final double verticalOffset;
  final bool preferBelow;
}

/// Manually specifies the position of the [TwixPortal] in the global
/// coordinate system.
class TwixAnchor extends TwixAnchorBase {
  const TwixAnchor({
    required this.childAlignment,
    required this.overlayAlignment,
    required this.offset,
  });

  const TwixAnchor.center({
    this.childAlignment = Alignment.topCenter,
    this.overlayAlignment = Alignment.bottomCenter,
    this.offset = Offset.zero,
  });

  final Alignment childAlignment;
  final Alignment overlayAlignment;
  final Offset offset;

  TwixAnchor copyWith({
    Alignment? childAlignment,
    Alignment? overlayAlignment,
    Offset? offset,
  }) {
    return TwixAnchor(
      childAlignment: childAlignment ?? this.childAlignment,
      overlayAlignment: overlayAlignment ?? this.overlayAlignment,
      offset: offset ?? this.offset,
    );
  }
}

class TwixPortal extends StatefulWidget {
  const TwixPortal({
    super.key,
    required this.child,
    required this.portalBuilder,
    required this.visible,
    required this.anchor,
  });

  final Widget child;
  final WidgetBuilder portalBuilder;
  final bool visible;
  final TwixAnchorBase anchor;

  @override
  State<TwixPortal> createState() => _TwixPortalState();
}

class _TwixPortalState extends State<TwixPortal> {
  final LayerLink _layerLink = LayerLink();
  final OverlayPortalController _overlayPortalController = OverlayPortalController();

  @override
  void initState() {
    super.initState();
    _updateVisibility();
  }

  @override
  void didUpdateWidget(covariant TwixPortal oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateVisibility();
  }

  @override
  void dispose() {
    _hide();
    super.dispose();
  }

  void _updateVisibility() {
    WidgetsBinding.instance.addPostFrameCallback((timer) {
      widget.visible ? _show() : _hide();
    });
  }

  void _hide() {
    if (_overlayPortalController.isShowing) {
      _overlayPortalController.hide();
    }
  }

  void _show() {
    if (!_overlayPortalController.isShowing) {
      _overlayPortalController.show();
    }
  }

  Widget _buildAutoPosition(BuildContext context, TwixAnchorAuto anchor) {
    final overlayState = Overlay.of(context, debugRequiredFor: widget);
    final renderBox = this.context.findRenderObject()! as RenderBox;
    final target = renderBox.localToGlobal(
      renderBox.size.center(Offset.zero),
      ancestor: overlayState.context.findRenderObject(),
    );
    return CustomSingleChildLayout(
      delegate: TwixPositionDelegate(
        target: target,
        verticalOffset: anchor.verticalOffset,
        preferBelow: anchor.preferBelow,
      ),
      child: widget.portalBuilder(context),
    );
  }

  Widget _buildManualPosition(BuildContext context, TwixAnchor anchor) {
    return CompositedTransformFollower(
      link: _layerLink,
      offset: anchor.offset,
      followerAnchor: anchor.overlayAlignment,
      targetAnchor: anchor.childAlignment,
      child: widget.portalBuilder(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: OverlayPortal(
        controller: _overlayPortalController,
        overlayChildBuilder: (context) {
          return Material(
            type: MaterialType.transparency,
            child: Center(
              widthFactor: 1,
              heightFactor: 1,
              child: switch (widget.anchor) {
                final TwixAnchorAuto anchor => _buildAutoPosition(context, anchor),
                final TwixAnchor anchor => _buildManualPosition(context, anchor),
              },
            ),
          );
        },
        child: widget.child,
      ),
    );
  }
}

/// A delegate for computing the layout of an overlay to be displayed above or
/// below a target specified in the global coordinate system.
class TwixPositionDelegate extends SingleChildLayoutDelegate {
  /// Creates a delegate for computing the layout of an overlay.
  TwixPositionDelegate({
    required this.target,
    required this.verticalOffset,
    required this.preferBelow,
  });

  /// The offset of the target the overlay is positioned near in the global
  /// coordinate system.
  final Offset target;

  /// The amount of vertical distance between the target and the displayed
  /// overlay.
  final double verticalOffset;

  /// Whether the overlay is displayed below its widget by default.
  ///
  /// If there is insufficient space to display the tooltip in the preferred
  /// direction, the tooltip will be displayed in the opposite direction.
  final bool preferBelow;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) => constraints.loosen();

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return positionDependentBox(
      size: size,
      childSize: childSize,
      target: target,
      verticalOffset: verticalOffset,
      preferBelow: preferBelow,
    );
  }

  @override
  bool shouldRelayout(TwixPositionDelegate oldDelegate) {
    return target != oldDelegate.target ||
        verticalOffset != oldDelegate.verticalOffset ||
        preferBelow != oldDelegate.preferBelow;
  }
}
