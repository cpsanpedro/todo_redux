import 'package:built_collection/built_collection.dart';
import 'package:redux/redux.dart';
import 'package:test/test.dart';
import 'package:todo_redux/model/model.dart';
import 'package:todo_redux/redux/actions.dart';
import 'package:todo_redux/redux/reducers.dart';

ToDoItem get mockToDoItem => ToDoItem((item) => item
  ..id = "1"
  ..title = "Item 1");

ToDoItem get updatedMockToDoItem => ToDoItem((item) => item
  ..id = "1"
  ..title = "Updated Item 1");

AppState mockTodo() {
  return AppState((b) => b..items = ListBuilder<ToDoItem>([mockToDoItem]));
}

AppState updatedMockTodo() {
  return AppState(
      (b) => b..items = ListBuilder<ToDoItem>([updatedMockToDoItem]));
}

void main() {
  var store = Store<AppState>(appReducer, initialState: AppState.init());
  test('initial empty todo list', () {
    expect(store.state, AppState.init());
  });

  test('add one todo', () {
    store.dispatch(AddItemAction((b) => b
      ..id = mockToDoItem.id
      ..title = mockToDoItem.title));
    expect(store.state, mockTodo());
  });

  test('update one todo', () {
    store.dispatch(
        UpdateItemAction((b) => b.item = updatedMockToDoItem.toBuilder()));
    expect(store.state, updatedMockTodo());
  });

  test('delete one todo', () {
    store.dispatch(DeleteItemAction((b) => b.item = mockToDoItem.toBuilder()));
    expect(store.state, AppState.init());
  });
}
