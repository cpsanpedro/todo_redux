import 'package:built_collection/built_collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:todo_redux/constants/consts.dart';
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
  late MockRepo mockRepo;
  late AppMiddleware appMiddleware;
  Stream<dynamic> Function(Stream<dynamic>, EpicStore<AppState>) epics;
  late Store<AppState> store;
  late LoadingAction isLoading;
  late LoadingAction successLoadingOne;
  late AddItemAction addItemAction;
  late SuccessAddItemAction successAddOne;
  late DeleteItemAction deleteItemAction;
  late UpdateItemAction updateItemAction;

  setUpAll(() {
    isLoading = LoadingAction((b) => b.status = Status.loading().toBuilder());
    successLoadingOne = LoadingAction((b) => b.status =
        Status.success(message: "${Label.todoAdded} - ${mockToDoItem.title}")
            .toBuilder());
    addItemAction = AddItemAction((b) => b
      ..id = mockToDoItem.id
      ..title = mockToDoItem.title);
    successAddOne = SuccessAddItemAction((b) => b.item
      ..title = mockToDoItem.title
      ..id = mockToDoItem.id);
    deleteItemAction =
        DeleteItemAction((b) => b.item = mockToDoItem.toBuilder());
    updateItemAction =
        UpdateItemAction((b) => b.item = updatedMockToDoItem.toBuilder());
  });

  setUp(() {
    mockRepo = MockRepo();
    appMiddleware = AppMiddleware(mockRepo);
    epics = combineEpics<AppState>([appMiddleware]);
    store = Store<AppState>(appReducer,
        initialState: AppState.init(), middleware: [EpicMiddleware(epics)]);
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

  test('should add item', () async {
    when(mockRepo.saveTodos(mockToDoItem)).thenAnswer((realInvocation) {
      return Future.value(true);
    });

    Stream<dynamic> stream = appMiddleware.call(
      Stream.fromIterable([addItemAction]).asBroadcastStream(),
      EpicStore(store),
    );

    expect(await stream.toList(), [
      isLoading,
      successAddOne,
      successLoadingOne,
    ]);
  });

  test('should return error add item', () async {
    LoadingAction errorLoading = LoadingAction((b) =>
        b.status = Status.error(message: Label.errorAddingToDo).toBuilder());

    when(mockRepo.saveTodos(mockToDoItem)).thenAnswer((realInvocation) {
      return Future.value(false);
    });

    Stream<dynamic> stream = appMiddleware.call(
      Stream.fromIterable([addItemAction]).asBroadcastStream(),
      EpicStore(store),
    );

    expect(await stream.toList(), [
      isLoading,
      errorLoading,
    ]);
  });

  test('should return exception add item', () async {
    LoadingAction errorLoading = LoadingAction(
        (b) => b.status = Status.error(message: "Add Failed").toBuilder());

    when(mockRepo.saveTodos(mockToDoItem)).thenThrow("Add Failed");

    Stream<dynamic> stream = appMiddleware.call(
      Stream.fromIterable([addItemAction]).asBroadcastStream(),
      EpicStore(store),
    );

    expect(await stream.toList(), [
      isLoading,
      errorLoading,
    ]);
  });

  test('should add another item', () async {
    AddItemAction addAnotherItemAction = AddItemAction((b) => b
      ..id = anotherMockToDoItem.id
      ..title = anotherMockToDoItem.title);
    LoadingAction successLoadingTwo = LoadingAction((b) => b.status =
        Status.success(
                message: "${Label.todoAdded} - ${anotherMockToDoItem.title}")
            .toBuilder());
    SuccessAddItemAction successAddTwo = SuccessAddItemAction((b) => b.item
      ..title = anotherMockToDoItem.title
      ..id = anotherMockToDoItem.id);

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
    LoadingAction successLoading = LoadingAction((b) => b.status =
        Status.success(message: "${Label.todoDeleted} - ${mockToDoItem.title}")
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

  test('should return error in api delete 1 item', () async {
    LoadingAction errorLoading = LoadingAction((b) =>
        b.status = Status.error(message: Label.errorDeletingToDo).toBuilder());

    when(mockRepo.deleteTodo(mockToDoItem)).thenAnswer((realInvocation) {
      return Future.value(false);
    });

    Stream<dynamic> stream = appMiddleware.call(
      Stream.fromIterable([deleteItemAction]).asBroadcastStream(),
      EpicStore(store),
    );

    expect(await stream.toList(), [isLoading, errorLoading]);
  });

  test('should return exception delete 1 item', () async {
    LoadingAction errorLoading = LoadingAction(
        (b) => b.status = Status.error(message: "Delete failed").toBuilder());

    when(mockRepo.deleteTodo(mockToDoItem)).thenThrow("Delete failed");

    Stream<dynamic> stream = appMiddleware.call(
      Stream.fromIterable([deleteItemAction]).asBroadcastStream(),
      EpicStore(store),
    );

    expect(await stream.toList(), [isLoading, errorLoading]);
  });

  test('should update 1 item', () async {
    LoadingAction successLoading = LoadingAction((b) =>
        b.status = Status.success(message: "${Label.todoUpdated}").toBuilder());
    SuccessUpdateItemAction successUpdated = SuccessUpdateItemAction(
        (b) => b.item = updatedMockToDoItem.toBuilder());

    when(mockRepo.updateTodo(updatedMockToDoItem)).thenAnswer((realInvocation) {
      return Future.value(true);
    });

    Stream<dynamic> stream = appMiddleware.call(
      Stream.fromIterable([updateItemAction]).asBroadcastStream(),
      EpicStore(store),
    );

    expect(await stream.toList(), [isLoading, successUpdated, successLoading]);
  });

  test('should return error updated 1 item', () async {
    LoadingAction errorLoading = LoadingAction((b) => b.status =
        Status.error(message: "${Label.errorUpdatingToDo}").toBuilder());

    when(mockRepo.updateTodo(updatedMockToDoItem)).thenAnswer((realInvocation) {
      return Future.value(false);
    });

    Stream<dynamic> stream = appMiddleware.call(
      Stream.fromIterable([updateItemAction]).asBroadcastStream(),
      EpicStore(store),
    );

    expect(await stream.toList(), [isLoading, errorLoading]);
  });

  test('should return exception updated 1 item', () async {
    LoadingAction errorLoading = LoadingAction(
        (b) => b.status = Status.error(message: "Update Failed").toBuilder());

    when(mockRepo.updateTodo(updatedMockToDoItem)).thenThrow("Update Failed");

    Stream<dynamic> stream = appMiddleware.call(
      Stream.fromIterable([updateItemAction]).asBroadcastStream(),
      EpicStore(store),
    );

    expect(await stream.toList(), [isLoading, errorLoading]);
  });
}
