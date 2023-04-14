import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shift_check/src/features/history/domain/module/month_summary_provider.dart';

import '../../domain/models/shift.dart';
import '../../domain/module/shift_provider.dart';

final shiftsProvider =
    StateNotifierProvider.autoDispose<ShiftsProvider, List<Shift>>((ref) {
  return ShiftsProvider();
});

final shouldEndMotnh = StateProvider(
  (ref) => false,
);

final fetchShifts = FutureProvider.autoDispose<List<Shift>>(
  (ref) async {
    ref.listen(shiftsProvider, (previous, next) {});
    var endMonth =
        await ref.read(monthSummaryUseCase).checkAndMaybeCreateSummary();
    endMonth ? ref.read(shouldEndMotnh.notifier).update((state) => true) : null;
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
