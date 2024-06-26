import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:twix_ui/src/theme/widget_theme/decorator.dart';
import 'package:twix_ui/src/widgets/portal.dart';

const kDefaultSelectMinWidth = 128.0;
const kDefaultSelectMaxHeight = 384.0;

@immutable
class TwixSelectTheme {
  const TwixSelectTheme({
    this.merge = true,
    this.decoration,
    this.minWidth = kDefaultSelectMinWidth,
    this.maxHeight = kDefaultSelectMaxHeight,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    this.optionsPadding = const EdgeInsets.all(4),
    this.showScrollToTopChevron = true,
    this.showScrollToBottomChevron = true,
    this.anchor = const TwixAnchor(
      childAlignment: Alignment.bottomLeft,
      overlayAlignment: Alignment.topLeft,
      offset: Offset.zero,
    ),
    this.searchPadding,
    this.clearSearchOnClose,
  });

  final bool merge;
  final TwixDecoration? decoration;
  final double minWidth;
  final double maxHeight;
  final EdgeInsets padding;
  final EdgeInsets optionsPadding;
  final bool showScrollToTopChevron;
  final bool showScrollToBottomChevron;
  final TwixAnchorBase anchor;
  final EdgeInsets? searchPadding;
  final bool? clearSearchOnClose;

  static TwixSelectTheme lerp(
    TwixSelectTheme a,
    TwixSelectTheme b,
    double t,
  ) {
    if (identical(a, b)) return a;
    return TwixSelectTheme(
      merge: b.merge,
      decoration: TwixDecoration.lerp(a.decoration, b.decoration, t),
      minWidth: lerpDouble(a.minWidth, b.minWidth, t)!,
      maxHeight: lerpDouble(a.maxHeight, b.maxHeight, t)!,
      padding: EdgeInsets.lerp(a.padding, b.padding, t)!,
      optionsPadding: EdgeInsets.lerp(a.optionsPadding, b.optionsPadding, t)!,
      showScrollToTopChevron: b.showScrollToTopChevron,
      showScrollToBottomChevron: b.showScrollToBottomChevron,
      anchor: b.anchor,
      searchPadding: EdgeInsets.lerp(a.searchPadding, b.searchPadding, t),
      clearSearchOnClose: t < 0.5 ? a.clearSearchOnClose : b.clearSearchOnClose,
    );
  }

  TwixSelectTheme mergeWith(TwixSelectTheme? other) {
    if (other == null) return this;
    if (!other.merge) return other;
    return copyWith(
      decoration: decoration?.mergeWith(other.decoration) ?? other.decoration,
      minWidth: other.minWidth,
      maxHeight: other.maxHeight,
      padding: other.padding,
      optionsPadding: other.optionsPadding,
      showScrollToTopChevron: other.showScrollToTopChevron,
      showScrollToBottomChevron: other.showScrollToBottomChevron,
      anchor: other.anchor,
      searchPadding: other.searchPadding,
      clearSearchOnClose: other.clearSearchOnClose,
    );
  }

  TwixSelectTheme copyWith({
    bool? merge,
    TwixDecoration? decoration,
    double? minWidth,
    double? maxHeight,
    EdgeInsets? padding,
    EdgeInsets? optionsPadding,
    bool? showScrollToTopChevron,
    bool? showScrollToBottomChevron,
    TwixAnchorBase? anchor,
    EdgeInsets? searchPadding,
    bool? clearSearchOnClose,
  }) {
    return TwixSelectTheme(
      merge: merge ?? this.merge,
      decoration: decoration ?? this.decoration,
      minWidth: minWidth ?? this.minWidth,
      maxHeight: maxHeight ?? this.maxHeight,
      padding: padding ?? this.padding,
      optionsPadding: optionsPadding ?? this.optionsPadding,
      showScrollToTopChevron: showScrollToTopChevron ?? this.showScrollToTopChevron,
      showScrollToBottomChevron: showScrollToBottomChevron ?? this.showScrollToBottomChevron,
      anchor: anchor ?? this.anchor,
      searchPadding: searchPadding ?? this.searchPadding,
      clearSearchOnClose: clearSearchOnClose ?? this.clearSearchOnClose,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TwixSelectTheme &&
        other.merge == merge &&
        other.decoration == decoration &&
        other.minWidth == minWidth &&
        other.maxHeight == maxHeight &&
        other.padding == padding &&
        other.optionsPadding == optionsPadding &&
        other.showScrollToTopChevron == showScrollToTopChevron &&
        other.showScrollToBottomChevron == showScrollToBottomChevron &&
        other.anchor == anchor &&
        other.searchPadding == searchPadding &&
        other.clearSearchOnClose == clearSearchOnClose;
  }

  @override
  int get hashCode {
    return merge.hashCode ^
        decoration.hashCode ^
        minWidth.hashCode ^
        maxHeight.hashCode ^
        padding.hashCode ^
        optionsPadding.hashCode ^
        showScrollToTopChevron.hashCode ^
        showScrollToBottomChevron.hashCode ^
        anchor.hashCode ^
        searchPadding.hashCode ^
        clearSearchOnClose.hashCode;
  }
}
