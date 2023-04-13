import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:shift_check/src/core/constants/constants.dart';
import 'package:shift_check/src/shared/data/datasources/local/shifts_local_data_source.dart';

class SettingsLocalDataSourceImpl extends SettingsLocalDataSource {
  @override
  String getSalary() {
    String value =
        Settings.getValue(Constants.salaryKey, defaultValue: "0") ?? "0";
    return value;
  }

  @override
  void saveSalary(String salary) {
    Settings.setValue(Constants.salaryKey, salary);
  }

  @override
  String getCurrency() {
    return Settings.getValue(Constants.currencyKey, defaultValue: 'PLN') ??
        'PLN';
  }
}
