import 'package:intl/intl.dart';

class Constants {
  // Date Formats
  static DateFormat timeFormat = DateFormat('H:mm');
  static DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  // SharedPreferences keys
  static const String currencyKey = '_kCurrency';
  static const String salaryKey = '_kSalary';
  static const String darkModeKey = '_kDarkMode';
  // Firebase collections
  static const String shiftsCollection = 'shifts';
  static const String monthSummariesCollection = 'summaries';
}
