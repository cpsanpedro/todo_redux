import 'package:built_collection/built_collection.dart';
import 'package:todo_redux/model/model.dart';

List<ToDoItem> mockList = [mockToDoItem, anotherMockToDoItem];

ToDoItem get mockToDoItem => ToDoItem((item) => item
  ..id = "1"
  ..title = "Item 1");

ToDoItem get updatedMockToDoItem => ToDoItem((item) => item
  ..id = "1"
  ..title = "Updated Item 1");

ToDoItem get anotherMockToDoItem => ToDoItem((item) => item
  ..id = "2"
  ..title = "Item 2");

AppState mockTodoState() {
  return AppState((b) => b..items = ListBuilder<ToDoItem>([mockToDoItem]));
}

AppState updatedMockTodoState() {
  return AppState(
      (b) => b..items = ListBuilder<ToDoItem>([updatedMockToDoItem]));
}

AppState anotherMockTodoState() {
  return AppState(
      (b) => b..items = ListBuilder<ToDoItem>([anotherMockToDoItem]));
}

AppState mockTodosState() {
  return AppState((b) =>
      b..items = ListBuilder<ToDoItem>([mockToDoItem, anotherMockToDoItem]));
}
