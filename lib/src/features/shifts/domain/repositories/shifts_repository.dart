import '../../../../shared/models/shift.dart';

abstract class ShiftsRepository {
  Future<List<Shift>> getShifts();
  String addShift({required Shift shift});
  void updateShift({required Shift shift});
  void deleteShift({required Shift shift});
  Future<bool> checkIfLastMonthShiftsExist();
}
