import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:todo_redux/redux/actions.dart';
import 'package:todo_redux/view_model/view_model.dart';

import '../model/model.dart';

class TodoListWidget extends StatefulWidget {
  const TodoListWidget({required this.model, Key? key}) : super(key: key);
  final ToDoViewModel model;

  @override
  State<TodoListWidget> createState() => _TodoListWidgetState();
}

class _TodoListWidgetState extends State<TodoListWidget> {
  Store? _store;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = StoreProvider.of<AppState>(context);
  }

  @override
  Widget build(BuildContext context) {
    return widget.model.items != null
        ? Expanded(
            child: ListView(
                children: widget.model.items!
                    .map((item) => Dismissible(
                        background: Container(
                            alignment: Alignment.centerRight,
                            color: Colors.red,
                            child: const Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Icon(Icons.delete, color: Colors.white),
                            )),
                        key: Key(item.id.toString()),
                        onDismissed: (direction) {
                          _store?.dispatch(DeleteItemAction(
                              (b) => b.item = item.toBuilder()));
                        },
                        child: ListTile(title: Text(item.title ?? ""))))
                    .toList()),
          )
        : Container(
            color: Colors.red,
            child: Text("CONNN"),
          );
  }
}
