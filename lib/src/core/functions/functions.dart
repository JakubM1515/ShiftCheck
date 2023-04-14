import 'dart:math';

import 'package:intl/intl.dart';

import '../../features/shifts/domain/models/shift.dart';

class Functions {
  static final Functions _singleton = Functions._internal();

  factory Functions() {
    return _singleton;
  }

  Functions._internal();

  static double roundDouble(double val, int places) {
    num mod = pow(10.0, places);
    return ((val * mod).round().toDouble() / mod);
  }

  static String roundDoubleToString(double value, int places) {
    final mod = pow(10.0, places);
    return NumberFormat("0.##")
        .format(((value * mod).round().toDouble() / mod));
  }

  static double calcTotalHours(List<Shift> shifts) {
    if (shifts.isNotEmpty) {
      double sum = 0;
      for (var shift in shifts) {
        sum += (shift.endTime.difference(shift.startTime).inMinutes) / 60;
      }

      return roundDouble(sum, 2);
    } else {
      return 0;
    }
  }

  static double calcMeanShifTime(List<Shift> shifts) {
    if (shifts.isNotEmpty) {
      double sum = 0;
      for (var shift in shifts) {
        sum += (shift.endTime.difference(shift.startTime).inMinutes) / 60;
      }

      return roundDouble(sum / shifts.length, 2);
    } else {
      return 0;
    }
  }

  static double calcTotalMoney(List<Shift> shifts) {
    if (shifts.isNotEmpty) {
      double sum = 0;
      for (var shift in shifts) {
        sum += shift.moneyEarned;
      }

      return roundDouble(sum, 2);
    } else {
      return 0;
    }
  }
}
