import 'package:redux/redux.dart';
import 'package:redux_compact/redux_compact.dart';
import 'package:todo_redux/redux/repo_action.dart';

import '../model/model.dart';
import '../repository/repo.dart';

Store<AppState> initStore() {
  final compactReducer = ReduxCompact.createReducer<AppState>();
  final compactMiddleware = ReduxCompact.createMiddleware<AppState>();

  RepoAction.repository = Repo();
  final Store<AppState> store = Store<AppState>(compactReducer,
      initialState: AppState.init(), middleware: [compactMiddleware]);
  return store;
}
