import 'package:app/core/services/validation_service.dart';
import 'package:app/test/mock/test_service_locator.dart';
import 'package:app/ui/views/active/dynamic_form_field/dynamic_form_field.dart';
import 'package:app/ui/views/active/dynamic_form_field/dynamic_string_form_field.dart';
import 'package:app/ui/views/active/form_field/string_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

final testLocator = GetIt.instance;

void main() {
  void verifyNoDuplicateInfoShown(String title, List<String> information) {
    expect(find.widgetWithText(ListTile, title),
        findsNWidgets(information.length));
    information.forEach((info) {
      expect(find.widgetWithText(ListTile, info), findsOneWidget);
    });
  }

  Future<void> pumpDynamicStringFormField(
          WidgetTester tester, DynamicFormField<String> widget) async =>
      tester.pumpWidget(MaterialApp(
          home: Scaffold(
        body: widget,
      )));

  group('Dynamic String Form Field', () {
    setUpAll(() async {
      addLazySingletonForTest(testLocator, () => ValidationService());
    });

    testWidgets('shows right information for multiple fields',
        (WidgetTester tester) async {
      final testItems = ["Test0", "Test1", "Test2"];
      final testTitle = "Test Title";
      final widget = dynamicStringFormField(
        initialList: testItems,
        titles: testTitle,
        onSaved: (List<String> _) {
          // do nothing for test
        },
      );
      await pumpDynamicStringFormField(tester, widget);
      await tester.pumpAndSettle();
      verifyNoDuplicateInfoShown(testTitle, testItems);
    });

    testWidgets('shows no information when no fields',
        (WidgetTester tester) async {
      final widget = dynamicStringFormField(
        initialList: <String>[],
        titles: "Test Title",
        onSaved: (List<String> _) {
          // do nothing for test
        },
      );
      await pumpDynamicStringFormField(tester, widget);
      expect(find.text("No Test Title"), findsOneWidget);
    });

    testWidgets('delete button pressed removes field',
        (WidgetTester tester) async {
      final testItems = ["Test0", "Test1", "Test2"];
      final testTitle = "Test Title";
      final firstItemDeleteButtonFinder = find.byIcon(Icons.delete).first;
      final widget = dynamicStringFormField(
        initialList: testItems,
        titles: testTitle,
        onSaved: (List<String> _) {
          // do nothing for test
        },
      );

      await pumpDynamicStringFormField(tester, widget);
      await tester.tap(firstItemDeleteButtonFinder);
      await tester.pumpAndSettle();
      expect(find.text("Test0"), findsNothing);
      verifyNoDuplicateInfoShown(testTitle, ["Test1", "Test2"]);
    });

    testWidgets('delete button pressed removes field, leaves empty list',
        (WidgetTester tester) async {
      final testItems = ["Test0"];
      final testTitle = "Test Title";
      final deleteButtonFinder = find.byIcon(Icons.delete);
      final widget = dynamicStringFormField(
        initialList: testItems,
        titles: testTitle,
        onSaved: (List<String> _) {
          // do nothing for test
        },
      );
      await pumpDynamicStringFormField(tester, widget);
      await tester.tap(deleteButtonFinder);
      await tester.pumpAndSettle();
      expect(find.text("No $testTitle"), findsOneWidget);
    });

    testWidgets('add button pressed adds empty field',
        (WidgetTester tester) async {
      final testTitle = "Test Title";
      final widget = dynamicStringFormField(
        initialList: [],
        titles: testTitle,
        onSaved: (List<String> _) {
          // do nothing for test
        },
      );
      await pumpDynamicStringFormField(tester, widget);
      final addButtonFinder = find.byIcon(Icons.add_circle);
      await tester.tap(addButtonFinder);
      await tester.pumpAndSettle();
      verifyNoDuplicateInfoShown(testTitle, [""]);
      expect(find.text("No $testTitle"), findsNothing);
    });

    testWidgets('onSaved called when info is edited then saved',
        (WidgetTester tester) async {
      final testTitle = "Test Title";
      final testItems = ["Test0", "Test1", "Test2"];
      final editedItems = ["Test3", "Test1", "Test2"];
      List<String> callback;
      final onSaved = (List<String> changed) => callback = changed;
      final fieldFinder = find.text("Test0");
      final DynamicFormField<String> widget = dynamicStringFormField(
        initialList: testItems,
        titles: testTitle,
        onSaved: onSaved,
      );
      await pumpDynamicStringFormField(tester, widget);
      await tester.enterText(fieldFinder, "Test3");
      await tester.pumpAndSettle();
      widget.save();
      expect(callback, editedItems);
    });

    testWidgets(
        'when list cannot be empty, the first item cannot be deleted but the next can be',
        (WidgetTester tester) async {
      final testTitle = "Test Title";
      final testItems = ["Test0", "Test1", "Test2"];
      final deleteButtonFinder = find.byIcon(Icons.delete);
      final DynamicFormField<String> widget = dynamicStringFormField(
        canBeEmpty: false,
        initialList: testItems,
        titles: testTitle,
        onSaved: (List<String> _) {
          // do nothing for test
        },
      );
      await pumpDynamicStringFormField(tester, widget);
      // When the list can't be empty, only n - 1 widgets have delete button
      expect(deleteButtonFinder, findsNWidgets(2));
    });

    testWidgets(
        'when list cannot be empty, the first item is provided without a delete button',
        (WidgetTester tester) async {
      final testTitle = "Test Title";
      final deleteButtonFinder = find.byIcon(Icons.delete);
      final DynamicFormField<String> widget = dynamicStringFormField(
        canBeEmpty: false,
        initialList: [],
        titles: testTitle,
        onSaved: (List<String> _) {
          // do nothing for test
        },
      );
      await pumpDynamicStringFormField(tester, widget);
      expect(deleteButtonFinder, findsNothing);
      expect(find.widgetWithText(StringFormField, ""), findsOneWidget);
    });

    testWidgets(
        'when list cannot be empty, the only item does not have a delete button',
        (WidgetTester tester) async {
      final testItems = ["Test0"];
      final testTitle = "Test Title";
      final deleteButtonFinder = find.byIcon(Icons.delete);
      final widget = dynamicStringFormField(
        canBeEmpty: false,
        initialList: testItems,
        titles: testTitle,
        onSaved: (List<String> _) {
          // do nothing for test
        },
      );
      await pumpDynamicStringFormField(tester, widget);
      expect(deleteButtonFinder, findsNothing);
      expect(find.text("Test0"), findsOneWidget);
    });
  });
}
