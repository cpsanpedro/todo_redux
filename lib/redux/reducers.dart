import 'package:redux/redux.dart';
import 'package:todo_redux/redux/actions.dart';

import '../model/model.dart';

final Reducer<AppState> appReducer = combineReducers<AppState>([
  TypedReducer<AppState, AddItemAction>(addItemReducer),
  TypedReducer<AppState, DeleteItemAction>(deleteItemReducer),
  TypedReducer<AppState, LoadedItemsAction>(loadedItemReducer)
]);

AppState addItemReducer(AppState state, AddItemAction action) {
  return AppState(
      items: [...state.items, ToDoItem(id: action.id, title: action.item)]);
}

AppState deleteItemReducer(AppState state, DeleteItemAction action) {
  return AppState(items: List.from(state.items)..remove(action.item));
}

AppState loadedItemReducer(AppState state, LoadedItemsAction action) {
  return AppState(items: action.items);
}
