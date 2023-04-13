import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/firebase_shifts_datasource.dart';
import '../../data/repositories/shifts_repository_impl.dart';
import '../usecases/shift_use_case.dart';

final shiftDatasourceProvider = Provider.autoDispose(
  (ref) => FirebaseShiftsDatasource(),
);

final shiftRepositoryProvider = Provider.autoDispose((ref) {
  final dataSource = ref.watch(shiftDatasourceProvider);
  final repository = ShiftsRepositoryImpl(dataSource);
  return repository;
});

final shiftUseCase = Provider.autoDispose((ref) {
  var repo = ref.watch(shiftRepositoryProvider);
  return ShiftUseCase(repo, ref);
});
