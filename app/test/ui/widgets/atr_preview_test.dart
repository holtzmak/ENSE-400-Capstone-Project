import 'package:app/ui/widgets/atr_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

import '../../test_animal_transport_record.dart';

void main() {
  group('Animal Transport Record Preview', () {
    testWidgets('Previews right information', (WidgetTester tester) async {
      final testDate = DateTime.now();
      final testCompany = "Test Company";
      final testSpecies = "Cows";

      // Must wrap widget in MaterialApp if not "home" widget under test
      await tester.pumpWidget(new MaterialApp(
          home: AnimalTransportRecordPreview(
        atr: testAnimalTransportRecord(
            deliveryInfo: testDeliveryInfo(
                recInfo: testReceiverInfo(receiverCompanyName: testCompany)),
            vehicleInfo: testVehicleInfo(
                dateAndTimeLoaded: testDate,
                animalsLoaded: [testAnimalGroup(species: testSpecies)])),
      )));

      expect(find.text("Delivery for $testCompany"), findsOneWidget);
      expect(
          find.text(
              "${DateFormat("yyyy-MM-dd hh:mm").format(testDate)} $testSpecies"),
          findsOneWidget);
    });
  });
}
