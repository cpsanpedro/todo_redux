import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:todo_redux/constants/consts.dart';
import 'package:todo_redux/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("create item test", (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final textFieldFinder = find.byKey(Key(TDKey.addTextfield));
    final dialogFinder = find.byKey(Key(TDKey.editTextfield));
    final editButtonFinder = find.byKey(Key(TDKey.editTextButton));

    expect(textFieldFinder, findsOneWidget);

    await tester.enterText(textFieldFinder, "Item 1");
    await tester.pumpAndSettle();

    await tester.testTextInput.receiveAction(TextInputAction.done);
    String idDateItemOne = DateTime.now().toString().substring(0, 19);
    await tester.pumpAndSettle();

    expect(find.text("Item 1"), findsOneWidget);
    await tester.pumpAndSettle();

    //Add another item
    await tester.tap(textFieldFinder);
    await tester.enterText(textFieldFinder, "Item 2");
    await tester.pumpAndSettle();

    await tester.testTextInput.receiveAction(TextInputAction.done);
    String idDateItemTwo = DateTime.now().toString().substring(0, 19);
    await tester.pumpAndSettle();

    expect(find.text("Item 2"), findsOneWidget);

    //tap item 1
    await tester.tap(find.byKey(Key(idDateItemOne)));
    await tester.pumpAndSettle();
    expect(find.byKey(Key(TDKey.dialog)), findsOneWidget);

    await tester.tap(dialogFinder);
    await tester.pumpAndSettle();

    //edit item
    await tester.enterText(dialogFinder, "Updated Item 1");
    await tester.pumpAndSettle();

    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    await tester.tap(editButtonFinder);
    await tester.pumpAndSettle();
    expect(find.text("Updated Item 1"), findsOneWidget);

    //delete item
    await tester.drag(find.byKey(Key(idDateItemTwo)), Offset(-500.0, 0));
    await tester.pumpAndSettle();
    expect(find.text("Updated Item 1"), findsOneWidget);
    expect(find.text("Item 2"), findsNothing);
  });
}
