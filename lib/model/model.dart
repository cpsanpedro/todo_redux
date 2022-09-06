import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializer.dart';

part 'model.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  AppState._();
  BuiltList<ToDoItem>? get items;

  factory AppState.init() {
    return AppState(
        (builder) => builder..items = <ToDoItem>[].build().toBuilder());
  }

  factory AppState.fromJson(Map json) {
    print("JSON ${json["items"].runtimeType}");
    return AppState((builder) {
      builder.items = ListBuilder<ToDoItem>((json["items"]).map((i) {
        print("fromJson ${ToDoItem.fromJson(jsonEncode(i))}");
        return ToDoItem.fromJson(jsonEncode(i));
      }).toList());
    });
  }

  toJson() => jsonEncode(serializers.serializeWith(AppState.serializer, this));
  factory AppState([void Function(AppStateBuilder) updates]) = _$AppState;

  static Serializer<AppState> get serializer => _$appStateSerializer;
}

abstract class ToDoItem implements Built<ToDoItem, ToDoItemBuilder> {
  int? get id;
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
