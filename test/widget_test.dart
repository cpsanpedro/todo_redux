// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_redux/model/model.dart';
import 'package:todo_redux/shared/store.dart';
import 'package:todo_redux/view_model/view_model.dart';
import 'package:todo_redux/widget/todo_list.dart';

import 'mock_data.dart';

void main() {
  testWidgets('Todo list', (tester) async {
    final store = initStore();
    final ToDoViewModel viewModel = ToDoViewModel(
        (builder) => builder..items = ListBuilder(store.state.items!));
    await tester.pumpWidget(StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              TodoListWidget(model: viewModel),
            ],
          ),
        ),
      ),
    ));

    await tester.pumpAndSettle();

    mockList.forEach((element) {
      expect(find.text(element.title!), findsOneWidget);
    });
  });
}
