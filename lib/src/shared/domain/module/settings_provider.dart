import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shift_check/src/shared/domain/usecases/settings_usecase.dart';

import '../../data/datasources/local/shifts_local_data_source_impl.dart';
import '../../data/repositories/settings_repository_impl.dart';

final settingsLocalDataSourceProvider = Provider.autoDispose(
  (ref) => SettingsLocalDataSourceImpl(),
);

final settingsRepositoryProvider = Provider.autoDispose((ref) {
  final settingsLocalDataSource = ref.watch(settingsLocalDataSourceProvider);
  final repository = SettingsRepositoryImpl(settingsLocalDataSource);
  return repository;
});

final settingsUseCase = Provider.autoDispose(
  (ref) {
    var repo = ref.watch(settingsRepositoryProvider);
    return SettingsUseCase(ref, repo);
  },
);
