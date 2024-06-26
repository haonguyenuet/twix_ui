import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:twix_ui/src/theme/theme.dart';
import 'package:twix_ui/src/theme/widget_theme/decorator.dart';
import 'package:twix_ui/src/utils/focusable.dart';
import 'package:twix_ui/src/utils/gesture_detector.dart';
import 'package:twix_ui/src/widgets/disabled.dart';
import 'package:twix_ui/src/widgets/image.dart';
import 'package:twix_ui/src/widgets/input.dart';
import 'package:twix_ui/src/widgets/popover.dart';
import 'package:twix_ui/src/widgets/portal.dart';

typedef TwixSelectedOptionBuilder<T> = Widget Function(BuildContext context, T value);

enum TwixSelectType { primary, searchable }

class TwixSelect<T> extends StatefulWidget {
  const TwixSelect({
    super.key,
    required this.options,
    required this.selectedOptionBuilder,
    this.enabled = true,
    this.placeholder,
    this.initialValue,
    this.onChanged,
    this.focusNode,
    this.closeOnTapOutside = true,
    this.minWidth,
    this.maxHeight,
    this.decoration,
    this.trailing,
    this.padding,
    this.optionsPadding,
    this.showScrollToBottomChevron,
    this.showScrollToTopChevron,
    this.scrollController,
    this.anchor,
  })  : type = TwixSelectType.primary,
        onSearchChanged = null,
        searchDivider = null,
        searchPlaceholder = null,
        searchInputPrefix = null,
        searchPadding = null,
        customSearchInput = null,
        clearSearchOnClose = false;

  const TwixSelect.withSearch({
    super.key,
    required this.options,
    required this.selectedOptionBuilder,
    required ValueChanged<String> this.onSearchChanged,
    this.searchDivider,
    this.searchInputPrefix,
    this.searchPlaceholder,
    this.searchPadding,
    this.customSearchInput,
    this.clearSearchOnClose,
    this.enabled = true,
    this.placeholder,
    this.initialValue,
    this.onChanged,
    this.focusNode,
    this.closeOnTapOutside = true,
    this.minWidth,
    this.maxHeight,
    this.decoration,
    this.trailing,
    this.padding,
    this.optionsPadding,
    this.showScrollToBottomChevron,
    this.showScrollToTopChevron,
    this.scrollController,
    this.anchor,
  }) : type = TwixSelectType.searchable;

  final ValueChanged<T>? onChanged;
  final bool enabled;
  final T? initialValue;
  final Widget? placeholder;
  final TwixSelectedOptionBuilder<T> selectedOptionBuilder;
  final Iterable<Widget> options;
  final FocusNode? focusNode;

  /// Whether to close the [TwixSelect] when the user taps outside of it,
  /// defaults to `true`.
  final bool closeOnTapOutside;

  /// The minimum width of the [TwixSelect], defaults to
  /// `max(kDefaultSelectMinWidth, constraints.minWidth)`.
  ///
  /// This value is not guaranteed to be respected, because the effective
  /// minWidth is calculated from the max of this value and the min width of the
  /// view itself.
  final double? minWidth;

  /// The maximum height of the [TwixSelect], defaults to
  /// `kDefaultSelectMaxHeight`.
  final double? maxHeight;

  final TwixDecoration? decoration;

  final Widget? trailing;
  final EdgeInsets? padding;
  final EdgeInsets? optionsPadding;
  final bool? showScrollToTopChevron;
  final bool? showScrollToBottomChevron;
  final ScrollController? scrollController;
  final TwixAnchorBase? anchor;
  final TwixSelectType type;

  /// The callback that is called when the search value changes.
  final ValueChanged<String>? onSearchChanged;

  /// The widget that is displayed between the search input and the options.
  final Widget? searchDivider;

  final Widget? searchInputPrefix;
  final Widget? searchPlaceholder;
  final EdgeInsets? searchPadding;
  final Widget? customSearchInput;
  final bool? clearSearchOnClose;

  @override
  TwixSelectState<T> createState() => TwixSelectState();

  static TwixSelectState<T> of<T>(BuildContext context) {
    return maybeOf<T>(context)!;
  }

  static TwixSelectState<T>? maybeOf<T>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TwixSelectInheritedWidget<T>>()?.data;
  }
}

class TwixSelectState<T> extends State<TwixSelect<T>> {
  final TwixPopoverController _popoverController = TwixPopoverController();

  final ValueNotifier _showScrollToBottom = ValueNotifier(false);
  final ValueNotifier _showScrollToTop = ValueNotifier(false);
  bool _shouldAnimateToTop = false;
  bool _shouldAnimateToBottom = false;

  ScrollController? _scrollController;
  ScrollController get _effectiveScrollController => widget.scrollController ?? _scrollController!;

  FocusNode? _focusNode;
  FocusNode get _effectiveFocusNode => widget.focusNode ?? (_focusNode ??= FocusNode());

  late T? _selectedValue = widget.initialValue;

  @override
  void initState() {
    super.initState();
    if (widget.scrollController == null) {
      _scrollController = ScrollController();
    }
    _effectiveScrollController.addListener(_scrollControllerListener);
    _popoverController.addListener(_popoverControllerListener);
  }

  void _scrollControllerListener() {
    if (!_effectiveScrollController.hasClients) return;
    _showScrollToBottom.value = _effectiveScrollController.offset < _effectiveScrollController.position.maxScrollExtent;
    _showScrollToTop.value = _effectiveScrollController.offset > 0;
  }

  void _popoverControllerListener() {
    if (_popoverController.isOpen) return;
    final effectiveClearSearchOnClose =
        widget.clearSearchOnClose ?? TwixTheme.of(context, listen: false).selectTheme.clearSearchOnClose ?? true;

    if (effectiveClearSearchOnClose) {
      widget.onSearchChanged?.call('');
    }
  }

  @override
  void didUpdateWidget(covariant TwixSelect<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      _selectedValue = widget.initialValue;
    }
  }

  @override
  void dispose() {
    _focusNode?.dispose();
    _popoverController.removeListener(_popoverControllerListener);
    _popoverController.dispose();
    _scrollController?.removeListener(_scrollControllerListener);
    _scrollController?.dispose();
    _showScrollToBottom.dispose();
    _showScrollToTop.dispose();
    super.dispose();
  }

  Future<void> _animateToTop() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    while (_shouldAnimateToTop) {
      _shouldAnimateToTop = _effectiveScrollController.offset > 0;
      await _effectiveScrollController.animateTo(
        max(_effectiveScrollController.offset - 30, 0),
        duration: const Duration(milliseconds: 20),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  Future<void> _animateToBottom() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    while (_shouldAnimateToBottom) {
      final maxScrollExtent = _effectiveScrollController.position.maxScrollExtent;
      _shouldAnimateToBottom = _effectiveScrollController.offset < maxScrollExtent;
      await _effectiveScrollController.animateTo(
        min(_effectiveScrollController.offset + 30, maxScrollExtent),
        duration: const Duration(milliseconds: 20),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _onSelect(T value, {bool hidePopover = true}) {
    final isChanged = value != _selectedValue;
    setState(() {
      if (hidePopover) _popoverController.hide();
      _selectedValue = value;
    });
    _effectiveFocusNode.requestFocus();
    if (isChanged) widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = TwixTheme.of(context);
    final effectiveDecoration = (theme.selectTheme.decoration ?? const TwixDecoration()).mergeWith(widget.decoration);
    final effectiveBorderPadding = effectiveDecoration.border?.padding?.horizontal ?? 0.0;
    final effectivePadding = widget.padding ?? theme.selectTheme.padding;
    final effectiveShowScrollToTopChevron = widget.showScrollToTopChevron ?? theme.selectTheme.showScrollToTopChevron;
    final effectiveShowScrollToBottomChevron =
        widget.showScrollToBottomChevron ?? theme.selectTheme.showScrollToBottomChevron;
    final effectiveAnchor = widget.anchor ?? theme.selectTheme.anchor;

    final Widget effectiveText;
    if (_selectedValue is T) {
      effectiveText = widget.selectedOptionBuilder(context, _selectedValue as T);
    } else {
      assert(
        widget.placeholder != null,
        'placeholder must not be null when value is null',
      );
      effectiveText = widget.placeholder!;
    }

    final effectiveTrailing = widget.trailing ??
        TwixIconImage.square(
          LucideIcons.chevronDown,
          size: 16,
          color: theme.colorScheme.popoverForeground.withOpacity(.5),
        );

    final effectiveMinWidth = widget.minWidth ?? theme.selectTheme.minWidth;
    final effectiveMaxHeight = widget.maxHeight ?? theme.selectTheme.maxHeight;
    final effectiveOptionsPadding = widget.optionsPadding ?? theme.selectTheme.optionsPadding;

    final searchInput = switch (widget.type) {
      TwixSelectType.primary => null,
      TwixSelectType.searchable => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.customSearchInput ??
                TwixInput(
                  prefix: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Icon(
                      LucideIcons.search,
                      size: 16,
                      color: theme.colorScheme.popoverForeground,
                    ),
                  ),
                  padding: widget.searchPadding ?? theme.selectTheme.searchPadding ?? const EdgeInsets.all(12),
                  placeholder: widget.searchPlaceholder,
                  decoration: TwixDecoration.none,
                  onChanged: widget.onSearchChanged,
                ),
            widget.searchDivider ?? const Divider(height: 1),
          ],
        ),
    };

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.enter): _popoverController.toggle,
        const SingleActivator(LogicalKeyboardKey.escape): _popoverController.hide,
      },
      child: FocusTraversalGroup(
        policy: WidgetOrderTraversalPolicy(),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final calculatedMinWidth = max(effectiveMinWidth, constraints.minWidth) - effectiveBorderPadding;
            final select = TwixDisabled(
              disabled: !widget.enabled,
              child: TwixFocusable(
                canRequestFocus: widget.enabled,
                focusNode: _effectiveFocusNode,
                builder: (context, focused, child) {
                  return TwixDecorator(
                    isFocused: focused,
                    decoration: effectiveDecoration,
                    child: child,
                  );
                },
                child: TwixGestureDetector(
                  cursor: SystemMouseCursors.click,
                  behavior: HitTestBehavior.opaque,
                  onTap: _popoverController.toggle,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: calculatedMinWidth),
                    child: Padding(
                      padding: effectivePadding,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(child: effectiveText),
                          effectiveTrailing,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );

            final scrollToTopChevron = effectiveShowScrollToTopChevron
                ? ValueListenableBuilder(
                    valueListenable: _showScrollToTop,
                    builder: (context, show, child) {
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: show
                            ? MouseRegion(
                                onEnter: (_) {
                                  _shouldAnimateToTop = true;
                                  _animateToTop();
                                },
                                onExit: (_) => _shouldAnimateToTop = false,
                                child: Container(
                                  width: calculatedMinWidth,
                                  padding: const EdgeInsets.symmetric(vertical: 4),
                                  child: TwixIconImage.square(
                                    LucideIcons.chevronUp,
                                    size: 16,
                                    color: theme.colorScheme.popoverForeground,
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      );
                    },
                  )
                : null;

            final scrollToBottomChevron = effectiveShowScrollToBottomChevron
                ? ValueListenableBuilder(
                    valueListenable: _showScrollToBottom,
                    builder: (context, show, child) {
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: show
                            ? MouseRegion(
                                onEnter: (_) {
                                  _shouldAnimateToBottom = true;
                                  _animateToBottom();
                                },
                                onExit: (_) => _shouldAnimateToBottom = false,
                                child: Container(
                                  width: calculatedMinWidth,
                                  padding: const EdgeInsets.symmetric(vertical: 4),
                                  child: TwixIconImage.square(
                                    LucideIcons.chevronDown,
                                    size: 16,
                                    color: theme.colorScheme.popoverForeground,
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      );
                    },
                  )
                : null;

            return TwixSelectInheritedWidget(
              data: this,
              child: TwixPopover(
                padding: EdgeInsets.zero,
                controller: _popoverController,
                anchor: effectiveAnchor,
                closeOnTapOutside: widget.closeOnTapOutside,
                popoverBuilder: (_) {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    if (_effectiveScrollController.hasClients) {
                      final maxScrollExtent = _effectiveScrollController.position.maxScrollExtent;
                      _showScrollToBottom.value = _effectiveScrollController.offset < maxScrollExtent;
                      _showScrollToTop.value = _effectiveScrollController.offset > 0;
                    }
                  });

                  return ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: effectiveMaxHeight),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (searchInput != null)
                          Flexible(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(minWidth: calculatedMinWidth),
                              child: IntrinsicWidth(child: searchInput),
                            ),
                          ),
                        if (scrollToTopChevron != null) scrollToTopChevron,
                        Flexible(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(minWidth: calculatedMinWidth),
                            child: SingleChildScrollView(
                              padding: effectiveOptionsPadding,
                              controller: _effectiveScrollController,
                              child: IntrinsicWidth(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  mainAxisSize: MainAxisSize.min,
                                  children: widget.options.toList(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (scrollToBottomChevron != null) scrollToBottomChevron,
                      ],
                    ),
                  );
                },
                child: select,
              ),
            );
          },
        ),
      ),
    );
  }
}

class TwixSelectInheritedWidget<T> extends InheritedWidget {
  const TwixSelectInheritedWidget({
    super.key,
    required this.data,
    required super.child,
  });

  final TwixSelectState<T> data;

  @override
  bool updateShouldNotify(covariant TwixSelectInheritedWidget<T> oldWidget) {
    return true;
  }
}

class TwixOption<T> extends StatefulWidget {
  const TwixOption({
    super.key,
    required this.value,
    required this.child,
    this.hoveredBackgroundColor,
    this.padding,
    this.selectedIcon,
    this.radius,
  });

  final T value;
  final Widget child;
  final Color? hoveredBackgroundColor;
  final EdgeInsets? padding;
  final Widget? selectedIcon;
  final BorderRadius? radius;

  @override
  State<TwixOption<T>> createState() => _TwixOptionStateDefault<T>();
}

class _TwixOptionStateDefault<T> extends State<TwixOption<T>> {
  final ValueNotifier _isHovered = ValueNotifier(false);

  @override
  void dispose() {
    _isHovered.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = TwixTheme.of(context);
    final parentSelect = TwixSelect.of<T>(context);
    final selected = parentSelect._selectedValue == widget.value;

    if (selected) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        Scrollable.maybeOf(context)?.position.ensureVisible(context.findRenderObject()!);
      });
    }

    final effectiveHoveredBackgroundColor =
        widget.hoveredBackgroundColor ?? theme.optionTheme.hoveredBackgroundColor ?? theme.colorScheme.accent;
    final effectivePadding =
        widget.padding ?? theme.optionTheme.padding ?? const EdgeInsets.symmetric(horizontal: 8, vertical: 6);
    final effectiveRadius = widget.radius ?? theme.optionTheme.radius ?? theme.radius;

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.enter): () {
          parentSelect._onSelect(widget.value);
        },
      },
      child: TwixGestureDetector(
        behavior: HitTestBehavior.opaque,
        cursor: SystemMouseCursors.click,
        onHoverChange: (value) => _isHovered.value = value,
        onTap: () => parentSelect._onSelect(widget.value),
        child: ValueListenableBuilder(
          valueListenable: _isHovered,
          builder: (context, hovered, child) {
            return Container(
              padding: effectivePadding,
              decoration: BoxDecoration(
                color: hovered ? effectiveHoveredBackgroundColor : null,
                borderRadius: effectiveRadius,
              ),
              child: child,
            );
          },
          child: Row(
            children: [
              widget.selectedIcon ??
                  Visibility.maintain(
                    visible: selected,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: TwixIconImage.square(
                        LucideIcons.check,
                        size: 16,
                        color: theme.colorScheme.popoverForeground,
                      ),
                    ),
                  ),
              Flexible(
                child: DefaultTextStyle(
                  style: theme.textTheme.bodyMedium.copyWith(color: theme.colorScheme.popoverForeground),
                  child: widget.child,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
