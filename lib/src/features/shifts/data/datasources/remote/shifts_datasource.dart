
import '../../../../../shared/models/shift.dart';

abstract class ShiftsDataSource {
  Future<List<Shift>> getShifts();
  String addShift({required Shift shift});
  void updateShift({required Shift shift});
  void deleteShift({required Shift shift});
}
