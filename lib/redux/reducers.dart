import 'package:built_collection/src/list.dart';
import 'package:redux/redux.dart';
import 'package:todo_redux/redux/actions.dart';

import '../model/model.dart';

final Reducer<AppState> appReducer = combineReducers<AppState>([
  TypedReducer<AppState, SuccessAddItemAction>(addItemReducer),
  TypedReducer<AppState, SuccessDeleteItemAction>(deleteItemReducer),
  TypedReducer<AppState, LoadedItemsAction>(loadedItemReducer),
  TypedReducer<AppState, SuccessUpdateItemAction>(updateItemReducer),
  TypedReducer<AppState, LoadingAction>(loadingReducer),
]);

AppState addItemReducer(AppState state, SuccessAddItemAction action) {
  return state.rebuild((p0) => p0
    ..items = ListBuilder<ToDoItem>([
      ...?state.items,
      ToDoItem((b) => b
        ..title = action.item.title
        ..id = action.item.id)
    ]));
}

AppState deleteItemReducer(AppState state, SuccessDeleteItemAction action) {
  return state.rebuild((p0) {
    ListBuilder<ToDoItem> list = state.toBuilder().items;
    list.remove(action.item);
    p0.items = list;
  });
}

AppState loadedItemReducer(AppState state, LoadedItemsAction action) {
  return state.rebuild((p0) => p0..items = action.items.toBuilder());
}

AppState updateItemReducer(AppState state, SuccessUpdateItemAction action) {
  return state.rebuild((builder) {
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

AppState loadingReducer(AppState state, LoadingAction action) {
  return state.rebuild((p0) => p0
    ..items = state.toBuilder().items
    ..status = action.status?.toBuilder());
}
