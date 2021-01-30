import 'package:app/core/services/service_locator.dart';
import 'package:app/humane_transport_app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Group test', () {
    // Needed to show where the implementations are located
    setUpAll(() {
      setUpLocator();
    });

    testWidgets('HumaneTransportApp says Welcome', (WidgetTester tester) async {
      await tester.pumpWidget(HumaneTransportApp());
      final textFinder = find.text('Welcome');
      expect(textFinder, findsOneWidget);
    });
  });
}
