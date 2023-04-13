import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shift_check/src/features/shifts/domain/usecases/shift_use_case.dart';

import '../../../../shared/models/shift.dart';

final shiftsProvider =
    StateNotifierProvider.autoDispose<ShiftsProvider, List<Shift>>((ref) {
  return ShiftsProvider();
});

final fetchShifts = FutureProvider.autoDispose<List<Shift>>(
  (ref) {
    ref.listen(shiftsProvider, (previous, next) {});
    return ref.read(shiftUseCase).getShifts();
  },
);

class ShiftsProvider extends StateNotifier<List<Shift>> {
  ShiftsProvider() : super([]);
  

  Future<void> addShift(Shift shift) async {
    state = [...state, shift]
      ..sort(((a, b) => b.startTime.compareTo(a.startTime)));
  }

  void undoShiftDelete(int index, Shift shift) {
    state = [...state]..insert(index, shift);
  }

  void editShift(Shift shift) {
    var index = state.indexWhere((element) => element.id == shift.id);
    state[index] = shift;
    state = List.from(state)
      ..sort(((a, b) => b.startTime.compareTo(a.startTime)));
  }

  void setShifts(List<Shift> shifts) async {
    state = shifts..sort(((a, b) => b.startTime.compareTo(a.startTime)));
  }

  void removeShift(Shift shift) {
    state = state.where((element) => element.id != shift.id).toList();
  }
}
