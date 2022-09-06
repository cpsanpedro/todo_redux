import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:todo_redux/model/model.dart';

part 'actions.g.dart';

abstract class AddItemAction
    implements Built<AddItemAction, AddItemActionBuilder> {
  int? get id;
  String? get title;

  AddItemAction._();

  factory AddItemAction([void Function(AddItemActionBuilder) updates]) =
      _$AddItemAction;
}

abstract class DeleteItemAction
    implements Built<DeleteItemAction, DeleteItemActionBuilder> {
  ToDoItem get item;
  DeleteItemAction._();

  factory DeleteItemAction([void Function(DeleteItemActionBuilder) updates]) =
      _$DeleteItemAction;
}

class GetItemsAction {}

abstract class LoadedItemsAction
    implements Built<LoadedItemsAction, LoadedItemsActionBuilder> {
  BuiltList<ToDoItem> get items;
  LoadedItemsAction._();

  factory LoadedItemsAction([void Function(LoadedItemsActionBuilder) updates]) =
      _$LoadedItemsAction;
}
