// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'view_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ToDoViewModel extends ToDoViewModel {
  @override
  final List<ToDoItem>? items;

  factory _$ToDoViewModel([void Function(ToDoViewModelBuilder)? updates]) =>
      (new ToDoViewModelBuilder()..update(updates))._build();

  _$ToDoViewModel._({this.items}) : super._();

  @override
  ToDoViewModel rebuild(void Function(ToDoViewModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ToDoViewModelBuilder toBuilder() => new ToDoViewModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ToDoViewModel && items == other.items;
  }

  @override
  int get hashCode {
    return $jf($jc(0, items.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ToDoViewModel')..add('items', items))
        .toString();
  }
}

class ToDoViewModelBuilder
    implements Builder<ToDoViewModel, ToDoViewModelBuilder> {
  _$ToDoViewModel? _$v;

  List<ToDoItem>? _items;
  List<ToDoItem>? get items => _$this._items;
  set items(List<ToDoItem>? items) => _$this._items = items;

  ToDoViewModelBuilder();

  ToDoViewModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _items = $v.items;
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
    final _$result = _$v ?? new _$ToDoViewModel._(items: items);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
