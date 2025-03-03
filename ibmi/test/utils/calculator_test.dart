import 'package:flutter_test/flutter_test.dart';
import 'package:ibmi/utils/calculator.dart';

void main() {
  test(
      'Give height and weight When calculateBMI function invoked Then correct BMI returned',
      () {
        //Arrange
        const int height = 70, weight = 160;
        //Act
        double bmi = calculatorBMI(height, weight);
        //Assert
        expect(bmi, 22.955102040816328);
      });
}
