import 'package:app/core/services/validation_service.dart';
import 'package:app/test/mock/test_service_locator.dart';
import 'package:app/ui/views/active/form_field/int_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

final testLocator = GetIt.instance;

void main() {
  void verifyInformationIsShown(int infoExpected, String titleExpected) {
    expect(
        find.widgetWithText(ListTile, infoExpected.toString()), findsOneWidget);
    expect(find.widgetWithText(ListTile, titleExpected), findsOneWidget);
  }

  Future<void> pumpIntFormField(WidgetTester tester, Widget widget) async =>
      tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));

  group('Integer Form Field', () {
    setUpAll(() async {
      addLazySingletonForTest(testLocator, () => ValidationService());
    });

    testWidgets('shows right information', (WidgetTester tester) async {
      final testItem = 123;
      final testTitle = "Test Title";
      final widget = IntFormField(
        initial: testItem,
        title: testTitle,
        onSaved: (_) {
          // do nothing for test
        },
      );
      await pumpIntFormField(tester, widget);
      verifyInformationIsShown(testItem, testTitle);
    });

    testWidgets('onSaved called when edited', (WidgetTester tester) async {
      final testInfo = 123;
      final editedInfo = 4;
      int callback;
      final onSavedCallback = (int changed) => callback = changed;
      final fieldFinder =
          find.widgetWithText(TextFormField, testInfo.toString());
      final editedFieldFinder =
          find.widgetWithText(TextFormField, editedInfo.toString());
      final formKey = GlobalKey<FormState>();
      final widget = Form(
          key: formKey,
          child: IntFormField(
            initial: testInfo,
            title: "Test Title",
            onSaved: onSavedCallback,
          ));

      await pumpIntFormField(tester, widget);
      await tester.enterText(fieldFinder, editedInfo.toString());
      await tester.pumpAndSettle();
      formKey.currentState.save();
      // expect was saved
      expect(callback, editedInfo);
      // expect edited text visible
      expect(editedFieldFinder, findsOneWidget);
    });
  });
}
