import '../../../menu/data/datasources/local/shifts_local_data_source.dart';
import '../../domain/models/shift.dart';
import '../../domain/repositories/shifts_repository.dart';
import '../datasources/remote/shifts_datasource.dart';

class ShiftsRepositoryImpl extends ShiftsRepository {
  final ShiftsDataSource shiftsDataSource;
  final SettingsLocalDataSource shiftsLocalDataSource;
  ShiftsRepositoryImpl(this.shiftsDataSource, this.shiftsLocalDataSource);
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
      shiftsLocalDataSource.saveSalary(shift.salary.toString());
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
