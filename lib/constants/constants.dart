import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:intl/intl.dart';

var timeFormat = DateFormat('H:mm');
var dateFormat = DateFormat('yyyy-MM-dd');
var currencyKey = '_kCurrency';
var salaryKey = '_kSalary';
var darkModeKey = '_kDarkMode';

double roundDouble(double val, int places) {
  num mod = pow(10.0, places);
  return ((val * mod).round().toDouble() / mod);
}

String roundDoubleToString(double value, int places) {
  final mod = pow(10.0, places);
  return NumberFormat("0.##").format(((value * mod).round().toDouble() / mod));
}


late final StateProvider<bool> darkModeProvider;
void initAppTheme() {
  final darkMode = Settings.getValue(darkModeKey,defaultValue: true);
  darkModeProvider = StateProvider(
    (ref) => darkMode!,
  );
}
