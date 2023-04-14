import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/constants/constants.dart';
import '../../../shifts/domain/models/shift.dart';
import '../../domain/models/month_summary.dart';
import 'month_summary_datasource.dart';

class FirebaseMonthSummaryDataSource extends MonthSummaryDataSource {
  final String summariesCollection = Constants.monthSummariesCollection;
  @override
  Future<List<MonthSummary>> getMonthSummaries() async {
    final List<MonthSummary> summaries = [];
    try {
      var collection =
          FirebaseFirestore.instance.collection(summariesCollection);
      var querySnapshot = await collection.get();
      for (var element in querySnapshot.docs) {
        Map<String, dynamic> data = element.data();
        summaries.add(
          MonthSummary.fromMap(data),
        );
      }
      return summaries;
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }

  @override
  void sentMonthSummary(MonthSummary summary) {
    final docUser =
        FirebaseFirestore.instance.collection(summariesCollection).doc();
    final json = summary.toMap();
    docUser.set(json);
  }
  
  @override
  Future<bool> checkAndMaybeCreateSummary()async {
   final List<Shift> shifts = [];

    final DateTime date = DateTime.now();
    try {
      var collection = FirebaseFirestore.instance
          .collection(Constants.shiftsCollection)
          .where(
            "startTime",
            isGreaterThanOrEqualTo:
                DateTime(date.year, date.month - 1, 1).toIso8601String(),
            isLessThan: DateTime(date.year, date.month, 1).toIso8601String(),
          )
          .orderBy("startTime", descending: true);
      var querySnapshot = await collection.get();
      for (var element in querySnapshot.docs) {
        Map<String, dynamic> data = element.data();
        shifts.add(Shift.fromMap(data));
      }
      if (shifts.isNotEmpty) {
        var summary = MonthSummary(date: shifts.last.startTime, shifts: shifts);
        FirebaseMonthSummaryDataSource().sentMonthSummary(summary);
        for (var shift in shifts) {
          FirebaseFirestore.instance
              .collection(Constants.shiftsCollection)
              .doc(shift.id)
              .delete();
        }
        return true;
      } else {
        return false;
      }
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }
}
