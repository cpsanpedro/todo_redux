import 'package:todo_redux/model/model.dart';

class AddItemAction {
  static int _id = 0;
  final String item;

  AddItemAction(this.item) {
    _id++;
  }

  int get id => _id;
}

class DeleteItemAction {
  DeleteItemAction(this.item);
  final ToDoItem item;
}