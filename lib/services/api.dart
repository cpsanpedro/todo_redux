import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/model.dart';

class Api {
  static Future<List> getList() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await Future.delayed(const Duration(seconds: 1));
      var stateString = prefs.getString("items") ?? "";
      List<dynamic> todos = [];
      if (stateString.isNotEmpty) {
        Map map = jsonDecode(stateString);
        todos = map["items"];
      }
      return todos;
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<ToDoItem>> getAndParsedList() async {
    List<dynamic> todos = await getList();
    List<ToDoItem> parsedTodos = [];
    parsedTodos
        .addAll(todos.map<ToDoItem>((e) => ToDoItem.fromJson(e)!).toList());
    return parsedTodos;
  }

  static Future<List<ToDoItem>> getTodos() async {
    try {
      List<dynamic> list = await getList();
      print("LIST ${list}");

      List<ToDoItem> todos =
          list.map<ToDoItem>((e) => ToDoItem.fromJson(e)!).toList();

      return todos;
    } catch (e) {
      rethrow;
    }
  }

  static Future<bool> saveTodos(ToDoItem item) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      List<dynamic> todos = await getList();

      List<ToDoItem> parsedTodos = [];
      parsedTodos
          .addAll(todos.map<ToDoItem>((e) => ToDoItem.fromJson(e)!).toList());
      parsedTodos.add(item);
      Map<String, List<ToDoItem>> newMap = {"items": parsedTodos};

      return prefs.setString("items", jsonEncode(newMap));
    } catch (e) {
      rethrow;
    }
  }

  static Future<bool> updateTodo(ToDoItem item) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      List<ToDoItem> parsedTodos = await getAndParsedList();
      int index = parsedTodos.indexWhere((element) => element.id == item.id);
      parsedTodos[index] = item;
      Map<String, List<ToDoItem>> newMap = {"items": parsedTodos};
      return prefs.setString("items", jsonEncode(newMap));
    } catch (e) {
      rethrow;
    }
  }

  static Future<bool> deleteTodo(ToDoItem item) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<ToDoItem> parsedTodos = await getAndParsedList();
      parsedTodos.removeWhere((element) => element.id == item.id);
      Map<String, List<ToDoItem>> newMap = {"items": parsedTodos};

      return prefs.setString("items", jsonEncode(newMap));
    } catch (e) {
      rethrow;
    }
  }
}
