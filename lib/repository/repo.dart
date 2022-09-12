import '../model/model.dart';
import '../services/api.dart';

abstract class AbstractRepo {
  void saveTodos(AppState state);
  Future<AppState> getTodos();
}

class Repo implements AbstractRepo {
  @override
  Future<AppState> getTodos() {
    return Api.getTodos();
  }

  @override
  void saveTodos(AppState state) {
    return Api.saveTodos(state);
  }
}
