import 'package:redux/redux.dart';
import 'package:test/test.dart';
import 'package:todo_redux/model/model.dart';
import 'package:todo_redux/redux/actions.dart';
import 'package:todo_redux/redux/reducers.dart';

import 'mock_data.dart';

void main() {
  var store = Store<AppState>(appReducer, initialState: AppState.init());
  test('initial empty todo list', () {
    expect(store.state, AppState.init());
  });

  test('add one todo', () {
    final newState = appReducer(store.state,
        SuccessAddItemAction((b) => b.item = mockToDoItem.toBuilder()));
    expect(newState, mockTodoState());
  });

  test('update one todo', () {
    final state = mockTodoState();
    final newState = appReducer(
        state,
        SuccessUpdateItemAction(
            (b) => b.item = updatedMockToDoItem.toBuilder()));
    expect(newState, updatedMockTodoState());
  });

  test('delete one todo', () {
    final state = mockTodoState();
    final newState = appReducer(state,
        SuccessDeleteItemAction((b) => b..item = mockToDoItem.toBuilder()));
    expect(newState, AppState.init());
  });
}
