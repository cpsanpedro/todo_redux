import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_redux/model/model.dart';
import 'package:todo_redux/redux/actions.dart';
import 'package:todo_redux/redux/middleware.dart';
import 'package:todo_redux/redux/reducers.dart';

import 'middleware_test.mocks.dart';
import 'mock_data.dart';

@GenerateMocks([Repo])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  Store<AppState> store;
  MockRepo mockRepo = MockRepo();

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
    var appMiddleware = AppMiddleware();
    final epics = combineEpics<AppState>([appMiddleware]);
    store = Store<AppState>(appReducer,
        initialState: mockTodo(), middleware: [EpicMiddleware(epics)]);

    SharedPreferences.setMockInitialValues({"items": AppState.init()});

    store.dispatch(AddItemAction((b) => b
      ..id = "1"
      ..title = "Item 1"));

    when(mockRepo.saveTodos(mockTodo())).thenAnswer((realInvocation) {
      return Future.value(mockTodo());
    });

    verify(mockRepo.saveTodos(mockTodo()));
  });
}
