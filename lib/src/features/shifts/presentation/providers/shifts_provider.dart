import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shift_check/src/features/shifts/data/datasources/firebase_shifts_datasource.dart';
import 'package:shift_check/src/features/shifts/data/repositories/shifts_repository_impl.dart';
import 'package:shift_check/src/features/shifts/domain/repositories/shifts_repository.dart';
import 'package:shift_check/src/features/shifts/domain/usecases/add_shift_usecase.dart';
import 'package:shift_check/src/features/shifts/domain/usecases/edit_shift_usecase.dart';
import 'package:shift_check/src/features/shifts/domain/usecases/get_shifts_usecase.dart';
import 'package:shift_check/src/features/shifts/domain/usecases/remove_shift_usecase.dart';

import '../../../../shared/models/shift.dart';

final shiftsProvider =
    StateNotifierProvider.autoDispose<ShiftsProvider, List<Shift>>((ref) {
  var dataSource = FirebaseShiftsDatasource();
  var repo = ShiftsRepositoryImpl(dataSource);
  return ShiftsProvider(repo);
});

final fetchShifts = FutureProvider.autoDispose<List<Shift>>(
  (ref) {
    ref.listen(shiftsProvider, (previous, next) {});
    return ref.read(shiftsProvider.notifier).getShifts();
  },
);

class ShiftsProvider extends StateNotifier<List<Shift>> {
  final ShiftsRepository shiftsRepository;
  ShiftsProvider(this.shiftsRepository) : super([]);

  Future<void> addShift(Shift shift) async {
    try {
      shift = await AddShiftUseCase(shiftsRepository).addShift(shift);
      state = [...state, shift]
        ..sort(((a, b) => b.startTime.compareTo(a.startTime)));
    } catch (e) {
      rethrow;
    }
  }

  void undoShiftDelete(int index, Shift shift) {
    try {
      AddShiftUseCase(shiftsRepository).addShift(shift);
      state = [...state]..insert(index, shift);
    } catch (e) {
      rethrow;
    }
  }

  void editShift(Shift shift) {
    try {
      EditShiftUseCase(shiftsRepository).editShift(shift);
      var index = state.indexWhere((element) => element.id == shift.id);
      state[index] = shift;
      state = List.from(state)
        ..sort(((a, b) => b.startTime.compareTo(a.startTime)));
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Shift>> getShifts() async {
    try {
      state = await GetShiftsUseCase(shiftsRepository).getShifts();
      return state..sort(((a, b) => b.startTime.compareTo(a.startTime)));
    } catch (e) {
      rethrow;
    }
  }

  void removeShift(Shift shift) {
    try {
      RemoveShiftUseCase(shiftsRepository).deleteShift(shift);
      state = state.where((element) => element.id != shift.id).toList();
    } catch (e) {
      rethrow;
    }
  }
}
