import 'package:todo_redux/redux/actions.dart';

import '../model/model.dart';

AppState appStateReducer(AppState state, action) {
  return AppState(items: itemReducer(state.items, action));
}

List<ToDoItem> itemReducer(List<ToDoItem> state, action) {
  if (action is AddItemAction) {
    return []
      ..addAll(state)
      ..add(ToDoItem(id: action.id, title: action.item));
  }

  if (action is DeleteItemAction) {
    return List.from(state)..remove(action.item);
  }

  return state;
}
