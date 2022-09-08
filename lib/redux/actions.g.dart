// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actions.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AddItemAction extends AddItemAction {
  @override
  final String? id;
  @override
  final String? title;

  factory _$AddItemAction([void Function(AddItemActionBuilder)? updates]) =>
      (new AddItemActionBuilder()..update(updates))._build();

  _$AddItemAction._({this.id, this.title}) : super._();

  @override
  AddItemAction rebuild(void Function(AddItemActionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AddItemActionBuilder toBuilder() => new AddItemActionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AddItemAction && id == other.id && title == other.title;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, id.hashCode), title.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AddItemAction')
          ..add('id', id)
          ..add('title', title))
        .toString();
  }
}

class AddItemActionBuilder
    implements Builder<AddItemAction, AddItemActionBuilder> {
  _$AddItemAction? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  AddItemActionBuilder();

  AddItemActionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AddItemAction other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AddItemAction;
  }

  @override
  void update(void Function(AddItemActionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AddItemAction build() => _build();

  _$AddItemAction _build() {
    final _$result = _$v ?? new _$AddItemAction._(id: id, title: title);
    replace(_$result);
    return _$result;
  }
}

class _$DeleteItemAction extends DeleteItemAction {
  @override
  final ToDoItem item;

  factory _$DeleteItemAction(
          [void Function(DeleteItemActionBuilder)? updates]) =>
      (new DeleteItemActionBuilder()..update(updates))._build();

  _$DeleteItemAction._({required this.item}) : super._() {
    BuiltValueNullFieldError.checkNotNull(item, r'DeleteItemAction', 'item');
  }

  @override
  DeleteItemAction rebuild(void Function(DeleteItemActionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DeleteItemActionBuilder toBuilder() =>
      new DeleteItemActionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DeleteItemAction && item == other.item;
  }

  @override
  int get hashCode {
    return $jf($jc(0, item.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DeleteItemAction')..add('item', item))
        .toString();
  }
}

class DeleteItemActionBuilder
    implements Builder<DeleteItemAction, DeleteItemActionBuilder> {
  _$DeleteItemAction? _$v;

  ToDoItemBuilder? _item;
  ToDoItemBuilder get item => _$this._item ??= new ToDoItemBuilder();
  set item(ToDoItemBuilder? item) => _$this._item = item;

  DeleteItemActionBuilder();

  DeleteItemActionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _item = $v.item.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DeleteItemAction other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DeleteItemAction;
  }

  @override
  void update(void Function(DeleteItemActionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DeleteItemAction build() => _build();

  _$DeleteItemAction _build() {
    _$DeleteItemAction _$result;
    try {
      _$result = _$v ?? new _$DeleteItemAction._(item: item.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'item';
        item.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'DeleteItemAction', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$LoadedItemsAction extends LoadedItemsAction {
  @override
  final BuiltList<ToDoItem> items;

  factory _$LoadedItemsAction(
          [void Function(LoadedItemsActionBuilder)? updates]) =>
      (new LoadedItemsActionBuilder()..update(updates))._build();

  _$LoadedItemsAction._({required this.items}) : super._() {
    BuiltValueNullFieldError.checkNotNull(items, r'LoadedItemsAction', 'items');
  }

  @override
  LoadedItemsAction rebuild(void Function(LoadedItemsActionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LoadedItemsActionBuilder toBuilder() =>
      new LoadedItemsActionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LoadedItemsAction && items == other.items;
  }

  @override
  int get hashCode {
    return $jf($jc(0, items.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LoadedItemsAction')
          ..add('items', items))
        .toString();
  }
}

class LoadedItemsActionBuilder
    implements Builder<LoadedItemsAction, LoadedItemsActionBuilder> {
  _$LoadedItemsAction? _$v;

  ListBuilder<ToDoItem>? _items;
  ListBuilder<ToDoItem> get items =>
      _$this._items ??= new ListBuilder<ToDoItem>();
  set items(ListBuilder<ToDoItem>? items) => _$this._items = items;

  LoadedItemsActionBuilder();

  LoadedItemsActionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _items = $v.items.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LoadedItemsAction other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$LoadedItemsAction;
  }

  @override
  void update(void Function(LoadedItemsActionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LoadedItemsAction build() => _build();

  _$LoadedItemsAction _build() {
    _$LoadedItemsAction _$result;
    try {
      _$result = _$v ?? new _$LoadedItemsAction._(items: items.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'LoadedItemsAction', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$UpdateItemAction extends UpdateItemAction {
  @override
  final ToDoItem item;

  factory _$UpdateItemAction(
          [void Function(UpdateItemActionBuilder)? updates]) =>
      (new UpdateItemActionBuilder()..update(updates))._build();

  _$UpdateItemAction._({required this.item}) : super._() {
    BuiltValueNullFieldError.checkNotNull(item, r'UpdateItemAction', 'item');
  }

  @override
  UpdateItemAction rebuild(void Function(UpdateItemActionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateItemActionBuilder toBuilder() =>
      new UpdateItemActionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateItemAction && item == other.item;
  }

  @override
  int get hashCode {
    return $jf($jc(0, item.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateItemAction')..add('item', item))
        .toString();
  }
}

class UpdateItemActionBuilder
    implements Builder<UpdateItemAction, UpdateItemActionBuilder> {
  _$UpdateItemAction? _$v;

  ToDoItemBuilder? _item;
  ToDoItemBuilder get item => _$this._item ??= new ToDoItemBuilder();
  set item(ToDoItemBuilder? item) => _$this._item = item;

  UpdateItemActionBuilder();

  UpdateItemActionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _item = $v.item.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateItemAction other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UpdateItemAction;
  }

  @override
  void update(void Function(UpdateItemActionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateItemAction build() => _build();

  _$UpdateItemAction _build() {
    _$UpdateItemAction _$result;
    try {
      _$result = _$v ?? new _$UpdateItemAction._(item: item.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'item';
        item.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'UpdateItemAction', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
