import 'package:flutter/widgets.dart';
import 'package:twix_ui/src/theme/widget_theme/decorator.dart';
import 'package:twix_ui/src/widgets/form/form.dart';

typedef ValueTransformer<T> = dynamic Function(T value);

class TwixFormFieldBuilder<T> extends FormField<T> {
  TwixFormFieldBuilder({
    super.key,
    required Widget Function(FormFieldState<T>) builder,
    super.onSaved,
    super.validator,
    super.initialValue,
    super.enabled,
    super.autovalidateMode,
    super.restorationId,
    this.id,
    this.focusNode,
    this.label,
    this.error,
    this.description,
    this.onChanged,
    this.valueTransformer,
    this.onReset,
  }) : super(
          builder: (field) {
            final hasError = field.hasError;

            final effectiveError = hasError ? error ?? Text(field.errorText!) : null;

            return TwixDecorator(
              decoration: TwixDecoration.none,
              label: label,
              hasError: hasError,
              error: effectiveError,
              description: description,
              child: builder(field),
            );
          },
        );

  /// Used to reference the field within the form, or to reference form data
  /// after the form is submitted.
  final Object? id;
  final FocusNode? focusNode;
  final Widget? label;
  final Widget? error;
  final Widget? description;
  final ValueChanged<T?>? onChanged;
  final ValueTransformer<T?>? valueTransformer;
  final VoidCallback? onReset;

  @override
  TwixFormFieldBuilderState<TwixFormFieldBuilder<T>, T> createState() =>
      TwixFormFieldBuilderState<TwixFormFieldBuilder<T>, T>();
}

class TwixFormFieldBuilderState<F extends TwixFormFieldBuilder<T>, T> extends FormFieldState<T> {
  FocusNode? _focusNode;
  FocusNode get _effectiveFocusNode => widget.focusNode ?? _focusNode!;
  FocusNode get focusNode => _effectiveFocusNode;

  TwixFormState? _parentForm;

  @override
  F get widget => super.widget as F;

  T? get initialValue => widget.initialValue ?? (_parentForm?.widget.initialValue[widget.id] as T?);

  bool get enabled => widget.enabled && (_parentForm?.enabled ?? true);

  @override
  void initState() {
    super.initState();

    // Register this field when there is a parent ShadForm
    _parentForm = TwixForm.maybeOf(context);
    if (widget.id != null) _parentForm?.registerField(widget.id!, this);
    if (widget.focusNode == null) {
      _focusNode = FocusNode();
    }
  }

  @override
  void didUpdateWidget(covariant TwixFormFieldBuilder<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.id != oldWidget.id) {
      if (oldWidget.id != null) {
        _parentForm?.unregisterField(oldWidget.id!, this);
      }
      if (widget.id != null) _parentForm?.registerField(widget.id!, this);
    }
  }

  @override
  void didChange(T? value) {
    super.didChange(value);
    _informFieldChange();
    widget.onChanged?.call(value);
  }

  @override
  void reset() {
    super.reset();
    didChange(initialValue);
    widget.onReset?.call();
  }

  @override
  void dispose() {
    if (widget.id != null) _parentForm?.unregisterField(widget.id!, this);
    _focusNode?.dispose();
    super.dispose();
  }

  void focus() {
    FocusScope.of(context).requestFocus(_effectiveFocusNode);
  }

  void ensureVisible() {
    Scrollable.ensureVisible(context);
  }

  @override
  void setValue(T? value, {bool populateForm = true}) {
    super.setValue(value);
    if (populateForm) {
      _informFieldChange();
    }
  }

  void _informFieldChange() {
    if (_parentForm != null) {
      if (enabled) {
        if (widget.id != null) {
          _parentForm!.setInternalFieldValue<T>(widget.id!, value);
        }
        return;
      }
      if (widget.id != null) _parentForm!.removeInternalFieldValue(widget.id!);
    }
  }

  void registerTransformer(Map<Object, Function> map) {
    if (widget.id == null) return;
    final fun = widget.valueTransformer;
    if (fun != null) {
      map[widget.id!] = fun;
    }
  }
}
