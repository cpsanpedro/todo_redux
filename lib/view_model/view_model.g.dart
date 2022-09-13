// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'view_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ToDoViewModel> _$toDoViewModelSerializer =
    new _$ToDoViewModelSerializer();

class _$ToDoViewModelSerializer implements StructuredSerializer<ToDoViewModel> {
  @override
  final Iterable<Type> types = const [ToDoViewModel, _$ToDoViewModel];
  @override
  final String wireName = 'ToDoViewModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, ToDoViewModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.items;
    if (value != null) {
      result
        ..add('items')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(ToDoItem)])));
    }
    value = object.isLoading;
    if (value != null) {
      result
        ..add('isLoading')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  ToDoViewModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ToDoViewModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'items':
          result.items.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ToDoItem)]))!
              as BuiltList<Object?>);
          break;
        case 'isLoading':
          result.isLoading = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
      }
    }

    return result.build();
  }
}

class _$ToDoViewModel extends ToDoViewModel {
  @override
  final BuiltList<ToDoItem>? items;
  @override
  final bool? isLoading;

  factory _$ToDoViewModel([void Function(ToDoViewModelBuilder)? updates]) =>
      (new ToDoViewModelBuilder()..update(updates))._build();

  _$ToDoViewModel._({this.items, this.isLoading}) : super._();

  @override
  ToDoViewModel rebuild(void Function(ToDoViewModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ToDoViewModelBuilder toBuilder() => new ToDoViewModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ToDoViewModel &&
        items == other.items &&
        isLoading == other.isLoading;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, items.hashCode), isLoading.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ToDoViewModel')
          ..add('items', items)
          ..add('isLoading', isLoading))
        .toString();
  }
}

class ToDoViewModelBuilder
    implements Builder<ToDoViewModel, ToDoViewModelBuilder> {
  _$ToDoViewModel? _$v;

  ListBuilder<ToDoItem>? _items;
  ListBuilder<ToDoItem> get items =>
      _$this._items ??= new ListBuilder<ToDoItem>();
  set items(ListBuilder<ToDoItem>? items) => _$this._items = items;

  bool? _isLoading;
  bool? get isLoading => _$this._isLoading;
  set isLoading(bool? isLoading) => _$this._isLoading = isLoading;

  ToDoViewModelBuilder();

  ToDoViewModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _items = $v.items?.toBuilder();
      _isLoading = $v.isLoading;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ToDoViewModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ToDoViewModel;
  }

  @override
  void update(void Function(ToDoViewModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ToDoViewModel build() => _build();

  _$ToDoViewModel _build() {
    _$ToDoViewModel _$result;
    try {
      _$result = _$v ??
          new _$ToDoViewModel._(items: _items?.build(), isLoading: isLoading);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        _items?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ToDoViewModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
