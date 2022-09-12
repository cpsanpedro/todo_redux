import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';

import '../model/model.dart';
import '../redux/middleware.dart';
import '../redux/reducers.dart';
import '../repository/repo.dart';

Store<AppState> initStore() {
  final AbstractRepo todoRepo = Repo();
  var epicMiddleware = AppMiddleware(todoRepo);
  final epics = combineEpics<AppState>([epicMiddleware]);
  final Store<AppState> store = Store<AppState>(appReducer,
      initialState: AppState.init(), middleware: [EpicMiddleware(epics)]);
  return store;
}
