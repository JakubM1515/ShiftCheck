import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart' as sttg;
import 'package:shift_check/repositories/shifts_repository.dart';

import '../constants/constants.dart';
import '../models/shift.dart';

final shiftsProvider =
    StateNotifierProvider.autoDispose<ShiftsProvider, List<Shift>>(
        (ref) => ShiftsProvider());

final fetchShifts = FutureProvider.autoDispose<List<Shift>>(
  (ref) {
    ref.listen(shiftsProvider, (previous, next) {});
    return ref.read(shiftsProvider.notifier).getShifts();
  },
);

class ShiftsProvider extends StateNotifier<List<Shift>> {
  ShiftsProvider() : super([]);

  void addShift(Shift shift) async {
    try {
      await ShiftsRepository.addShift(shift);
      await sttg.Settings.setValue(salaryKey, shift.salary.toString());
      state = [...state, shift]
        ..sort(((a, b) => b.startTime.compareTo(a.startTime)));
    } catch (e) {
      rethrow;
    }
  }

  void undoShiftDelete(int index, Shift shift) async {
    try {
      await ShiftsRepository.addShift(shift);
      state = [...state]..insert(index, shift);
    } catch (e) {
      rethrow;
    }
  }

  void editShift(Shift shift) async {
    try {
      ShiftsRepository.updateShift(shift);
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
      final shifts = await ShiftsRepository.getShifts();
      state = shifts;
      return shifts..sort(((a, b) => b.startTime.compareTo(a.startTime)));
    } catch (e) {
      rethrow;
    }
  }

  void removeShift(Shift shift) async {
    try {
      await ShiftsRepository.deleteShift(shift);
      state = state.where((element) => element.id != shift.id).toList();
    } catch (e) {
      rethrow;
    }
  }
}
