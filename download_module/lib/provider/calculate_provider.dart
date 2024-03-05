import 'dart:isolate';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';


int _calculate(int number) {
  return number * number;
}

class Calculate extends ChangeNotifier {
  int _value = 0;

  int get value => _value;

  set click(int clicks) {
    _value = clicks;

  }

  Future<void> calculate() async {
    _value = await compute<int, int>(_calculate, _value);
    notifyListeners();
  }


}
