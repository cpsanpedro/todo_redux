import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:todo_redux/model/model.dart';
import 'package:todo_redux/redux/actions.dart';

import '../view_model/view_model.dart';

class AddItemWidget extends StatefulWidget {
  const AddItemWidget({required this.model, Key? key}) : super(key: key);
  final ToDoViewModel model;

  @override
  State<AddItemWidget> createState() => _AddItemWidgetState();
}

class _AddItemWidgetState extends State<AddItemWidget> {
  final TextEditingController controller = TextEditingController();
  Store? _store;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = StoreProvider.of<AppState>(context);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(hintText: "What are your goals?"),
      onSubmitted: (val) {
        _store?.dispatch(AddItemAction((b) => b
          ..title = controller.text
          ..id = DateTime.now().toString().substring(0, 19)));
        controller.clear();
      },
    );
  }
}
