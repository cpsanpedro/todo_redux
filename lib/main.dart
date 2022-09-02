import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:todo_redux/model/model.dart';
import 'package:todo_redux/redux/actions.dart';
import 'package:todo_redux/redux/reducers.dart';

import 'redux/middleware.dart';
import 'view_model/view_model.dart';
import 'widget/add_item.dart';
import 'widget/todo_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    var epicMiddleware = EpicMiddleware(epic);
    final Store<AppState> store = Store<AppState>(appStateReducer,
        initialState: AppState.init(), middleware: [epicMiddleware]);
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: StoreBuilder<AppState>(
            onInit: (store) => store.dispatch(GetItemsAction()),
            builder: (context, store) {
              return MyHomePage(title: 'To-Do List', store: store);
            }),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.store});
  final String title;
  final Store<AppState> store;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

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
