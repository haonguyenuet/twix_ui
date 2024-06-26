import 'package:flutter/material.dart';
import 'package:twix_ui/src/theme/widget_theme/decorator.dart';
import 'package:twix_ui/src/widgets/checkbox.dart';
import 'package:twix_ui/src/widgets/form/field.dart';

class TwixCheckboxFormField extends TwixFormFieldBuilder<bool> {
  TwixCheckboxFormField({
    super.id,
    super.key,
    super.onSaved,
    super.label,
    super.error,
    super.description,
    void Function(bool)? onChanged,
    super.valueTransformer,
    super.onReset,
    super.enabled,
    super.autovalidateMode,
    super.restorationId,
    required bool initialValue,
    super.focusNode,
    TwixDecoration? decoration,
    String? Function(bool)? validator,
    double? size,
    Duration? duration,
    Widget? icon,
    Color? color,
    Widget? title,
    Widget? subTitle,
    EdgeInsets? padding,
    TextDirection? direction,
  }) : super(
          initialValue: initialValue,
          onChanged: onChanged == null ? null : (v) => onChanged(v ?? false),
          validator: validator == null ? null : (v) => validator(v ?? false),
          builder: (field) {
            final state = field as _TwixFormBuilderCheckboxState;
            return TwixCheckbox(
              checked: state.value!,
              onChanged: state.didChange,
              enabled: state.enabled,
              size: size,
              duration: duration,
              icon: icon,
              color: color,
              title: title,
              subTitle: subTitle,
              padding: padding,
              direction: direction,
              decoration: decoration,
            );
          },
        );

  @override
  TwixFormFieldBuilderState<TwixCheckboxFormField, bool> createState() => _TwixFormBuilderCheckboxState();
}

class _TwixFormBuilderCheckboxState extends TwixFormFieldBuilderState<TwixCheckboxFormField, bool> {}
