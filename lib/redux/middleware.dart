import 'package:built_collection/built_collection.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:todo_redux/model/model.dart';
import 'package:todo_redux/model/status.dart';
import 'package:todo_redux/redux/actions.dart';

import '../repository/repo.dart';

class AppMiddleware extends EpicClass<AppState> {
  AppMiddleware(this.todoRepo);
  final AbstractRepo todoRepo;

  @override
  Stream call(Stream actions, EpicStore<AppState> store) {
    return combineEpics<AppState>(
      [updateEpic, getEpic, addEpic, deleteEpic],
    )(actions, store);
  }

  Stream<dynamic> getEpic(
      Stream<dynamic> actions, EpicStore<AppState> store) async* {
    await for (final action in actions) {
      if (action is GetItemsAction) {
        List<ToDoItem>? todos = [];
        try {
          await Future.delayed(const Duration(seconds: 1));
          todos = await todoRepo.getTodos();
          yield LoadedItemsAction((b) => b
            ..items =
                todos != null ? ListBuilder<ToDoItem>(todos) : ListBuilder()
            ..status = Status.idle().toBuilder());
        } catch (e) {
          print("E GET TODO ${e.toString()}");
          yield LoadingAction((b) =>
              b.status = Status.error(message: e.toString()).toBuilder());
        }
      }
    }
  }

  Stream<dynamic> updateEpic(
      Stream<dynamic> actions, EpicStore<AppState> store) async* {
    await for (final action in actions) {
      if (action is UpdateItemAction) {
        yield LoadingAction((b) => b.status = Status.loading().toBuilder());
        await Future.delayed(const Duration(seconds: 1));
        bool updateResult = await todoRepo.updateTodo(ToDoItem((b) => b
              ..id = action.item.id
              ..title = action.item.title)) ??
            false;
        if (updateResult) {
          yield SuccessUpdateItemAction(
              (b) => b..item = action.item.toBuilder());
          yield LoadingAction((b) =>
              b.status = Status.success(message: "ToDo Updated").toBuilder());
        } else {
          yield LoadingAction((b) => b.status =
              Status.error(message: "Error updating ToDo").toBuilder());
        }
      }
    }
  }

  Stream<dynamic> addEpic(
      Stream<dynamic> actions, EpicStore<AppState> store) async* {
    await for (final action in actions) {
      if (action is AddItemAction) {
        yield LoadingAction((b) => b.status = Status.loading().toBuilder());
        await Future.delayed(const Duration(seconds: 1));
        bool addResult = await todoRepo.saveTodos(ToDoItem((b) => b
              ..id = action.id
              ..title = action.title)) ??
            false;
        if (addResult) {
          yield SuccessAddItemAction((b) => b.item
            ..title = action.title
            ..id = action.id);
          yield LoadingAction((b) => b.status =
              Status.success(message: "ToDo Added - ${action.title}")
                  .toBuilder());
        } else {
          yield LoadingAction((b) => b.status =
              Status.error(message: "Error Adding ToDo").toBuilder());
        }
      }
    }
  }

  Stream<dynamic> deleteEpic(
      Stream<dynamic> actions, EpicStore<AppState> store) async* {
    await for (final action in actions) {
      if (action is DeleteItemAction) {
        yield LoadingAction((b) => b.status = Status.loading().toBuilder());
        await Future.delayed(const Duration(seconds: 1));
        bool deleteResult = await todoRepo.deleteTodo(ToDoItem((b) => b
              ..id = action.item.id
              ..title = action.item.title)) ??
            false;
        if (deleteResult) {
          yield SuccessDeleteItemAction(
              (b) => b.item = action.item.toBuilder());
          yield LoadingAction((b) => b.status =
              Status.success(message: "ToDo Deleted - ${action.item.title}")
                  .toBuilder());
        } else {
          yield LoadingAction((b) => b.status =
              Status.error(message: "Error Deleting ToDo").toBuilder());
        }
      }
    }
  }
}
