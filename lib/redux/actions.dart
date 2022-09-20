import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:redux_compact/redux_compact.dart';
import 'package:todo_redux/model/model.dart';
import 'package:todo_redux/redux/repo_action.dart';

import '../model/status.dart';
import '../repository/repo.dart';

part 'actions.g.dart';

abstract class AddItemAction extends Object
    with CompactAction<AppState>
    implements Built<AddItemAction, AddItemActionBuilder> {
  String? get id;
  String? get title;
  AbstractRepo get todoRepo;

  AddItemAction._();

  factory AddItemAction([void Function(AddItemActionBuilder) updates]) =
      _$AddItemAction;

  @override
  makeRequest() {
    Future.delayed(const Duration(seconds: 1));
    // print("title ${title}");
    return todoRepo.saveTodos(ToDoItem((b) => b
          ..id = id
          ..title = title)) ??
        false;
  }

  @override
  reduce() {
    print("REQ DATA ADD ${request.data}");
    return AppState((builder) => builder
      ..items = ListBuilder<ToDoItem>([
        ...?state.items,
        ToDoItem((b) => b
          ..title = title
          ..id = id)
      ]));
  }
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

class GetItemsAction extends CompactAction<AppState> {
  @override
  AppState reduce() {
    print("GET ITEM ${state}");
    return state;
  }

  @override
  void after() {
    // TODO: implement after
    super.after();
    // print("GET AFTER ${state.items}");
    dispatch(LoadedItemsAction((b) => b
      ..items = state.items != null ? state.items!.toBuilder() : ListBuilder()
      ..status = Status.idle().toBuilder()));
  }
}

abstract class LoadedItemsAction extends Object
    with CompactAction<AppState>
    implements Built<LoadedItemsAction, LoadedItemsActionBuilder> {
  BuiltList<ToDoItem> get items;
  Status get status;

  @override
  makeRequest() {
    return RepoAction.repository.getTodos();
  }

  @override
  AppState reduce() {
    print("REQ error ${request.error}");
    print("loading ${request.loading}");
    print("REQ DATA ${request.data}");

    if (request.loading) {
      return AppState((b) => b
        ..items = store.state.items!.toBuilder()
        ..status = Status.loading().toBuilder());
    }

    if (!request.hasError) {
      return AppState((builder) => builder
        ..items = request.data != null
            ? ListBuilder<ToDoItem>(request.data)
            : ListBuilder()
        ..status = Status.idle().toBuilder());
    } else {
      return AppState((b) => b
        ..items = store.state.items!.toBuilder()
        ..status = Status.error(message: "Error").toBuilder());
    }
  }

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

abstract class SuccessUpdateItemAction
    implements Built<SuccessUpdateItemAction, SuccessUpdateItemActionBuilder> {
  ToDoItem get item;
  SuccessUpdateItemAction._();

  factory SuccessUpdateItemAction(
          [void Function(SuccessUpdateItemActionBuilder) updates]) =
      _$SuccessUpdateItemAction;
}

abstract class ErrorUpdateItemAction
    implements Built<ErrorUpdateItemAction, ErrorUpdateItemActionBuilder> {
  String get error;
  ErrorUpdateItemAction._();

  factory ErrorUpdateItemAction(
          [void Function(ErrorUpdateItemActionBuilder) updates]) =
      _$ErrorUpdateItemAction;
}

abstract class LoadingAction
    implements Built<LoadingAction, LoadingActionBuilder> {
  Status? get status;
  LoadingAction._();

  factory LoadingAction([void Function(LoadingActionBuilder) updates]) =
      _$LoadingAction;
}
