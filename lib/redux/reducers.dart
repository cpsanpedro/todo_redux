import 'package:built_collection/src/list.dart';
import 'package:redux/redux.dart';
import 'package:todo_redux/redux/actions.dart';

import '../model/model.dart';

final Reducer<AppState> appReducer = combineReducers<AppState>([
  TypedReducer<AppState, AddItemAction>(addItemReducer),
  TypedReducer<AppState, DeleteItemAction>(deleteItemReducer),
  TypedReducer<AppState, LoadedItemsAction>(loadedItemReducer)
]);

AppState addItemReducer(AppState state, AddItemAction action) {
  print("REDEUCER ADD ${DateTime.now().toString()}");
  return AppState((builder) => builder
    ..items = ListBuilder<ToDoItem>([
      ...?state.items,
      ToDoItem((b) => b
        ..title = action.title
        ..id = DateTime.now().toString())
    ]));
}

AppState deleteItemReducer(AppState state, DeleteItemAction action) {
  return AppState((builder) {
    ListBuilder<ToDoItem> list = state.toBuilder().items;
    list.remove(action.item);
    builder.items = list;
  });
}

AppState loadedItemReducer(AppState state, LoadedItemsAction action) {
  print("LOADED ${action.items}");
  return AppState((builder) => builder..items = action.items.toBuilder());
}
