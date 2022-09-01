import 'package:flutter/material.dart';

import '../view_model/view_model.dart';

class AddItemWidget extends StatefulWidget {
  const AddItemWidget({required this.model, Key? key}) : super(key: key);
  final ToDoViewModel model;

  @override
  State<AddItemWidget> createState() => _AddItemWidgetState();
}

class _AddItemWidgetState extends State<AddItemWidget> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(hintText: "What are your goals?"),
      onSubmitted: (val) {
        widget.model.onAddItem(val);
        controller.clear();
      },
    );
  }
}
