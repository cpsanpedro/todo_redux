class AppState {
  const AppState({required this.items});
  final List<ToDoItem> items;

  AppState.init() : items = List.unmodifiable([]);
}

class ToDoItem {
  const ToDoItem({required this.id, required this.title});
  final int id;
  final String title;

  ToDoItem copyWith({int? id, String? title}) {
    return ToDoItem(id: id ?? this.id, title: title ?? this.title);
  }

}