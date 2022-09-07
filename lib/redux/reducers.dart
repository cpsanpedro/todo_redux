import 'package:built_collection/src/list.dart';
import 'package:redux/redux.dart';
import 'package:todo_redux/redux/actions.dart';

import '../model/model.dart';

final Reducer<AppState> appReducer = combineReducers<AppState>([
  TypedReducer<AppState, AddItemAction>(addItemReducer),
  TypedReducer<AppState, DeleteItemAction>(deleteItemReducer),
  TypedReducer<AppState, LoadedItemsAction>(loadedItemReducer),
  TypedReducer<AppState, UpdateItemAction>(updateItemReducer)
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
  return AppState((builder) => builder..items = action.items.toBuilder());
}

AppState updateItemReducer(AppState state, UpdateItemAction action) {
  return AppState((builder) {
    ListBuilder<ToDoItem> list = state.toBuilder().items;
    list.map((p0) {
      if (p0.id == action.item.id) {
        p0 = ToDoItem((b) => b
          ..title = action.item.title
          ..id = action.item.id);
      }
      return p0;
    });
    builder.items = list;
  });
}
