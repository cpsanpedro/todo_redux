// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Status extends Status {
  @override
  final LoadingStatus loadingStatus;
  @override
  final String message;
  @override
  final Object data;

  factory _$Status([void Function(StatusBuilder)? updates]) =>
      (new StatusBuilder()..update(updates))._build();

  _$Status._(
      {required this.loadingStatus, required this.message, required this.data})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        loadingStatus, r'Status', 'loadingStatus');
    BuiltValueNullFieldError.checkNotNull(message, r'Status', 'message');
    BuiltValueNullFieldError.checkNotNull(data, r'Status', 'data');
  }

  @override
  Status rebuild(void Function(StatusBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StatusBuilder toBuilder() => new StatusBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Status &&
        loadingStatus == other.loadingStatus &&
        message == other.message &&
        data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, loadingStatus.hashCode), message.hashCode), data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Status')
          ..add('loadingStatus', loadingStatus)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class StatusBuilder implements Builder<Status, StatusBuilder> {
  _$Status? _$v;

  LoadingStatus? _loadingStatus;
  LoadingStatus? get loadingStatus => _$this._loadingStatus;
  set loadingStatus(LoadingStatus? loadingStatus) =>
      _$this._loadingStatus = loadingStatus;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  Object? _data;
  Object? get data => _$this._data;
  set data(Object? data) => _$this._data = data;

  StatusBuilder();

  StatusBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _loadingStatus = $v.loadingStatus;
      _message = $v.message;
      _data = $v.data;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Status other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Status;
  }

  @override
  void update(void Function(StatusBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Status build() => _build();

  _$Status _build() {
    final _$result = _$v ??
        new _$Status._(
            loadingStatus: BuiltValueNullFieldError.checkNotNull(
                loadingStatus, r'Status', 'loadingStatus'),
            message: BuiltValueNullFieldError.checkNotNull(
                message, r'Status', 'message'),
            data:
                BuiltValueNullFieldError.checkNotNull(data, r'Status', 'data'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
