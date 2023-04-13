import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shift_check/src/core/providers/app_theme_provider.dart';

import '../repositories/settings_repository.dart';

class SettingsUseCase {
  SettingsUseCase(this._ref, this._repo);
  final Ref _ref;
  final SettingsRepository _repo;

  void setSalary(double salary) {
    _repo.setSalary(salary);
  }

  double getSalary() {
    return _repo.getSalary();
  }

  String getCurrency() {
    return _repo.getCurrency();
  }

  void changeTheme(bool value) {
    _ref.read(darkModeProvider.notifier).update((state) => value);
  }
}
