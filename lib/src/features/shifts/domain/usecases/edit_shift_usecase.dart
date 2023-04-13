import '../../../../shared/models/shift.dart';
import '../repositories/shifts_repository.dart';

class EditShiftUseCase {
  final ShiftsRepository _shiftsRepository;
  EditShiftUseCase(this._shiftsRepository);

  void editShift(Shift shift) {
    _shiftsRepository.updateShift(shift: shift);
  }
}
