import 'package:flutter/cupertino.dart';
import 'package:twix_ui/src/widgets/form/field.dart';

typedef TwixFormFields = Map<Object, TwixFormFieldBuilderState<TwixFormFieldBuilder<dynamic>, dynamic>>;

class TwixForm extends StatefulWidget {
  const TwixForm({
    super.key,
    required this.child,
    this.onChanged,
    this.canPop,
    this.onPopInvoked,
    this.autovalidateMode,
    this.initialValue = const {},
    this.enabled = true,
    this.skipDisabled = false,
  });

  final VoidCallback? onChanged;
  final bool? canPop;
  final void Function(bool)? onPopInvoked;
  final AutovalidateMode? autovalidateMode;
  final Map<Object, dynamic> initialValue;
  final bool enabled;
  final bool skipDisabled;
  final Widget child;

  @override
  State<TwixForm> createState() => TwixFormState();

  static TwixFormState of(BuildContext context) {
    final state = maybeOf(context);
    assert(state != null, 'No TwixFormState found in context');
    return state!;
  }

  static TwixFormState? maybeOf(BuildContext context) {
    return (context.getElementForInheritedWidgetOfExactType<TwixFormScope>()?.widget as TwixFormScope?)?._formState;
  }
}

class TwixFormState extends State<TwixForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TwixFormFields _fields = {};
  final Map<Object, dynamic> _value = {};
  final Map<Object, Function> _transformers = {};

  TwixFormFields get fields => _fields;

  Map<Object, dynamic> get initialValue => widget.initialValue;

  bool get enabled => widget.enabled;

  Map<Object, dynamic> get value => Map<Object, dynamic>.unmodifiable(
        _value.map(
          (key, value) => MapEntry(key, _transformers[key]?.call(value) ?? value),
        ),
      );

  void registerField(
    Object id,
    TwixFormFieldBuilderState<TwixFormFieldBuilder<dynamic>, dynamic> field,
  ) {
    final oldField = _fields[id];
    _fields[id] = field;
    field
      ..registerTransformer(_transformers)
      ..setValue(
        oldField?.value ?? (_value[id] ??= field.initialValue),
      );
  }

  void setInternalFieldValue<T>(Object id, T? value) {
    _value[id] = value;
    widget.onChanged?.call();
  }

  void removeInternalFieldValue(Object id) {
    _value.remove(id);
  }

  void unregisterField(
    Object id,
    TwixFormFieldBuilderState<TwixFormFieldBuilder<dynamic>, dynamic> field,
  ) {
    _fields.remove(id);
    _value.remove(id);
    _transformers.remove(id);
  }

  bool validate({
    bool focusOnInvalid = true,
    bool autoScrollWhenFocusOnInvalid = false,
  }) {
    final hasError = !_formKey.currentState!.validate();
    if (hasError) {
      final wrongFields = _fields.values.where((element) => element.hasError).toList();
      if (wrongFields.isNotEmpty) {
        if (focusOnInvalid) {
          wrongFields.first.focus();
        }
        if (autoScrollWhenFocusOnInvalid) {
          wrongFields.first.ensureVisible();
        }
      }
    }
    return !hasError;
  }

  bool saveAndValidate({
    bool focusOnInvalid = true,
    bool autoScrollWhenFocusOnInvalid = false,
  }) {
    save();
    return validate(
      focusOnInvalid: focusOnInvalid,
      autoScrollWhenFocusOnInvalid: autoScrollWhenFocusOnInvalid,
    );
  }

  void reset() {
    _formKey.currentState?.reset();
  }

  void save() {
    _formKey.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: widget.autovalidateMode,
      onPopInvoked: widget.onPopInvoked,
      canPop: widget.canPop,
      child: TwixFormScope(
        formState: this,
        child: FocusTraversalGroup(
          policy: WidgetOrderTraversalPolicy(),
          child: widget.child,
        ),
      ),
    );
  }
}

class TwixFormScope extends InheritedWidget {
  const TwixFormScope({
    super.key,
    required super.child,
    required TwixFormState formState,
  }) : _formState = formState;

  final TwixFormState _formState;

  TwixForm get form => _formState.widget;

  @override
  bool updateShouldNotify(TwixFormScope oldWidget) => oldWidget._formState != _formState;
}
