import 'package:built_collection/built_collection.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_redux/model/model.dart';
import 'package:todo_redux/redux/actions.dart';
import 'package:todo_redux/redux/middleware.dart';
import 'package:todo_redux/redux/reducers.dart';
import 'package:todo_redux/repository/repo.dart';

import 'mock_data.dart';

class MockRepo extends Mock implements AbstractRepo {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  Store<AppState> store;

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

  test('should load', () async {
    MockRepo mockRepo = MockRepo();
    var appMiddleware = AppMiddleware(mockRepo);
    final epics = combineEpics<AppState>([appMiddleware]);
    store = Store<AppState>(appReducer,
        initialState: mockTodo(), middleware: [EpicMiddleware(epics)]);

    SharedPreferences.setMockInitialValues({"items": AppState.init()});

    AddItemAction addItemAction = AddItemAction((b) => b
      ..id = "1"
      ..title = "Item 1");

    LoadedItemsAction loadedItemsAction =
        LoadedItemsAction((b) => ListBuilder(mockList));

    when(mockRepo.getTodos()).thenAnswer((realInvocation) {
      return Future.value(mockTodo());
    });

    Stream<dynamic> stream = appMiddleware.call(
      Stream.fromIterable([GetItemsAction()]).asBroadcastStream(),
      EpicStore(store),
    );

    stream.toList().then((value) {
      print("STREAM");
    });

    // expect(await stream.toList(), mockTodo());

    // verify(mockRepo.saveTodos(mockTodo()));
  });
}
