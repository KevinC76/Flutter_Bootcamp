import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:ibmi/main.dart' as app;

void main() {
  // Changed from Main() to main()
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end app test', () {
    // Arrange
    final weightIncrementButton = find.byKey(const Key('weight_plus'));
    final ageIncrementButton = find.byKey(const Key('age_plus'));
    final calculateBMIButton = find.byKey(const Key('calculate_button'));

    testWidgets(
        'Given app is ran When height, age data input and calculate BMI button press Then correct BMI return',
        (WidgetTester tester) async {
      // Act
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Make sure the buttons are visible before tapping
      expect(weightIncrementButton, findsOneWidget);
      expect(ageIncrementButton, findsOneWidget);
      expect(calculateBMIButton, findsOneWidget);

      await tester.tap(weightIncrementButton);
      await tester.pumpAndSettle();
      await tester.tap(ageIncrementButton);
      await tester.pumpAndSettle();
      await tester.tap(calculateBMIButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      // Assert
      final resultText = find.text('Ok');
      expect(resultText, findsOneWidget);
    });
  });
}
