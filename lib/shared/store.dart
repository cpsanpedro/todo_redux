import 'package:redux/redux.dart';
import 'package:redux_compact/redux_compact.dart';

import '../model/model.dart';
import '../repository/repo.dart';

Store<AppState> initStore() {
  final compactReducer = ReduxCompact.createReducer<AppState>();
  final compactMiddleware = ReduxCompact.createMiddleware<AppState>();

  final AbstractRepo todoRepo = Repo();
  // var epicMiddleware = AppMiddleware(todoRepo);
  // final epics = combineEpics<AppState>([compactMiddleware]);
  final Store<AppState> store = Store<AppState>(compactReducer,
      initialState: AppState.init(), middleware: [compactMiddleware]);
  return store;
}
