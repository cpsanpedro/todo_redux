import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:todo_redux/model/model.dart';

part 'actions.g.dart';

abstract class AddItemAction
    implements Built<AddItemAction, AddItemActionBuilder> {
  String? get id;
  String? get title;

  AddItemAction._();

  factory AddItemAction([void Function(AddItemActionBuilder) updates]) =
      _$AddItemAction;
}

abstract class SuccessAddItemAction
    implements Built<SuccessAddItemAction, SuccessAddItemActionBuilder> {
  ToDoItem get item;

  SuccessAddItemAction._();

  factory SuccessAddItemAction(
          [void Function(SuccessAddItemActionBuilder) updates]) =
      _$SuccessAddItemAction;
}

abstract class DeleteItemAction
    implements Built<DeleteItemAction, DeleteItemActionBuilder> {
  ToDoItem get item;
  DeleteItemAction._();

  factory DeleteItemAction([void Function(DeleteItemActionBuilder) updates]) =
      _$DeleteItemAction;
}

abstract class SuccessDeleteItemAction
    implements Built<SuccessDeleteItemAction, SuccessDeleteItemActionBuilder> {
  ToDoItem get item;
  SuccessDeleteItemAction._();

  factory SuccessDeleteItemAction(
          [void Function(SuccessDeleteItemActionBuilder) updates]) =
      _$SuccessDeleteItemAction;
}

class GetItemsAction {}

abstract class LoadedItemsAction
    implements Built<LoadedItemsAction, LoadedItemsActionBuilder> {
  BuiltList<ToDoItem> get items;
  LoadedItemsAction._();

  factory LoadedItemsAction([void Function(LoadedItemsActionBuilder) updates]) =
      _$LoadedItemsAction;
}

abstract class UpdateItemAction
    implements Built<UpdateItemAction, UpdateItemActionBuilder> {
  ToDoItem get item;
  UpdateItemAction._();

  factory UpdateItemAction([void Function(UpdateItemActionBuilder) updates]) =
      _$UpdateItemAction;
}

abstract class LoadingAction
    implements Built<LoadingAction, LoadingActionBuilder> {
  bool? get isLoading;
  LoadingAction._();

  factory LoadingAction([void Function(LoadingActionBuilder) updates]) =
      _$LoadingAction;
}
