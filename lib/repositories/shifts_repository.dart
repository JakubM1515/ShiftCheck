import 'package:cloud_firestore/cloud_firestore.dart';

import '../core/constants/constants.dart';
import '../models/shift.dart';

class ShiftsRepository {

  static Future<List<Shift>> getShifts() async {
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

  static String addShift(Shift shift) {
    final docUser = FirebaseFirestore.instance.collection(Constants.shiftsCollection).doc();
    shift = shift.copyWith(id: docUser.id);
    final json = shift.toMap();
    docUser.set(json);
    return docUser.id;
  }

  static void updateShift(Shift shift) {
    try {
      final doc = FirebaseFirestore.instance.collection(Constants.shiftsCollection).doc(shift.id);

      doc.update(shift.toMap());
    } catch (e) {
      throw Exception();
    }
  }

  static void deleteShift(Shift shift) {
    try {
      final doc = FirebaseFirestore.instance.collection(Constants.shiftsCollection).doc(shift.id);
      doc.delete();
    } catch (e) {
      throw Exception();
    }
  }
}
