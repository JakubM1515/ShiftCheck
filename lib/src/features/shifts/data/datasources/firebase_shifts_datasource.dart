import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shift_check/src/features/shifts/data/datasources/shifts_datasource.dart';

import '../../../../core/constants/constants.dart';
import '../../../../shared/models/shift.dart';

class FirebaseShiftsDatasource extends ShiftsDataSource {

  @override
  Future<List<Shift>> getShifts() async {
    final List<Shift> shifts = [];
    try {
      var collection = FirebaseFirestore.instance.collection('shifts');
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
        FirebaseFirestore.instance.collection(Constants.shiftsCollection).doc();
    shift = shift.copyWith(id: docUser.id);
    final json = shift.toMap();
    docUser.set(json);
    return docUser.id;
  }

  @override
  void updateShift({required Shift shift}) {
    try {
      final doc = FirebaseFirestore.instance
          .collection(Constants.shiftsCollection)
          .doc(shift.id);

      doc.update(shift.toMap());
    } catch (e) {
      throw Exception();
    }
  }

  @override
  void deleteShift({required Shift shift}) {
    try {
      final doc = FirebaseFirestore.instance
          .collection(Constants.shiftsCollection)
          .doc(shift.id);
      doc.delete();
    } catch (e) {
      throw Exception();
    }
  }
}
