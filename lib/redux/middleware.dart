import 'package:redux_epics/redux_epics.dart';
import 'package:todo_redux/model/model.dart';
import 'package:todo_redux/model/status.dart';
import 'package:todo_redux/redux/actions.dart';

import '../constants/consts.dart';
import '../repository/repo.dart';

class AppMiddleware extends EpicClass<AppState> {
  AppMiddleware(this.todoRepo);
  final AbstractRepo todoRepo;

  @override
  Stream call(Stream actions, EpicStore<AppState> store) {
    return combineEpics<AppState>(
      [updateEpic, deleteEpic],
    )(actions, store);
  }

  // Stream<dynamic> getEpic(
  //     Stream<dynamic> actions, EpicStore<AppState> store) async* {
  //   await for (final action in actions) {
  //     if (action is GetItemsAction) {
  //       List<ToDoItem>? todos = [];
  //       try {
  //         await Future.delayed(const Duration(seconds: 1));
  //         todos = await todoRepo.getTodos();
  //         yield LoadedItemsAction((b) => b
  //           ..items =
  //               todos != null ? ListBuilder<ToDoItem>(todos) : ListBuilder()
  //           ..status = Status.idle().toBuilder());
  //       } catch (e) {
  //         print("E GET TODO ${e.toString()}");
  //         yield LoadingAction((b) =>
  //             b.status = Status.error(message: e.toString()).toBuilder());
  //       }
  //     }
  //   }
  // }

  Stream<dynamic> updateEpic(
      Stream<dynamic> actions, EpicStore<AppState> store) async* {
    await for (final action in actions) {
      if (action is UpdateItemAction) {
        try {
          yield LoadingAction((b) => b.status = Status.loading().toBuilder());
          await Future.delayed(const Duration(seconds: 1));
          bool updateResult = await todoRepo.updateTodo(ToDoItem((b) => b
                ..id = action.item.id
                ..title = action.item.title)) ??
              false;
          if (updateResult) {
            yield SuccessUpdateItemAction(
                (b) => b..item = action.item.toBuilder());
            yield LoadingAction((b) => b.status =
                Status.success(message: Label.todoUpdated).toBuilder());
          } else {
            yield LoadingAction((b) => b.status =
                Status.error(message: Label.errorUpdatingToDo).toBuilder());
          }
        } catch (e) {
          yield LoadingAction((b) =>
              b.status = Status.error(message: e.toString()).toBuilder());
        }
      }
    }
  }

  // Stream<dynamic> addEpic(
  //     Stream<dynamic> actions, EpicStore<AppState> store) async* {
  //   await for (final action in actions) {
  //     if (action is AddItemAction) {
  //       try {
  //         yield LoadingAction((b) => b.status = Status.loading().toBuilder());
  //         await Future.delayed(const Duration(seconds: 1));
  //         bool addResult = await todoRepo.saveTodos(ToDoItem((b) => b
  //               ..id = action.id
  //               ..title = action.title)) ??
  //             false;
  //         if (addResult) {
  //           yield SuccessAddItemAction((b) => b.item
  //             ..title = action.title
  //             ..id = action.id);
  //           yield LoadingAction((b) => b.status =
  //               Status.success(message: "${Label.todoAdded} - ${action.title}")
  //                   .toBuilder());
  //         } else {
  //           yield LoadingAction((b) => b.status =
  //               Status.error(message: Label.errorAddingToDo).toBuilder());
  //         }
  //       } catch (e) {
  //         yield LoadingAction((b) =>
  //             b.status = Status.error(message: e.toString()).toBuilder());
  //       }
  //     }
  //   }
  // }

  Stream<dynamic> deleteEpic(
      Stream<dynamic> actions, EpicStore<AppState> store) async* {
    await for (final action in actions) {
      if (action is DeleteItemAction) {
        try {
          yield LoadingAction((b) => b.status = Status.loading().toBuilder());
          await Future.delayed(const Duration(seconds: 1));
          bool deleteResult = await todoRepo.deleteTodo(ToDoItem((b) => b
                ..id = action.item.id
                ..title = action.item.title)) ??
              false;
          if (deleteResult) {
            yield SuccessDeleteItemAction(
                (b) => b.item = action.item.toBuilder());
            yield LoadingAction((b) => b.status = Status.success(
                    message: "${Label.todoDeleted} - ${action.item.title}")
                .toBuilder());
          } else {
            yield LoadingAction((b) => b.status =
                Status.error(message: Label.errorDeletingToDo).toBuilder());
          }
        } catch (e) {
          yield LoadingAction((b) =>
              b.status = Status.error(message: e.toString()).toBuilder());
        }
      }
    }
  }
}
