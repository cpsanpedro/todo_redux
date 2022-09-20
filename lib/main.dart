import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:todo_redux/shared/store.dart';

import 'gen/assets.gen.dart';
import 'model/model.dart';
import 'model/status.dart';
import 'redux/actions.dart';
import 'view_model/view_model.dart';
import 'widget/add_item.dart';
import 'widget/todo_list.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final store = initStore();
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        title: 'To-Do List',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: StoreBuilder<AppState>(
            onInit: (store) => store.dispatch(GetItemsAction()),
            builder: (context, store) {
              return MyHomePage(title: AppLocalizations.of(context)!.todoList);
            }),
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

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(Assets.images.target.path, color: Colors.white),
        ),
        title: Text(widget.title),
      ),
      body: StoreConnector<AppState, ToDoViewModel>(
          distinct: true,
          converter: (Store<AppState> store) =>
              ToDoViewModel((builder) => builder
                ..items = store.state.items?.toBuilder()
                ..status = store.state.status?.toBuilder()),
          onWillChange: (vm, model) {
            // print("MODEL ${model.status} ${model.items}");

            if (model.status ==
                Status.success(message: model.status?.message)) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(model.status?.message ?? ""),
                  backgroundColor: Colors.green));
            } else if (model.status ==
                Status.error(message: model.status?.message)) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(model.status?.message ?? ""),
                  backgroundColor: Colors.red));
            }
          },
          builder: (BuildContext context, ToDoViewModel viewModel) {
            // print("VM ${viewModel.items}");
            return Stack(
              children: [
                Positioned(
                    bottom: -100.0,
                    child: Opacity(
                        opacity: 0.1,
                        child: Image.asset(Assets.images.list.path))),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      AddItemWidget(model: viewModel),
                      TodoListWidget(model: viewModel),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
