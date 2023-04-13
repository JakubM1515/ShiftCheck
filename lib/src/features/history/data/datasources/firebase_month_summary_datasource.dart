import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/constants/constants.dart';
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
}
