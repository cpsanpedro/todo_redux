import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:todo_redux/constants/consts.dart';
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
  TextEditingController _controller = TextEditingController();

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
                        child: ListTile(
                          title: Text(item.title ?? "",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          onTap: () async {
                            await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    key: Key(TDKey.dialog),
                                    actions: [
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text("Cancel")),
                                      StoreConnector<AppState, ToDoViewModel>(
                                        converter: (store) => ToDoViewModel(
                                            (b) => b
                                              ..items = ListBuilder(
                                                  store.state.items!)
                                              ..isLoading =
                                                  store.state.isLoading),
                                        distinct: true,
                                        builder: (context, viewModel) {
                                          print(
                                              "IS LOOADING ${viewModel.isLoading}");
                                          final isLoading =
                                              viewModel.isLoading ?? false;
                                          if (isLoading) {
                                            return const CircularProgressIndicator();
                                          } else {
                                            return TextButton(
                                                key: Key(TDKey.editTextButton),
                                                onPressed: () async {
                                                  _store?.dispatch(
                                                      UpdateItemAction(
                                                          (b) => b.item
                                                            ..title =
                                                                _controller.text
                                                            ..id = item.id));
                                                  await Future.delayed(
                                                      const Duration(
                                                          seconds: 1));
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Edit"));
                                          }
                                          // return ToDoViewModel(
                                          //   child: TextButton(
                                          //       onPressed: () {
                                          //         _store?.dispatch(
                                          //             UpdateItemAction((b) => b.item
                                          //               ..title = _controller.text
                                          //               ..id = item.id));
                                          //         Navigator.pop(context);
                                          //       },
                                          //       child: Text("Edit")),
                                          // );
                                        },
                                      )
                                    ],
                                    content: TextField(
                                        key: Key(TDKey.editTextfield),
                                        controller: _controller
                                          ..text = item.title.toString()),
                                  );
                                });
                          },
                        )))
                    .toList()),
          )
        : Container();
  }
}
