import 'package:built_value/built_value.dart';

import '../model/model.dart';

part 'view_model.g.dart';

abstract class ToDoViewModel
    implements Built<ToDoViewModel, ToDoViewModelBuilder> {
  List<ToDoItem>? get items;

  ToDoViewModel._();

  factory ToDoViewModel([void Function(ToDoViewModelBuilder) updates]) =
      _$ToDoViewModel;
}
