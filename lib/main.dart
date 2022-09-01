import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:todo_redux/model/model.dart';
import 'package:todo_redux/redux/reducers.dart';

import 'view_model/view_model.dart';
import 'widget/add_item.dart';
import 'widget/todo_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Store<AppState> store =
        Store<AppState>(appStateReducer, initialState: AppState.init());

    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'To-Do List'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// @immutable
// class AppState {
//   const AppState({required this.todoItems});
//   final Iterable<String> todoItems;
// }
//
// @immutable
// abstract class AppAction {
//   const AppAction();
// }
//
// @immutable
// abstract class ItemAction extends AppAction {
//   const ItemAction(this.item);
//   final String item;
// }
//
// @immutable
// class AddItemAction extends ItemAction {
//   const AddItemAction(String todoItem) : super(todoItem);
// }
//
// @immutable
// class DeleteItemAction extends ItemAction {
//   const DeleteItemAction(String todoItem) : super(todoItem);
// }
//
// Iterable<String> addItemReducer(Iterable<String> prevItems, AddItemAction action) => prevItems.followedBy([action.item]);

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StoreConnector<AppState, ToDoViewModel>(
          converter: (Store<AppState> store) => ToDoViewModel.create(store),
          builder: (BuildContext context, ToDoViewModel viewModel) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  AddItemWidget(model: viewModel),
                  Expanded(child: TodoListWidget(model: viewModel))
                ],
              ),
            );
          }),
    );
  }
}
