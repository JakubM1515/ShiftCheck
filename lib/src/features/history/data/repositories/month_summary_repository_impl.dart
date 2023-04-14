import 'package:shift_check/src/features/history/data/datasources/month_summary_datasource.dart';

import '../../domain/models/month_summary.dart';
import '../../domain/repositories/month_summary_repository.dart';

class MonthSummaryRepositoryImpl extends MonthSummaryRepository {
  MonthSummaryRepositoryImpl(this._dataSource);
  final MonthSummaryDataSource _dataSource;
  @override
  Future<List<MonthSummary>> getMonthSummaries() async {
    return await _dataSource.getMonthSummaries();
  }

  @override
  Future<bool> checkAndMaybeCreateSummary() async {
    return await _dataSource.checkAndMaybeCreateSummary();
  }
}
