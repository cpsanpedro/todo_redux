import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:redux/redux.dart';
import 'package:redux_compact/redux_compact.dart';
import 'package:todo_redux/constants/consts.dart';
import 'package:todo_redux/model/model.dart';
import 'package:todo_redux/model/status.dart';
import 'package:todo_redux/redux/actions.dart';
import 'package:todo_redux/redux/repo_action.dart';
import 'package:todo_redux/repository/repo.dart';

import 'mock_data.dart';

class MockRepo extends Mock implements AbstractRepo {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Store<AppState> store;

  setUp(() {
    RepoAction.repository = MockRepo();
    final compactReducer = ReduxCompact.createReducer<AppState>();
    final compactMiddleware = ReduxCompact.createMiddleware<AppState>();

    store = Store<AppState>(compactReducer,
        initialState: AppState.init(), middleware: [compactMiddleware]);
  });

  test('should load init', () async {
    LoadedItemsAction emptyLoaded =
        LoadedItemsAction((b) => b..status = Status.idle().toBuilder());

    when(RepoAction.repository.getTodos()).thenAnswer((realInvocation) {
      return Future.value([]);
    });

    scheduleMicrotask(() {
      store.dispatch(emptyLoaded);
      Future.delayed(Duration.zero, store.teardown);
    });

    final loadingState =
        store.state.rebuild((p0) => p0..status = Status.loading().toBuilder());
    final successState = store.state.rebuild((p0) => p0
      ..items = ListBuilder([])
      ..status = Status.idle().toBuilder());

    expect(
        store.onChange, emitsInOrder([loadingState, successState, emitsDone]));
  });

  test('should load 1 item', () async {
    LoadedItemsAction loadedItemsAction =
        LoadedItemsAction((b) => b..status = Status.idle().toBuilder());

    when(RepoAction.repository.getTodos()).thenAnswer((realInvocation) {
      return Future.value([mockList.first]);
    });

    scheduleMicrotask(() {
      store.dispatch(loadedItemsAction);
      Future.delayed(Duration.zero, store.teardown);
    });

    final loadingState =
        store.state.rebuild((p0) => p0..status = Status.loading().toBuilder());
    final successState = store.state.rebuild((p0) => p0
      ..items = ListBuilder([mockList.first])
      ..status = Status.idle().toBuilder());

    expect(
        store.onChange, emitsInOrder([loadingState, successState, emitsDone]));
  });

  test('should add item', () async {
    AddItemAction addItemAction = AddItemAction((b) => b
      ..id = mockToDoItem.id
      ..title = mockToDoItem.title);

    when(RepoAction.repository.saveTodos(mockToDoItem))
        .thenAnswer((realInvocation) {
      return Future.value(true);
    });

    scheduleMicrotask(() {
      store.dispatch(addItemAction);
      Future.delayed(Duration.zero, store.teardown);
    });

    final loadingState =
        store.state.rebuild((p0) => p0..status = Status.loading().toBuilder());
    final successState = store.state.rebuild((p0) => p0
      ..items = ListBuilder([mockList.first])
      ..status = Status.success(message: Label.todoAdded).toBuilder());

    expect(
        store.onChange, emitsInOrder([loadingState, successState, emitsDone]));
  });

  test('should return error add item', () async {
    AddItemAction addItemAction = AddItemAction((b) => b
      ..id = mockToDoItem.id
      ..title = mockToDoItem.title);

    when(RepoAction.repository.saveTodos(mockToDoItem))
        .thenAnswer((realInvocation) {
      return Future.value(false);
    });

    scheduleMicrotask(() {
      store.dispatch(addItemAction);
      Future.delayed(Duration.zero, store.teardown);
    });

    final loadingState =
        store.state.rebuild((p0) => p0..status = Status.loading().toBuilder());
    final errorState = store.state.rebuild((p0) =>
        p0..status = Status.error(message: Label.errorAddingToDo).toBuilder());

    expect(store.onChange, emitsInOrder([loadingState, errorState, emitsDone]));
  });

  test('should return exception add item', () async {
    AddItemAction addItemAction = AddItemAction((b) => b
      ..id = mockToDoItem.id
      ..title = mockToDoItem.title);

    when(RepoAction.repository.saveTodos(mockToDoItem))
        .thenThrow(Exception("Add Failed"));

    scheduleMicrotask(() {
      store.dispatch(addItemAction);
      Future.delayed(Duration.zero, store.teardown);
    });

    final errorState = store.state.rebuild(
        (p0) => p0..status = Status.error(message: "Add Failed").toBuilder());

    expect(store.onChange, emitsInOrder([errorState, emitsDone]));
  });

  test('should add another item', () async {
    AddItemAction addItemAction = AddItemAction((b) => b
      ..id = mockToDoItem.id
      ..title = mockToDoItem.title);
    AddItemAction addAnotherItemAction = AddItemAction((b) => b
      ..id = anotherMockToDoItem.id
      ..title = anotherMockToDoItem.title);

    when(RepoAction.repository.saveTodos(mockToDoItem))
        .thenAnswer((realInvocation) {
      return Future.value(true);
    });
    when(RepoAction.repository.saveTodos(anotherMockToDoItem))
        .thenAnswer((realInvocation) {
      return Future.value(true);
    });

    scheduleMicrotask(() {
      store.dispatch(addItemAction);
      store.dispatch(addAnotherItemAction);
      Future.delayed(Duration.zero, store.teardown);
    });

    final loadingState =
        store.state.rebuild((p0) => p0..status = Status.loading().toBuilder());
    final successState = store.state.rebuild((p0) => p0
      ..items = ListBuilder([mockList.first])
      ..status = Status.success(message: Label.todoAdded).toBuilder());
    final successAddedState = store.state.rebuild((p0) => p0
      ..items = ListBuilder(mockList)
      ..status = Status.success(message: Label.todoAdded).toBuilder());

    expect(
        store.onChange,
        emitsInOrder([
          loadingState,
          loadingState,
          successState,
          successAddedState,
          emitsDone
        ]));
  });

  test('should delete 1 item', () async {
    DeleteItemAction deleteItemAction =
        DeleteItemAction((b) => b.item = mockToDoItem.toBuilder());
    LoadedItemsAction loadedItemsAction =
        LoadedItemsAction((b) => b..status = Status.idle().toBuilder());

    when(RepoAction.repository.getTodos()).thenAnswer((realInvocation) {
      return Future.value([mockList.first]);
    });
    when(RepoAction.repository.deleteTodo(mockToDoItem))
        .thenAnswer((realInvocation) {
      return Future.value(true);
    });

    scheduleMicrotask(() {
      store.dispatch(loadedItemsAction);
      store.dispatch(deleteItemAction);
      Future.delayed(Duration.zero, store.teardown);
    });

    final loadingState =
        store.state.rebuild((p0) => p0..status = Status.loading().toBuilder());
    final idleState = store.state.rebuild((p0) => p0
      ..items = ListBuilder([mockList.first])
      ..status = Status.idle().toBuilder());
    final successState = store.state.rebuild((p0) => p0
      ..items = ListBuilder([])
      ..status = Status.success(
              message: "${Label.todoDeleted} - ${mockToDoItem.title}")
          .toBuilder());

    expect(
        store.onChange,
        emitsInOrder(
            [loadingState, loadingState, idleState, successState, emitsDone]));
  });

  test('should return error in api delete 1 item', () async {
    DeleteItemAction deleteItemAction =
        DeleteItemAction((b) => b.item = mockToDoItem.toBuilder());
    LoadedItemsAction loadedItemsAction =
        LoadedItemsAction((b) => b..status = Status.idle().toBuilder());

    when(RepoAction.repository.getTodos()).thenAnswer((realInvocation) {
      return Future.value([mockList.first]);
    });
    when(RepoAction.repository.deleteTodo(mockToDoItem))
        .thenAnswer((realInvocation) {
      return Future.value(false);
    });

    scheduleMicrotask(() {
      store.dispatch(loadedItemsAction);
      store.dispatch(deleteItemAction);
      Future.delayed(Duration.zero, store.teardown);
    });

    final loadingState =
        store.state.rebuild((p0) => p0..status = Status.loading().toBuilder());
    final idleState = store.state.rebuild((p0) => p0
      ..items = ListBuilder([mockList.first])
      ..status = Status.idle().toBuilder());
    final errorState = store.state.rebuild((p0) => p0
      ..items = ListBuilder([mockList.first])
      ..status = Status.error(message: Label.errorDeletingToDo).toBuilder());

    expect(
        store.onChange,
        emitsInOrder(
            [loadingState, loadingState, idleState, errorState, emitsDone]));
  });

  test('should return exception delete 1 item', () async {
    DeleteItemAction deleteItemAction =
        DeleteItemAction((b) => b.item = mockToDoItem.toBuilder());
    LoadedItemsAction loadedItemsAction =
        LoadedItemsAction((b) => b..status = Status.idle().toBuilder());

    when(RepoAction.repository.getTodos()).thenAnswer((realInvocation) {
      return Future.value([mockList.first]);
    });
    when(RepoAction.repository.deleteTodo(mockToDoItem))
        .thenThrow(Exception("Delete failed"));

    scheduleMicrotask(() {
      store.dispatch(loadedItemsAction);
      store.dispatch(deleteItemAction);
      Future.delayed(Duration.zero, store.teardown);
    });

    final loadingState =
        store.state.rebuild((p0) => p0..status = Status.loading().toBuilder());
    final idleState = store.state.rebuild((p0) => p0
      ..items = ListBuilder([mockList.first])
      ..status = Status.idle().toBuilder());
    final errorState = store.state.rebuild((p0) =>
        p0..status = Status.error(message: "Delete failed").toBuilder());

    expect(store.onChange,
        emitsInOrder([loadingState, errorState, idleState, emitsDone]));
  });

  test('should update 1 item', () async {
    LoadedItemsAction loadedItemsAction =
        LoadedItemsAction((b) => b..status = Status.idle().toBuilder());
    UpdateItemAction updateItemAction =
        UpdateItemAction((b) => b.item = updatedMockToDoItem.toBuilder());

    when(RepoAction.repository.getTodos()).thenAnswer((realInvocation) {
      return Future.value([mockList.first]);
    });
    when(RepoAction.repository.updateTodo(updatedMockToDoItem))
        .thenAnswer((realInvocation) {
      return Future.value(true);
    });

    scheduleMicrotask(() {
      store.dispatch(loadedItemsAction);
      store.dispatch(updateItemAction);
      Future.delayed(Duration.zero, store.teardown);
    });

    final loadingState =
        store.state.rebuild((p0) => p0..status = Status.loading().toBuilder());
    final idleState = store.state.rebuild((p0) => p0
      ..items = ListBuilder([mockList.first])
      ..status = Status.idle().toBuilder());
    final successState = store.state.rebuild((p0) => p0
      ..items = ListBuilder([updatedMockToDoItem])
      ..status = Status.success(message: Label.todoUpdated).toBuilder());

    expect(
        store.onChange,
        emitsInOrder(
            [loadingState, loadingState, idleState, successState, emitsDone]));
  });

  test('should return error updated 1 item', () async {
    LoadedItemsAction loadedItemsAction =
        LoadedItemsAction((b) => b..status = Status.idle().toBuilder());
    UpdateItemAction updateItemAction =
        UpdateItemAction((b) => b.item = updatedMockToDoItem.toBuilder());

    when(RepoAction.repository.getTodos()).thenAnswer((realInvocation) {
      return Future.value([mockList.first]);
    });
    when(RepoAction.repository.updateTodo(updatedMockToDoItem))
        .thenAnswer((realInvocation) {
      return Future.value(false);
    });

    scheduleMicrotask(() {
      store.dispatch(loadedItemsAction);
      store.dispatch(updateItemAction);
      Future.delayed(Duration.zero, store.teardown);
    });

    final loadingState =
        store.state.rebuild((p0) => p0..status = Status.loading().toBuilder());
    final idleState = store.state.rebuild((p0) => p0
      ..items = ListBuilder([mockList.first])
      ..status = Status.idle().toBuilder());
    final errorState = store.state.rebuild((p0) => p0
      ..items = ListBuilder([mockToDoItem])
      ..status = Status.error(message: Label.errorUpdatingToDo).toBuilder());

    expect(
        store.onChange,
        emitsInOrder(
            [loadingState, loadingState, idleState, errorState, emitsDone]));
  });

  test('should return exception updated 1 item', () async {
    LoadedItemsAction loadedItemsAction =
        LoadedItemsAction((b) => b..status = Status.idle().toBuilder());
    UpdateItemAction updateItemAction =
        UpdateItemAction((b) => b.item = updatedMockToDoItem.toBuilder());

    when(RepoAction.repository.getTodos()).thenAnswer((realInvocation) {
      return Future.value([mockList.first]);
    });
    when(RepoAction.repository.updateTodo(updatedMockToDoItem))
        .thenThrow(Exception("Update failed"));

    scheduleMicrotask(() {
      store.dispatch(loadedItemsAction);
      store.dispatch(updateItemAction);
      Future.delayed(Duration.zero, store.teardown);
    });

    final loadingState =
        store.state.rebuild((p0) => p0..status = Status.loading().toBuilder());
    final idleState = store.state.rebuild((p0) => p0
      ..items = ListBuilder([mockList.first])
      ..status = Status.idle().toBuilder());
    final errorState = store.state.rebuild((p0) =>
        p0..status = Status.error(message: "Update failed").toBuilder());

    expect(store.onChange,
        emitsInOrder([loadingState, errorState, idleState, emitsDone]));
  });
}
