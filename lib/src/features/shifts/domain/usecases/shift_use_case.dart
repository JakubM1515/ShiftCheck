import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:shift_check/src/shared/models/shift.dart';

import '../../../../core/constants/constants.dart';
import '../repositories/shifts_repository.dart';

class ShiftUseCase {
  final ShiftsRepository _shiftsRepository;
  ShiftUseCase(this._shiftsRepository);

  Future<Shift> addShift(Shift shift) async {
    var newId = _shiftsRepository.addShift(shift: shift);
    shift = shift.copyWith(id: newId);
    await Settings.setValue(
      Constants.salaryKey,
      shift.salary.toString(),
    );

    return shift;
  }

  void deleteShift(Shift shift) {
    _shiftsRepository.deleteShift(shift: shift);
  }

  Future<List<Shift>> getShifts() async {
    try {
      return _shiftsRepository.getShifts();
    } catch (e) {
      rethrow;
    }
  }

  void editShift(Shift shift) {
    _shiftsRepository.updateShift(shift: shift);
  }
}
