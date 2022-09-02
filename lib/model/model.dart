class AppState {
  const AppState({required this.items});
  final List<ToDoItem> items;

  AppState.init() : items = List.unmodifiable([]);

  AppState.fromJson(Map json)
      : items =
            (json["items"] as List).map((i) => ToDoItem.fromJson(i)).toList();

  toJson() => {'items': items};
}

class ToDoItem {
  const ToDoItem({required this.id, required this.title});
  final int id;
  final String title;

  ToDoItem copyWith({int? id, String? title}) {
    return ToDoItem(id: id ?? this.id, title: title ?? this.title);
  }

  ToDoItem.fromJson(Map json)
      : id = json["id"],
        title = json["title"];

  Map toJson() => {'id': id, 'title': title};
}
