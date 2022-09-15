import 'package:built_collection/built_collection.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:todo_redux/model/model.dart';
import 'package:todo_redux/redux/actions.dart';

import '../repository/repo.dart';

class AppMiddleware extends EpicClass<AppState> {
  AppMiddleware(this.todoRepo);
  final AbstractRepo todoRepo;

  @override
  Stream call(Stream actions, EpicStore<AppState> store) {
    return combineEpics<AppState>(
      [updateEpic, getEpic, loadingEpic, addEpic, deleteEpic],
    )(actions, store);
  }

  Stream<dynamic> getEpic(
      Stream<dynamic> actions, EpicStore<AppState> store) async* {
    await for (final action in actions) {
      if (action is GetItemsAction) {
        final todos = await todoRepo.getTodos();
        yield LoadedItemsAction((b) => b.items = todos?.items != null
            ? ListBuilder<ToDoItem>(todos!.items!)
            : ListBuilder());
        // yield FinishLoadingAction();
      }
    }
  }

  Stream<dynamic> updateEpic(
      Stream<dynamic> actions, EpicStore<AppState> store) async* {
    await for (final action in actions) {
      if (action is UpdateItemAction) {
        yield LoadingAction((b) => b.isLoading = true);
        await Future.delayed(const Duration(seconds: 1));
        await todoRepo.saveTodos(store.state);
        yield LoadingAction((b) => b.isLoading = false);
        yield SuccessUpdateItemAction((b) => b.item = action.item.toBuilder());
      }
    }
  }

  Stream<dynamic> addEpic(
      Stream<dynamic> actions, EpicStore<AppState> store) async* {
    await for (final action in actions) {
      if (action is AddItemAction) {
        await todoRepo.saveTodos(store.state);
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
        yield LoadingAction((b) => b.isLoading = true);
        await Future.delayed(const Duration(seconds: 1));
        await todoRepo.saveTodos(store.state);
        yield LoadingAction((b) => b.isLoading = false);
        yield SuccessDeleteItemAction((b) => b.item = action.item.toBuilder());
      }
    }
  }

  Stream<dynamic> loadingEpic(
      Stream<dynamic> actions, EpicStore<AppState> store) async* {
    await for (final action in actions) {
      if (action is LoadingAction) {
        // store.state.isLoading =
      }
    }
  }
}
