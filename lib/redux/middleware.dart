import 'dart:convert';

import 'package:redux_epics/redux_epics.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_redux/model/model.dart';
import 'package:todo_redux/redux/actions.dart';

void saveToPrefs(AppState state) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var stateString = jsonEncode(state.toJson());
  print("SAVE: ${state.items}");
  await prefs.setString("items", stateString);
}

Future<AppState> getPrefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var stateString = prefs.getString("items");

  print("STATE STR ${stateString}");
  if (stateString != null) {
    Map map = jsonDecode(stateString);
    return AppState.fromJson(map);
  }
  return AppState.init();
}

final epic = combineEpics<AppState>([saveEpic, getEpic]);

Stream<dynamic> saveEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions
      .where((action) => action is AddItemAction || action is DeleteItemAction)
      .asyncMap((action) => saveToPrefs(store.state));
}

Stream<dynamic> getEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
  print("GET EPIC ${actions}");

  // var res = await getPrefs();
  // yield LoadedItemsAction(res.items);

  return actions.where((action) => action is GetItemsAction).asyncMap(
      (action) => getPrefs().then((value) => LoadedItemsAction(value.items)));

  // yield actions
  //     .where((action) => action is GetItemsAction)
  //     .asyncMap((action) => getPrefs().then((value) async* {
  //           print("LOAD get epic ${value}");
  //
  //           yield LoadedItemsAction(value.items);
  //         }));
}

// void appStateMiddleware(
//     Store<AppState> store, action, NextDispatcher next) async {
//   // if (action is AddItemAction || action is DeleteItemAction) {
//   //   print("SAVE PREF ${action.item}");
//   //   saveToPrefs(store.state);
//   // }
//
//   if (action is GetItemsAction) {
//     print("HET");
//     await getPrefs().then((value) {
//       print("LOAD ${value}");
//       store.dispatch(LoadedItemsAction(value.items));
//     });
//   }
// }
