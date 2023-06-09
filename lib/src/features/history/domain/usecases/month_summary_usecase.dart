import '../models/month_summary.dart';
import '../repositories/month_summary_repository.dart';

class MonthSummaryUseCase {
  MonthSummaryUseCase(this._repo);
  final MonthSummaryRepository _repo;

  Future<List<MonthSummary>> getSummaries() async {
    try {
      return await _repo.getMonthSummaries()
        ..sort(
          (a, b) => b.date.compareTo(a.date),
        );
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> checkAndMaybeCreateSummary() async {
    try {
      return await _repo.checkAndMaybeCreateSummary();
    } catch (e) {
      return false;
    }
  }
}
