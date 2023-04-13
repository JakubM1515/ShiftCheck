import '../../../../shared/models/shift.dart';
import '../repositories/shifts_repository.dart';

class RemoveShiftUseCase {
  final ShiftsRepository _shiftsRepository;
  RemoveShiftUseCase(this._shiftsRepository);

  void deleteShift(Shift shift) {
    _shiftsRepository.deleteShift(shift: shift);
  }
}
