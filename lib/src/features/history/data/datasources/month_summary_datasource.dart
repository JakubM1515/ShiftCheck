import '../../domain/models/month_summary.dart';

abstract class MonthSummaryDataSource {
  Future<List<MonthSummary>> getMonthSummaries();
  void sentMonthSummary(MonthSummary summary);
}
