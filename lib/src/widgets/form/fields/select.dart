import 'package:flutter/material.dart';
import 'package:twix_ui/src/theme/widget_theme/decorator.dart';
import 'package:twix_ui/src/widgets/form/field.dart';
import 'package:twix_ui/src/widgets/portal.dart';
import 'package:twix_ui/src/widgets/select.dart';

class TwixSelectFormField<T> extends TwixFormFieldBuilder<T> {
  TwixSelectFormField({
    super.id,
    super.key,
    super.onSaved,
    super.label,
    super.error,
    super.description,
    super.onChanged,
    super.valueTransformer,
    super.onReset,
    super.enabled,
    super.autovalidateMode,
    super.restorationId,
    super.initialValue,
    super.focusNode,
    super.validator,
    required TwixSelectedOptionBuilder<T> selectedOptionBuilder,
    required Iterable<Widget> options,
    Widget? placeholder,
    bool closeOnTapOutside = true,
    double? minWidth,
    double? maxHeight,
    TwixDecoration? decoration,
    Widget? trailing,
    EdgeInsets? padding,
    EdgeInsets? optionsPadding,
    bool? showScrollToTopChevron,
    bool? showScrollToBottomChevron,
    ScrollController? scrollController,
    TwixAnchorBase? anchor,
  }) : super(
          builder: (field) {
            final state = field as _TwixFormBuilderSelectState;
            return TwixSelect<T>(
              options: options,
              selectedOptionBuilder: selectedOptionBuilder,
              focusNode: state.focusNode,
              placeholder: placeholder,
              initialValue: initialValue,
              enabled: state.enabled,
              onChanged: state.didChange,
              closeOnTapOutside: closeOnTapOutside,
              anchor: anchor,
              minWidth: minWidth,
              maxHeight: maxHeight,
              decoration: decoration,
              trailing: trailing,
              padding: padding,
              optionsPadding: optionsPadding,
              showScrollToTopChevron: showScrollToTopChevron,
              showScrollToBottomChevron: showScrollToBottomChevron,
              scrollController: scrollController,
            );
          },
        );

  @override
  TwixFormFieldBuilderState<TwixSelectFormField<T>, T> createState() => _TwixFormBuilderSelectState<T>();
}

class _TwixFormBuilderSelectState<T> extends TwixFormFieldBuilderState<TwixSelectFormField<T>, T> {}
