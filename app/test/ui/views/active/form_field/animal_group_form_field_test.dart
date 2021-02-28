import 'package:app/core/models/loading_vehicle_info.dart';
import 'package:app/test/helper/test_compromised_animal_expectations.dart';
import 'package:app/test/test_animal_transport_record.dart';
import 'package:app/ui/views/active/form_field/animal_group_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  void verifyInformationIsShown(AnimalGroup infoExpected) {
    expect(find.text(infoExpected.species), findsOneWidget);
    expect(find.text(infoExpected.groupAge.toString()), findsOneWidget);
    expect(
        find.text(infoExpected.approximateWeight.toString()), findsOneWidget);
    expect(find.text(infoExpected.animalPurpose), findsOneWidget);
    expect(find.text(infoExpected.numberAnimals.toString()), findsOneWidget);
    // DropDownButtonFormFields have the values offscreen, so both are present
    expect(find.text(infoExpected.animalsFitForTransport ? "Yes" : "No"),
        findsOneWidget);

    infoExpected.compromisedAnimals.forEach((animal) {
      verifyCompromisedAnimalInfoIsShown(animal);
    });
    infoExpected.specialNeedsAnimals.forEach((animal) {
      verifyCompromisedAnimalInfoIsShown(animal);
    });
  }

  Future<void> pumpAnimalGroupFormField(
          WidgetTester tester,
          AnimalGroup testInfo,
          Function(AnimalGroup) onSaved,
          Function() onDelete) async =>
      tester.pumpWidget(MaterialApp(
          home: Scaffold(
              body: SingleChildScrollView(
                  child: Container(
        child: AnimalGroupFormField(
          initialInfo: testInfo,
          onSaved: onSaved,
          onDelete: onDelete,
        ),
      )))));

  group('Animal Group Form Field', () {
    testWidgets('shows right information', (WidgetTester tester) async {
      final testAnimalGroup = AnimalGroup(
          species: "Cattle",
          groupAge: 5,
          approximateWeight: 1800,
          animalPurpose: "Going to vet for checkup",
          numberAnimals: 8,
          animalsFitForTransport: true,
          compromisedAnimals: [],
          specialNeedsAnimals: [
            CompromisedAnimal(
                animalDescription: "Black, small cow has neurological problems",
                measuresTakenToCareForAnimal:
                    "Rendered cow unconscious for travel")
          ]);
      await pumpAnimalGroupFormField(tester, testAnimalGroup, (_) {
        // Do nothing for test
      }, () {
        // Do nothing for test
      });
      verifyInformationIsShown(testAnimalGroup);
    });

    testWidgets('calls onDelete when delete button pressed',
        (WidgetTester tester) async {
      bool callback;
      final onDeleteCallback = () => callback = true;
      final deleteButtonFinder = find.byIcon(Icons.delete);
      await pumpAnimalGroupFormField(tester, testAnimalGroup(), (_) {
        // do nothing for test
      }, onDeleteCallback);
      await tester.ensureVisible(deleteButtonFinder);
      await tester.tap(deleteButtonFinder);
      await tester.pumpAndSettle();
      expect(callback, isTrue);
    });

    testWidgets(
        'onSaved called with edited special needs animal info when changed',
        (WidgetTester tester) async {
      final testDescription = "Small black horse";
      final editedDescription = "Piebald horse";
      final testInfo = testAnimalGroup(specialNeedsAnimals: [
        testCompromisedAnimal(animalDescription: testDescription)
      ]);
      final editedInfo = testAnimalGroup(specialNeedsAnimals: [
        testCompromisedAnimal(animalDescription: editedDescription)
      ]);
      AnimalGroup callback;
      final onSaved = (AnimalGroup changed) => callback = changed;
      final fieldFinder = find.text(testDescription);

      await pumpAnimalGroupFormField(tester, testInfo, onSaved, () {
        // Do nothing for test
      });
      await tester.ensureVisible(fieldFinder);
      await tester.enterText(fieldFinder, editedDescription);
      await tester.pumpAndSettle();
      expect(callback, editedInfo);
    });
  });
}
