import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/model.dart';

class Api {
  static Future<AppState> getTodos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var stateString = prefs.getString("items");

    if (stateString != null) {
      print("API STATE ${stateString}");
      Map map = jsonDecode(stateString);
      return AppState.fromJson(map);
    }
    print("HERE api");
    return AppState.init();
  }

  static void saveTodos(AppState state) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("save prefs ${state.toJson()}");
    await prefs.setString("items", state.toJson());
  }
}
