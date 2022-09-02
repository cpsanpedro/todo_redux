import 'package:flutter/material.dart';
import 'package:todo_redux/view_model/view_model.dart';

class TodoListWidget extends StatefulWidget {
  const TodoListWidget({required this.model, Key? key}) : super(key: key);
  final ToDoViewModel model;

  @override
  State<TodoListWidget> createState() => _TodoListWidgetState();
}

class _TodoListWidgetState extends State<TodoListWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: widget.model.items
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
                  widget.model.onDeleteItem(item);
                },
                child: ListTile(title: Text(item.title))))
            .toList());
  }
}
