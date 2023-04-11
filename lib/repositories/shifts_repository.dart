import 'package:cloud_firestore/cloud_firestore.dart';

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
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<void> addShift(Shift shift) async {
    final docUser = FirebaseFirestore.instance.collection('shifts').doc();
    shift = shift.copyWith(id: docUser.id);
    final json = shift.toMap();
    await docUser.set(json);
  }

  static Future<void> updateShift(Shift shift) async {
    try {
      final doc = FirebaseFirestore.instance.collection('shifts').doc(shift.id);

      doc.update(shift.toMap());
    } catch (e) {
      throw Exception();
    }
  }

  static Future<void> deleteShift(Shift shift) async {
    try {
      final doc = FirebaseFirestore.instance.collection('shifts').doc(shift.id);
      doc.delete();
    } catch (e) {
      throw Exception();
    }
  }
}
