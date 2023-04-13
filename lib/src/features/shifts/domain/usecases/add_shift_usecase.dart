import 'package:flutter_settings_screens/flutter_settings_screens.dart';

import '../../../../core/constants/constants.dart';
import '../../../../shared/models/shift.dart';
import '../repositories/shifts_repository.dart';

class AddShiftUseCase {
  final ShiftsRepository _shiftsRepository;
  AddShiftUseCase(this._shiftsRepository);

  Future<Shift> addShift(Shift shift) async {
    var newId = _shiftsRepository.addShift(shift: shift);
    shift = shift.copyWith(id: newId);
    await Settings.setValue(
      Constants.salaryKey,
      shift.salary.toString(),
    );

    return shift;
  }
}
