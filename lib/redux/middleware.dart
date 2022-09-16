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
          todos = await todoRepo.getTodos();
          print("ET TODO ${todos}");
        } catch (e) {
          print("E GET TODO ${e.toString()}");
        }

        yield LoadedItemsAction((b) => b
          ..items = todos != null ? ListBuilder<ToDoItem>(todos) : ListBuilder()
          ..status = Status.idle().toBuilder());
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
          yield LoadingAction((b) => b.status = Status.success().toBuilder());
        } else {
          yield LoadingAction(
              (b) => b.status = Status.error(message: "Error").toBuilder());
        }
      }
    }
  }

  Stream<dynamic> addEpic(
      Stream<dynamic> actions, EpicStore<AppState> store) async* {
    await for (final action in actions) {
      if (action is AddItemAction) {
        await todoRepo.saveTodos(ToDoItem((b) => b
          ..id = action.id
          ..title = action.title));
        yield SuccessAddItemAction((b) => b.item
          ..title = action.title
          ..id = action.id);
      }
    }
  }

  Stream<dynamic> deleteEpic(
      Stream<dynamic> actions, EpicStore<AppState> store) async* {
    await for (final action in actions) {
      if (action is DeleteItemAction) {
        yield LoadingAction((b) => b.status =
            Status((b) => b..loadingStatus = LoadingStatus.loading)
                .toBuilder());
        await Future.delayed(const Duration(seconds: 1));
        await todoRepo.deleteTodo(ToDoItem((b) => b
          ..id = action.item.id
          ..title = action.item.title));
        yield LoadingAction((b) => b.status =
            Status((b) => b..loadingStatus = LoadingStatus.success)
                .toBuilder());
        yield SuccessDeleteItemAction((b) => b.item = action.item.toBuilder());
      }
    }
  }

  // Stream<dynamic> loadingEpic(
  //     Stream<dynamic> actions, EpicStore<AppState> store) async* {
  //   await for (final action in actions) {
  //     if (action is LoadingAction) {
  //       if (action.status == Status.success()) {
  //         yield SuccessUpdateItemAction(
  //             (b) => b.item = action.status?.data as ToDoItemBuilder?);
  //       } else if (action.status ==
  //           Status.error(message: action.status?.message)) {
  //         print("ERROR UPDATE");
  //         yield ErrorUpdateItemAction((b) => b.error = "Error UPDATE");
  //       }
  //       // store.state.isLoading =
  //     }
  //   }
  // }
}
