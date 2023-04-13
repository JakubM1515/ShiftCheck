import 'package:shift_check/src/features/shifts/data/datasources/shifts_datasource.dart';
import 'package:shift_check/src/features/shifts/domain/repositories/shifts_repository.dart';

import '../../../../shared/models/shift.dart';

class ShiftsRepositoryImpl extends ShiftsRepository {
  final ShiftsDataSource shiftsDataSource;
  ShiftsRepositoryImpl(this.shiftsDataSource);
  @override
  Future<List<Shift>> getShifts() async {
    try {
      return await shiftsDataSource.getShifts();
    } catch (e) {
      rethrow;
    }
  }

  @override
  String addShift({required Shift shift}) {
    try {
      return shiftsDataSource.addShift(shift: shift);
    } catch (e) {
      rethrow;
    }
  }

  @override
  void updateShift({required Shift shift}) {
    try {
      shiftsDataSource.updateShift(shift: shift);
    } catch (e) {
      rethrow;
    }
  }

  @override
  void deleteShift({required Shift shift}) {
    try {
      shiftsDataSource.deleteShift(shift: shift);
    } catch (e) {
      rethrow;
    }
  }
}
