import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/model.dart';

class Api {
  static Future<List> getList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var stateString = prefs.getString("items") ?? "";
    List<dynamic> todos = [];
    if (stateString.isNotEmpty) {
      Map map = jsonDecode(stateString);
      todos = map["items"];
    }
    return todos;
  }

  static Future<List<ToDoItem>> getAndParsedList() async {
    List<dynamic> todos = await getList();
    List<ToDoItem> parsedTodos = [];
    parsedTodos
        .addAll(todos.map<ToDoItem>((e) => ToDoItem.fromJson(e)!).toList());
    return parsedTodos;
  }

  static Future<List<ToDoItem>> getTodos() async {
    List<dynamic> list = await getList();

    List<ToDoItem> todos =
        list.map<ToDoItem>((e) => ToDoItem.fromJson(e)!).toList();

    return todos;
  }

  static Future<bool> saveTodos(ToDoItem item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<dynamic> todos = await getList();

    List<ToDoItem> parsedTodos = [];
    parsedTodos
        .addAll(todos.map<ToDoItem>((e) => ToDoItem.fromJson(e)!).toList());
    parsedTodos.add(item);
    Map<String, List<ToDoItem>> newMap = {"items": parsedTodos};

    return prefs.setString("items", jsonEncode(newMap));
  }

  static Future<bool> updateTodo(ToDoItem item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<ToDoItem> parsedTodos = await getAndParsedList();
    int index = parsedTodos.indexWhere((element) => element.id == item.id);
    parsedTodos[index] = item;
    Map<String, List<ToDoItem>> newMap = {"items": parsedTodos};

    return prefs.setString("items", jsonEncode(newMap));
  }

  static Future<bool> deleteTodo(ToDoItem item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<ToDoItem> parsedTodos = await getAndParsedList();
    parsedTodos.removeWhere((element) => element.id == item.id);
    Map<String, List<ToDoItem>> newMap = {"items": parsedTodos};

    return prefs.setString("items", jsonEncode(newMap));
  }
}
