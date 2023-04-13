import 'package:shift_check/src/features/shifts/domain/repositories/shifts_repository.dart';

import '../../../../shared/models/shift.dart';

class GetShiftsUseCase {
  final ShiftsRepository _shiftsRepository;
  GetShiftsUseCase(this._shiftsRepository);

  Future<List<Shift>> getShifts() async {
    try {
      return _shiftsRepository.getShifts();
    } catch (e) {
      rethrow;
    }
  }
}
