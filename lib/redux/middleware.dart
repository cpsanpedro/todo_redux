import 'package:built_collection/built_collection.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:todo_redux/model/model.dart';
import 'package:todo_redux/redux/actions.dart';

import '../repository/repo.dart';

class AppMiddleware extends EpicClass<AppState> {
  @override
  Stream call(Stream actions, EpicStore<AppState> store) {
    // print("call ${await actions.toList()}");
    combineEpics<AppState>(
      [saveEpic, getEpic],
    )(actions, store)
        .forEach((element) {
      print("DATA ${element}");
    });
    return combineEpics<AppState>(
      [saveEpic, getEpic],
    )(actions, store);
  }

  Stream<dynamic> getEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
    Repo repo = Repo();
    return actions
        .where((action) => action is GetItemsAction)
        .asyncMap((action) => repo.getTodos().then((value) {
              print("GET EPIC");
              return LoadedItemsAction(
                  (b) => b.items = ListBuilder<ToDoItem>(value.items!));
            }));
  }

  Stream<dynamic> saveEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
    Repo repo = Repo();

    print("SAVE EPIC ${store.state}");

    return actions
        .where((action) =>
            action is AddItemAction ||
            action is DeleteItemAction ||
            action is UpdateItemAction)
        .asyncMap((action) => repo.saveTodos(store.state));
  }
}
