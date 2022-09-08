import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_redux/model/model.dart';
import 'package:todo_redux/redux/actions.dart';

class Repo {
  void saveToPrefs(AppState state) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("items", state.toJson());
  }

  Future<AppState> getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var stateString = prefs.getString("items");

    if (stateString != null) {
      Map map = jsonDecode(stateString);
      return AppState.fromJson(map);
    }
    return AppState.init();
  }
}

final epic = combineEpics<AppState>([saveEpic, getEpic]);

Stream<dynamic> saveEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
  Repo repo = Repo();

  return actions
      .where((action) =>
          action is AddItemAction ||
          action is DeleteItemAction ||
          action is UpdateItemAction)
      .asyncMap((action) => repo.saveToPrefs(store.state));
}

Stream<dynamic> getEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
  Repo repo = Repo();
  return actions
      .where((action) => action is GetItemsAction)
      .asyncMap((action) => repo.getPrefs().then((value) {
            print("GET EPIC");
            return LoadedItemsAction(
                (b) => b.items = ListBuilder<ToDoItem>(value.items!));
          }));
}
