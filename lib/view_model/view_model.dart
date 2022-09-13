import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../model/model.dart';
import '../model/serializer.dart';

part 'view_model.g.dart';

abstract class ToDoViewModel
    implements Built<ToDoViewModel, ToDoViewModelBuilder> {
  BuiltList<ToDoItem>? get items;
  bool? get isLoading;

  ToDoViewModel._();

  factory ToDoViewModel([void Function(ToDoViewModelBuilder) updates]) =
      _$ToDoViewModel;

  static ToDoViewModel? fromJson(String jsonStr) {
    return serializers.deserializeWith(
        ToDoViewModel.serializer, jsonDecode(jsonStr));
  }

  String toJson() =>
      jsonEncode(serializers.serializeWith(ToDoViewModel.serializer, this));

  static Serializer<ToDoViewModel> get serializer => _$toDoViewModelSerializer;
}
