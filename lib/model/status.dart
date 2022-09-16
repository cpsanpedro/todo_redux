import 'package:built_value/built_value.dart';

part 'status.g.dart';

enum LoadingStatus { idle, loading, success, error }

abstract class Status implements Built<Status, StatusBuilder> {
  LoadingStatus get loadingStatus;
  String get message;
  Object get data;

  Status._();

  factory Status.idle({String? message, Object? data}) => Status((b) => b
    ..loadingStatus = LoadingStatus.idle
    ..message = message ?? ""
    ..data = data ?? "");
  factory Status.loading({String? message, Object? data}) => Status((b) => b
    ..loadingStatus = LoadingStatus.loading
    ..message = message ?? ""
    ..data = data ?? "");
  factory Status.success({String? message, Object? data}) => Status((b) => b
    ..loadingStatus = LoadingStatus.success
    ..message = message ?? ""
    ..data = data ?? "");
  factory Status.error({String? message, Object? data}) => Status((b) => b
    ..loadingStatus = LoadingStatus.error
    ..message = message ?? ""
    ..data = data ?? "");

  factory Status([void Function(StatusBuilder) updates]) = _$Status;
}
