import 'package:todo_redux/redux/actions.dart';

import '../model/model.dart';

AppState appStateReducer(AppState state, action) {
  print("APP REDUCER ${state.items}");
  return AppState(items: itemReducer(state.items, action));
}

List<ToDoItem> itemReducer(List<ToDoItem> state, action) {
  print("itemReducer ${action}");
  if (action is AddItemAction) {
    return [...state, ToDoItem(id: action.id, title: action.item)];
  }

  if (action is DeleteItemAction) {
    return List.from(state)..remove(action.item);
  }

  if (action is LoadedItemsAction) {
    return action.items;
  }

  return state;
}
