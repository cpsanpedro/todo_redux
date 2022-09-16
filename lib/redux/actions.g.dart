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

class _$SuccessAddItemAction extends SuccessAddItemAction {
  @override
  final ToDoItem item;

  factory _$SuccessAddItemAction(
          [void Function(SuccessAddItemActionBuilder)? updates]) =>
      (new SuccessAddItemActionBuilder()..update(updates))._build();

  _$SuccessAddItemAction._({required this.item}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        item, r'SuccessAddItemAction', 'item');
  }

  @override
  SuccessAddItemAction rebuild(
          void Function(SuccessAddItemActionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SuccessAddItemActionBuilder toBuilder() =>
      new SuccessAddItemActionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SuccessAddItemAction && item == other.item;
  }

  @override
  int get hashCode {
    return $jf($jc(0, item.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SuccessAddItemAction')
          ..add('item', item))
        .toString();
  }
}

class SuccessAddItemActionBuilder
    implements Builder<SuccessAddItemAction, SuccessAddItemActionBuilder> {
  _$SuccessAddItemAction? _$v;

  ToDoItemBuilder? _item;
  ToDoItemBuilder get item => _$this._item ??= new ToDoItemBuilder();
  set item(ToDoItemBuilder? item) => _$this._item = item;

  SuccessAddItemActionBuilder();

  SuccessAddItemActionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _item = $v.item.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SuccessAddItemAction other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SuccessAddItemAction;
  }

  @override
  void update(void Function(SuccessAddItemActionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SuccessAddItemAction build() => _build();

  _$SuccessAddItemAction _build() {
    _$SuccessAddItemAction _$result;
    try {
      _$result = _$v ?? new _$SuccessAddItemAction._(item: item.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'item';
        item.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'SuccessAddItemAction', _$failedField, e.toString());
      }
      rethrow;
    }
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

class _$SuccessDeleteItemAction extends SuccessDeleteItemAction {
  @override
  final ToDoItem item;

  factory _$SuccessDeleteItemAction(
          [void Function(SuccessDeleteItemActionBuilder)? updates]) =>
      (new SuccessDeleteItemActionBuilder()..update(updates))._build();

  _$SuccessDeleteItemAction._({required this.item}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        item, r'SuccessDeleteItemAction', 'item');
  }

  @override
  SuccessDeleteItemAction rebuild(
          void Function(SuccessDeleteItemActionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SuccessDeleteItemActionBuilder toBuilder() =>
      new SuccessDeleteItemActionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SuccessDeleteItemAction && item == other.item;
  }

  @override
  int get hashCode {
    return $jf($jc(0, item.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SuccessDeleteItemAction')
          ..add('item', item))
        .toString();
  }
}

class SuccessDeleteItemActionBuilder
    implements
        Builder<SuccessDeleteItemAction, SuccessDeleteItemActionBuilder> {
  _$SuccessDeleteItemAction? _$v;

  ToDoItemBuilder? _item;
  ToDoItemBuilder get item => _$this._item ??= new ToDoItemBuilder();
  set item(ToDoItemBuilder? item) => _$this._item = item;

  SuccessDeleteItemActionBuilder();

  SuccessDeleteItemActionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _item = $v.item.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SuccessDeleteItemAction other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SuccessDeleteItemAction;
  }

  @override
  void update(void Function(SuccessDeleteItemActionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SuccessDeleteItemAction build() => _build();

  _$SuccessDeleteItemAction _build() {
    _$SuccessDeleteItemAction _$result;
    try {
      _$result = _$v ?? new _$SuccessDeleteItemAction._(item: item.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'item';
        item.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'SuccessDeleteItemAction', _$failedField, e.toString());
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
  @override
  final Status status;

  factory _$LoadedItemsAction(
          [void Function(LoadedItemsActionBuilder)? updates]) =>
      (new LoadedItemsActionBuilder()..update(updates))._build();

  _$LoadedItemsAction._({required this.items, required this.status})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(items, r'LoadedItemsAction', 'items');
    BuiltValueNullFieldError.checkNotNull(
        status, r'LoadedItemsAction', 'status');
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
    return other is LoadedItemsAction &&
        items == other.items &&
        status == other.status;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, items.hashCode), status.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LoadedItemsAction')
          ..add('items', items)
          ..add('status', status))
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

  StatusBuilder? _status;
  StatusBuilder get status => _$this._status ??= new StatusBuilder();
  set status(StatusBuilder? status) => _$this._status = status;

  LoadedItemsActionBuilder();

  LoadedItemsActionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _items = $v.items.toBuilder();
      _status = $v.status.toBuilder();
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
      _$result = _$v ??
          new _$LoadedItemsAction._(
              items: items.build(), status: status.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
        _$failedField = 'status';
        status.build();
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

class _$SuccessUpdateItemAction extends SuccessUpdateItemAction {
  @override
  final ToDoItem item;

  factory _$SuccessUpdateItemAction(
          [void Function(SuccessUpdateItemActionBuilder)? updates]) =>
      (new SuccessUpdateItemActionBuilder()..update(updates))._build();

  _$SuccessUpdateItemAction._({required this.item}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        item, r'SuccessUpdateItemAction', 'item');
  }

  @override
  SuccessUpdateItemAction rebuild(
          void Function(SuccessUpdateItemActionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SuccessUpdateItemActionBuilder toBuilder() =>
      new SuccessUpdateItemActionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SuccessUpdateItemAction && item == other.item;
  }

  @override
  int get hashCode {
    return $jf($jc(0, item.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SuccessUpdateItemAction')
          ..add('item', item))
        .toString();
  }
}

class SuccessUpdateItemActionBuilder
    implements
        Builder<SuccessUpdateItemAction, SuccessUpdateItemActionBuilder> {
  _$SuccessUpdateItemAction? _$v;

  ToDoItemBuilder? _item;
  ToDoItemBuilder get item => _$this._item ??= new ToDoItemBuilder();
  set item(ToDoItemBuilder? item) => _$this._item = item;

  SuccessUpdateItemActionBuilder();

  SuccessUpdateItemActionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _item = $v.item.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SuccessUpdateItemAction other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SuccessUpdateItemAction;
  }

  @override
  void update(void Function(SuccessUpdateItemActionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SuccessUpdateItemAction build() => _build();

  _$SuccessUpdateItemAction _build() {
    _$SuccessUpdateItemAction _$result;
    try {
      _$result = _$v ?? new _$SuccessUpdateItemAction._(item: item.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'item';
        item.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'SuccessUpdateItemAction', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ErrorUpdateItemAction extends ErrorUpdateItemAction {
  @override
  final String error;

  factory _$ErrorUpdateItemAction(
          [void Function(ErrorUpdateItemActionBuilder)? updates]) =>
      (new ErrorUpdateItemActionBuilder()..update(updates))._build();

  _$ErrorUpdateItemAction._({required this.error}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        error, r'ErrorUpdateItemAction', 'error');
  }

  @override
  ErrorUpdateItemAction rebuild(
          void Function(ErrorUpdateItemActionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ErrorUpdateItemActionBuilder toBuilder() =>
      new ErrorUpdateItemActionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ErrorUpdateItemAction && error == other.error;
  }

  @override
  int get hashCode {
    return $jf($jc(0, error.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ErrorUpdateItemAction')
          ..add('error', error))
        .toString();
  }
}

class ErrorUpdateItemActionBuilder
    implements Builder<ErrorUpdateItemAction, ErrorUpdateItemActionBuilder> {
  _$ErrorUpdateItemAction? _$v;

  String? _error;
  String? get error => _$this._error;
  set error(String? error) => _$this._error = error;

  ErrorUpdateItemActionBuilder();

  ErrorUpdateItemActionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _error = $v.error;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ErrorUpdateItemAction other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ErrorUpdateItemAction;
  }

  @override
  void update(void Function(ErrorUpdateItemActionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ErrorUpdateItemAction build() => _build();

  _$ErrorUpdateItemAction _build() {
    final _$result = _$v ??
        new _$ErrorUpdateItemAction._(
            error: BuiltValueNullFieldError.checkNotNull(
                error, r'ErrorUpdateItemAction', 'error'));
    replace(_$result);
    return _$result;
  }
}

class _$LoadingAction extends LoadingAction {
  @override
  final Status? status;

  factory _$LoadingAction([void Function(LoadingActionBuilder)? updates]) =>
      (new LoadingActionBuilder()..update(updates))._build();

  _$LoadingAction._({this.status}) : super._();

  @override
  LoadingAction rebuild(void Function(LoadingActionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LoadingActionBuilder toBuilder() => new LoadingActionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LoadingAction && status == other.status;
  }

  @override
  int get hashCode {
    return $jf($jc(0, status.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LoadingAction')
          ..add('status', status))
        .toString();
  }
}

class LoadingActionBuilder
    implements Builder<LoadingAction, LoadingActionBuilder> {
  _$LoadingAction? _$v;

  StatusBuilder? _status;
  StatusBuilder get status => _$this._status ??= new StatusBuilder();
  set status(StatusBuilder? status) => _$this._status = status;

  LoadingActionBuilder();

  LoadingActionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LoadingAction other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$LoadingAction;
  }

  @override
  void update(void Function(LoadingActionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LoadingAction build() => _build();

  _$LoadingAction _build() {
    _$LoadingAction _$result;
    try {
      _$result = _$v ?? new _$LoadingAction._(status: _status?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'status';
        _status?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'LoadingAction', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
