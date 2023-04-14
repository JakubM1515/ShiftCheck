import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shift_check/src/features/menu/data/datasources/local/shifts_local_data_source_impl.dart';

import '../../data/datasources/remote/firebase_shifts_datasource.dart';
import '../../data/repositories/shifts_repository_impl.dart';
import '../usecases/shift_use_case.dart';

final shiftDatasourceProvider = Provider.autoDispose(
  (ref) => FirebaseShiftsDatasource(),
);
final shiftLocalDatasourceProvider =
    Provider.autoDispose((ref) => SettingsLocalDataSourceImpl());

final shiftRepositoryProvider = Provider.autoDispose((ref) {
  final remoteDataSource = ref.watch(shiftDatasourceProvider);
  final localDataSource = ref.watch(shiftLocalDatasourceProvider);
  final repository = ShiftsRepositoryImpl(remoteDataSource, localDataSource);
  return repository;
});

final shiftUseCase = Provider.autoDispose((ref) {
  var repo = ref.watch(shiftRepositoryProvider);
  return ShiftUseCase(repo, ref);
});
