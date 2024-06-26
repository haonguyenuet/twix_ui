import 'package:flutter/material.dart';
import 'package:twix_ui/src/widgets/form/field.dart';
import 'package:twix_ui/src/widgets/radio.dart';

class TwixRadioGroupFormField<T> extends TwixFormFieldBuilder<T> {
  TwixRadioGroupFormField({
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
    required Iterable<Widget> items,
  }) : super(
          builder: (field) {
            final state = field as _TwixFormBuilderRadioGroupState;
            return TwixRadioGroup(
              items: items,
              onChanged: state.didChange,
              enabled: enabled,
              initialValue: initialValue,
            );
          },
        );

  @override
  TwixFormFieldBuilderState<TwixRadioGroupFormField<T>, T> createState() => _TwixFormBuilderRadioGroupState<T>();
}

class _TwixFormBuilderRadioGroupState<T> extends TwixFormFieldBuilderState<TwixRadioGroupFormField<T>, T> {}
