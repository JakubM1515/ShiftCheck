import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shift_check/src/features/shifts/data/datasources/remote/shifts_datasource.dart';

import '../../../../../core/constants/constants.dart';
import '../../../domain/models/shift.dart';

class FirebaseShiftsDatasource extends ShiftsDataSource {
  final shiftsCollection = Constants.shiftsCollection;

  @override
  Future<List<Shift>> getShifts() async {
    final List<Shift> shifts = [];
    final DateTime date = DateTime.now();
    try {
      var collection =
          FirebaseFirestore.instance.collection(shiftsCollection).where(
                "startTime",
                isGreaterThanOrEqualTo:
                    DateTime(date.year, date.month, 1).toIso8601String(),
                isLessThan:
                    DateTime(date.year, date.month + 1, 1).toIso8601String(),
              );
      var querySnapshot = await collection.get();
      for (var element in querySnapshot.docs) {
        Map<String, dynamic> data = element.data();
        shifts.add(Shift.fromMap(data));
      }
      return shifts;
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }

  @override
  String addShift({required Shift shift}) {
    final docUser =
        FirebaseFirestore.instance.collection(shiftsCollection).doc();
    shift = shift.copyWith(id: docUser.id);
    final json = shift.toMap();
    docUser.set(json);
    return docUser.id;
  }

  @override
  void updateShift({required Shift shift}) {
    try {
      final doc =
          FirebaseFirestore.instance.collection(shiftsCollection).doc(shift.id);

      doc.update(shift.toMap());
    } catch (e) {
      throw Exception();
    }
  }

  @override
  void deleteShift({required Shift shift}) {
    try {
      final doc =
          FirebaseFirestore.instance.collection(shiftsCollection).doc(shift.id);
      doc.delete();
    } catch (e) {
      throw Exception();
    }
  }


}
