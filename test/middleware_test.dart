import 'package:built_collection/built_collection.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:todo_redux/model/model.dart';
import 'package:todo_redux/model/status.dart';
import 'package:todo_redux/redux/actions.dart';
import 'package:todo_redux/redux/middleware.dart';
import 'package:todo_redux/redux/reducers.dart';
import 'package:todo_redux/repository/repo.dart';

import 'mock_data.dart';

class MockRepo extends Mock implements AbstractRepo {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  MockRepo mockRepo = MockRepo();
  var appMiddleware = AppMiddleware(mockRepo);
  final epics = combineEpics<AppState>([appMiddleware]);
  Store<AppState> store = Store<AppState>(appReducer,
      initialState: AppState.init(), middleware: [EpicMiddleware(epics)]);

  setUpAll(() {
    const MethodChannel('plugins.flutter.io/shared_preferences_macos')
        .setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'getAll') {
        return <String, dynamic>{
          "flutter.id": "1"
        }; // set initial values here if desired
      }
      return null;
    });
  });

  test('should load init', () async {
    LoadedItemsAction emptyLoaded = LoadedItemsAction((b) => b
      ..items = ListBuilder([])
      ..status = Status.idle().toBuilder());

    when(mockRepo.getTodos()).thenAnswer((realInvocation) {
      return Future.value([]);
    });

    Stream<dynamic> stream = appMiddleware.call(
      Stream.fromIterable([GetItemsAction()]).asBroadcastStream(),
      EpicStore(store),
    );

    expect(await stream.toList(), [emptyLoaded]);
  });

  test('should load 1 item', () async {
    LoadedItemsAction loadedItemsAction = LoadedItemsAction((b) => b
      ..items = ListBuilder([mockList.first])
      ..status = Status.idle().toBuilder());

    when(mockRepo.getTodos()).thenAnswer((realInvocation) {
      return Future.value([mockList.first]);
    });

    Stream<dynamic> stream = appMiddleware.call(
      Stream.fromIterable([GetItemsAction()]).asBroadcastStream(),
      EpicStore(store),
    );

    expect(await stream.toList(), [loadedItemsAction]);
  });

  test('should add another item', () async {
    MockRepo mockRepo = MockRepo();
    var appMiddleware = AppMiddleware(mockRepo);
    final epics = combineEpics<AppState>([appMiddleware]);
    store = Store<AppState>(appReducer,
        initialState: AppState.init(), middleware: [EpicMiddleware(epics)]);

    AddItemAction addItemAction = AddItemAction((b) => b
      ..id = mockToDoItem.id
      ..title = mockToDoItem.title);
    AddItemAction addAnotherItemAction = AddItemAction((b) => b
      ..id = anotherMockToDoItem.id
      ..title = anotherMockToDoItem.title);
    LoadingAction isLoading =
        LoadingAction((b) => b.status = Status.loading().toBuilder());
    LoadingAction successLoadingOne = LoadingAction((b) => b.status =
        Status.success(message: "ToDo Added - ${mockToDoItem.title}")
            .toBuilder());
    LoadingAction successLoadingTwo = LoadingAction((b) => b.status =
        Status.success(message: "ToDo Added - ${anotherMockToDoItem.title}")
            .toBuilder());
    SuccessAddItemAction successAddOne = SuccessAddItemAction((b) => b.item
      ..title = mockToDoItem.title
      ..id = mockToDoItem.id);
    SuccessAddItemAction successAddTwo = SuccessAddItemAction((b) => b.item
      ..title = anotherMockToDoItem.title
      ..id = anotherMockToDoItem.id);

    store.dispatch(addItemAction);
    store.dispatch(addAnotherItemAction);

    when(mockRepo.saveTodos(mockToDoItem)).thenAnswer((realInvocation) {
      return Future.value(true);
    });
    when(mockRepo.saveTodos(anotherMockToDoItem)).thenAnswer((realInvocation) {
      return Future.value(true);
    });

    Stream<dynamic> stream = appMiddleware.call(
      Stream.fromIterable([addItemAction, addAnotherItemAction])
          .asBroadcastStream(),
      EpicStore(store),
    );

    expect(await stream.toList(), [
      isLoading,
      successAddOne,
      successLoadingOne,
      isLoading,
      successAddTwo,
      successLoadingTwo
    ]);
  });

  test('should delete 1 item', () async {
    DeleteItemAction deleteItemAction =
        DeleteItemAction((b) => b.item = mockToDoItem.toBuilder());

    LoadingAction isLoading =
        LoadingAction((b) => b.status = Status.loading().toBuilder());
    LoadingAction successLoading = LoadingAction((b) => b.status =
        Status.success(message: "ToDo Deleted - ${mockToDoItem.title}")
            .toBuilder());
    SuccessDeleteItemAction successDelete =
        SuccessDeleteItemAction((b) => b.item = mockToDoItem.toBuilder());

    when(mockRepo.deleteTodo(mockToDoItem)).thenAnswer((realInvocation) {
      return Future.value(true);
    });

    Stream<dynamic> stream = appMiddleware.call(
      Stream.fromIterable([deleteItemAction]).asBroadcastStream(),
      EpicStore(store),
    );

    expect(await stream.toList(), [isLoading, successDelete, successLoading]);
  });
}
