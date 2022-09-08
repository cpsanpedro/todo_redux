import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:todo_redux/model/model.dart';
import 'package:todo_redux/redux/actions.dart';
import 'package:todo_redux/redux/middleware.dart';

import 'mock_data.dart';

class MockRepo extends Mock implements Repo {}

class MockStore extends Mock implements Store<AppState> {}

void main() {
  MockRepo repo;
  MockStore? mockStore;

  setUp(() {
    mockStore = MockStore();
  });

  test('should load', () {
    repo = MockRepo();

    var epicMiddleware = EpicMiddleware(epic);
    // final store = Store<AppState>(
    //   appReducer,
    //   initialState: AppState.init(),
    //   middleware: [epicMiddleware],
    // );

    final action = AddItemAction((b) => b
      ..id = "1"
      ..title = "Item 1");

    final state = AddItemAction((b) => b
      ..id = "1"
      ..title = "Item 1");

    Stream<dynamic> actual = getEpic.call(
      Stream.fromIterable([action]).asBroadcastStream(),
      EpicStore<AppState>(mockStore!),
    );

    when(repo.saveToPrefs(mockStore!.state))
        .thenAnswer((realInvocation) => Future.value(mockTodo()));

    // verify(repo.getPrefs());

    // when(repository.loadTodos()).thenAnswer((_) => Future.value(todos));

    // mockStore?.dispatch(LoadedItemsAction());

    // expect(actual, [
    //   GetItemsAction(),
    //   AddItemAction((b) => b
    //     ..id = mockToDoItem.id
    //     ..title = mockToDoItem.title)
    // ]);
  });
}
