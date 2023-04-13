import 'package:shift_check/src/shared/data/datasources/local/shifts_local_data_source.dart';

import '../../domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl extends SettingsRepository {
  SettingsRepositoryImpl(this._localDataSource);
  final SettingsLocalDataSource _localDataSource;
  @override
  String getCurrency() {
    return _localDataSource.getCurrency();
  }

  @override
  String getSalary() {
    return _localDataSource.getSalary();
  }

  @override
  void setSalary(String salary) {
    _localDataSource.saveSalary(salary);
  }
}
