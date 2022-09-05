import 'package:redux/redux.dart';

import '../model/model.dart';

class ToDoViewModel {
  ToDoViewModel({required this.items});
  final List<ToDoItem> items;

  factory ToDoViewModel.create(Store<AppState> store) {
    return ToDoViewModel(items: store.state.items);
  }
}
