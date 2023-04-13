import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:shift_check/src/core/constants/constants.dart';
import 'package:shift_check/src/shared/data/datasources/local/shifts_local_data_source.dart';

class SettingsLocalDataSourceImpl extends SettingsLocalDataSource {
  @override
  double getSalary() {
    var value = Settings.getValue(Constants.salaryKey, defaultValue: 0) ?? 0;
    return value.toDouble();
  }

  @override
  void saveSalary(double salary) {
    Settings.setValue(Constants.salaryKey, salary);
  }

  @override
  String getCurrency() {
    return Settings.getValue(Constants.currencyKey, defaultValue: 'PLN') ??
        'PLN';
  }
}
