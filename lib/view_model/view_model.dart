import 'package:redux/redux.dart';

import '../model/model.dart';
import '../redux/actions.dart';

class ToDoViewModel {
  ToDoViewModel({required this.items, required this.onAddItem, required this.onDeleteItem});
  final List<ToDoItem> items;
  final Function(String) onAddItem;
  final Function(ToDoItem) onDeleteItem;

  factory ToDoViewModel.create(Store<AppState> store) {
    onAddItem(String title) {
      store.dispatch(AddItemAction(title));
    }

    onDeleteItem(ToDoItem item) {
      store.dispatch(DeleteItemAction(item));
    }

    return ToDoViewModel(items: store.state.items, onAddItem: onAddItem, onDeleteItem: onDeleteItem);
  }
}
