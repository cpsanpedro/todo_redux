import 'package:built_collection/built_collection.dart';
import 'package:redux/redux.dart';
import 'package:test/test.dart';
import 'package:todo_redux/model/model.dart';
import 'package:todo_redux/redux/actions.dart';
import 'package:todo_redux/redux/reducers.dart';

AppState mockTodo() {
  return AppState((b) => b
    ..items = ListBuilder<ToDoItem>([
      ToDoItem((item) => item
        ..id = DateTime.now().toString().substring(0, 19)
        ..title = "Item 1")
    ]));
}

void main() {
  test('initial empty todo list', () {
    var store = Store<AppState>(appReducer, initialState: AppState.init());
    expect(store.state, AppState.init());
  });

  test('add one todo', () {
    var store = Store<AppState>(appReducer, initialState: AppState.init());
    store.dispatch(AddItemAction((b) => b
      ..id = DateTime.now().toString().substring(0, 19)
      ..title = "Item 1"));
    expect(store.state, mockTodo());
  });
}
