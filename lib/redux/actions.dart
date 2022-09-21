import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:redux_compact/redux_compact.dart';
import 'package:todo_redux/model/model.dart';
import 'package:todo_redux/redux/repo_action.dart';

import '../constants/consts.dart';
import '../model/status.dart';

part 'actions.g.dart';

abstract class AddItemAction extends Object
    with CompactAction<AppState>
    implements Built<AddItemAction, AddItemActionBuilder> {
  String? get id;
  String? get title;

  AddItemAction._();

  factory AddItemAction([void Function(AddItemActionBuilder) updates]) =
      _$AddItemAction;

  @override
  makeRequest() {
    return RepoAction.repository.saveTodos(ToDoItem((b) => b
          ..id = id
          ..title = title)) ??
        false;
  }

  @override
  reduce() {
    if (request.loading) {
      return state.rebuild((p0) => p0..status = Status.loading().toBuilder());
    }

    if (request.hasError) {
      return state.rebuild((p0) => p0
        ..status = Status.error(
                message: request.error?.message ?? Label.errorAddingToDo)
            .toBuilder());
    } else {
      if (request.data == true) {
        return state.rebuild((p0) {
          p0
            ..items = ListBuilder<ToDoItem>([
              ...?state.items,
              ToDoItem((b) => b
                ..title = title
                ..id = id)
            ])
            ..status = Status.success(message: Label.todoAdded).toBuilder();
        });
      } else {
        return state.rebuild((p0) => p0
          ..status = Status.error(message: Label.errorAddingToDo).toBuilder());
      }
    }
  }
}

abstract class DeleteItemAction extends Object
    with CompactAction<AppState>
    implements Built<DeleteItemAction, DeleteItemActionBuilder> {
  ToDoItem get item;
  DeleteItemAction._();

  factory DeleteItemAction([void Function(DeleteItemActionBuilder) updates]) =
      _$DeleteItemAction;

  @override
  makeRequest() {
    return RepoAction.repository.deleteTodo(ToDoItem((b) => b
          ..id = item.id
          ..title = item.title)) ??
        false;
  }

  @override
  reduce() {
    if (request.loading) {
      return state.rebuild((p0) => p0..status = Status.loading().toBuilder());
    }

    if (request.hasError) {
      return state.rebuild((p0) => p0
        ..status = Status.error(
                message: request.error?.message ?? Label.errorDeletingToDo)
            .toBuilder());
    } else {
      if (request.data == true) {
        return state.rebuild((p0) {
          ListBuilder<ToDoItem> list = state.toBuilder().items;
          list.remove(item);
          p0.items = list;
          p0.status =
              Status.success(message: "${Label.todoDeleted} - ${item.title}")
                  .toBuilder();
        });
      } else {
        return state.rebuild((p0) => p0
          ..status =
              Status.error(message: Label.errorDeletingToDo).toBuilder());
      }
    }
  }
}

abstract class LoadedItemsAction extends Object
    with CompactAction<AppState>
    implements Built<LoadedItemsAction, LoadedItemsActionBuilder> {
  Status get status;

  @override
  makeRequest() {
    return RepoAction.repository.getTodos();
  }

  @override
  AppState reduce() {
    if (request.loading) {
      return state.rebuild((p0) => p0..status = Status.loading().toBuilder());
    }

    if (request.hasError) {
      return state.rebuild((p0) => p0
        ..status = Status.error(
                message: request.error?.message ?? Label.somethingWentWrong)
            .toBuilder());
    } else {
      if (request.data != null) {
        return state.rebuild((p0) {
          p0
            ..items = request.data != null
                ? ListBuilder<ToDoItem>(request.data)
                : ListBuilder()
            ..status = Status.idle().toBuilder();
        });
      } else {
        return state.rebuild((p0) => p0
          ..status =
              Status.error(message: Label.somethingWentWrong).toBuilder());
      }
    }
  }

  LoadedItemsAction._();

  factory LoadedItemsAction([void Function(LoadedItemsActionBuilder) updates]) =
      _$LoadedItemsAction;
}

abstract class UpdateItemAction extends Object
    with CompactAction<AppState>
    implements Built<UpdateItemAction, UpdateItemActionBuilder> {
  ToDoItem get item;
  UpdateItemAction._();

  factory UpdateItemAction([void Function(UpdateItemActionBuilder) updates]) =
      _$UpdateItemAction;

  @override
  makeRequest() {
    return RepoAction.repository.updateTodo(ToDoItem((b) => b
          ..id = item.id
          ..title = item.title)) ??
        false;
  }

  @override
  reduce() {
    if (request.loading) {
      return state.rebuild((p0) => p0..status = Status.loading().toBuilder());
    }

    if (!request.hasError && request.data) {
      return state.rebuild((builder) {
        ListBuilder<ToDoItem> list = state.toBuilder().items;
        list.map((p0) {
          if (p0.id == item.id) {
            p0 = ToDoItem((b) => b
              ..title = item.title
              ..id = item.id);
          }
          return p0;
        });
        builder.items = list;
        builder.status = Status.success(message: Label.todoUpdated).toBuilder();
      });
    } else {
      return state.rebuild((p0) => p0
        ..status = Status.error(
                message: request.error?.message ?? Label.errorUpdatingToDo)
            .toBuilder());
    }
  }
}
