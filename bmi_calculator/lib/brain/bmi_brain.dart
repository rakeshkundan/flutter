import 'dart:math';

class CalculatorBrain {
  final int height;
  final int weight;
  double _bmi = 20.0;
  CalculatorBrain({required this.height, required this.weight});

  String calculateBmi() {
    _bmi = weight / pow(height, 2);
    _bmi *= 10000;
    return _bmi.toStringAsFixed(1);
  }

  String getResult() {
    if (_bmi < 18.4) {
      return 'UNDERWEIGHT';
    } else if (_bmi >= 18.5 && _bmi <= 24.9) {
      return 'NORMAL';
    } else {
      return 'OVERWEIGHT';
    }
  }

  String getInterpretation() {
    if (_bmi < 18.4) {
      return 'You have a lower than body weight. You can eat more.';
    } else if (_bmi >= 18.5 && _bmi <= 24.9) {
      return 'You have a normal body weight. Good job!';
    } else {
      return 'You have a higher than body weight. Try to exercise more.';
    }
  }
}
