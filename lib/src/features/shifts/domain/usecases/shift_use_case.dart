import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

import '../../../../core/constants/constants.dart';
import '../../../../shared/models/shift.dart';
import '../../presentation/providers/shifts_provider.dart';
import '../repositories/shifts_repository.dart';



class ShiftUseCase {
  final ShiftsRepository _shiftsRepository;
  final Ref _ref;
  ShiftUseCase(this._shiftsRepository, this._ref);

  Future<void> addShift(Shift shift) async {
    try {
      var newId = _shiftsRepository.addShift(shift: shift);
      shift = shift.copyWith(id: newId);
      await Settings.setValue(
        Constants.salaryKey,
        shift.salary.toString(),
      );
      _ref.read(shiftsProvider.notifier).addShift(shift);
    } catch (e) {
      rethrow;
    }
  }

  void undoShiftDelete(int index, Shift shift) {
    try {
      _shiftsRepository.addShift(shift: shift);
      _ref.read(shiftsProvider.notifier).undoShiftDelete(index, shift);
    } catch (e) {
      rethrow;
    }
  }

  void deleteShift(Shift shift) {
    try {
      _shiftsRepository.deleteShift(shift: shift);
      _ref.read(shiftsProvider.notifier).removeShift(shift);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Shift>> getShifts() async {
    try {
      var shifts = await _shiftsRepository.getShifts();
      _ref.read(shiftsProvider.notifier).setShifts(shifts);
      return shifts;
    } catch (e) {
      rethrow;
    }
  }

  void editShift(Shift shift) {
    try {
      _shiftsRepository.updateShift(shift: shift);
      _ref.read(shiftsProvider.notifier).editShift(shift);
    } catch (e) {
      rethrow;
    }
  }
}
