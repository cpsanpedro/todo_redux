import '../model/model.dart';
import '../services/api.dart';

abstract class AbstractRepo {
  Future<bool>? saveTodos(ToDoItem item);
  Future<List<ToDoItem>>? getTodos();
  Future<bool>? updateTodo(ToDoItem item);
  Future<bool>? deleteTodo(ToDoItem item);
}

class Repo implements AbstractRepo {
  @override
  Future<List<ToDoItem>> getTodos() {
    return Api.getTodos();
  }

  @override
  Future<bool> saveTodos(ToDoItem item) {
    return Api.saveTodos(item);
  }

  @override
  Future<bool>? updateTodo(ToDoItem item) {
    return Api.updateTodo(item);
  }

  @override
  Future<bool>? deleteTodo(ToDoItem item) {
    return Api.deleteTodo(item);
  }
}
