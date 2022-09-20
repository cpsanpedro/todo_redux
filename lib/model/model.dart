import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:todo_redux/model/status.dart';

import 'serializer.dart';

part 'model.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  AppState._();
  BuiltList<ToDoItem>? get items;
  Status? get status;

  factory AppState.init() {
    return AppState((builder) => builder
      ..items = <ToDoItem>[].build().toBuilder()
      ..status = Status.idle().toBuilder());
  }

  factory AppState.fromJson(Map json) {
    return AppState((builder) {
      builder.items = ListBuilder<ToDoItem>((json["items"]).map((i) {
        return ToDoItem.fromJson(jsonEncode(i));
      }).toList());
    });
  }

  toJson() => jsonEncode(serializers.serializeWith(AppState.serializer, this));
  factory AppState([void Function(AppStateBuilder) updates]) = _$AppState;

  static Serializer<AppState> get serializer => _$appStateSerializer;
}

abstract class ToDoItem implements Built<ToDoItem, ToDoItemBuilder> {
  String? get id;
  String? get title;

  ToDoItem._();
  factory ToDoItem([void Function(ToDoItemBuilder) updates]) = _$ToDoItem;

  static ToDoItem? fromJson(String jsonStr) {
    return serializers.deserializeWith(
        ToDoItem.serializer, jsonDecode(jsonStr));
  }

  String toJson() =>
      jsonEncode(serializers.serializeWith(ToDoItem.serializer, this));

  static Serializer<ToDoItem> get serializer => _$toDoItemSerializer;
}
