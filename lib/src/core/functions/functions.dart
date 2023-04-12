import 'dart:math';

import 'package:intl/intl.dart';

class Functions {
  static final Functions _singleton = Functions._internal();

  factory Functions() {
    return _singleton;
  }

  Functions._internal();
  
  double roundDouble(double val, int places) {
    num mod = pow(10.0, places);
    return ((val * mod).round().toDouble() / mod);
  }

  String roundDoubleToString(double value, int places) {
    final mod = pow(10.0, places);
    return NumberFormat("0.##")
        .format(((value * mod).round().toDouble() / mod));
  }
}
