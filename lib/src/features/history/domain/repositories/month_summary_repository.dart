import '../models/month_summary.dart';

abstract class MonthSummaryRepository {
  Future<List<MonthSummary>> getMonthSummaries();
  Future<bool> checkAndMaybeCreateSummary();
}
