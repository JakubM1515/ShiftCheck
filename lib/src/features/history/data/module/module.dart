import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shift_check/src/features/history/data/repositories/month_summary_repository_impl.dart';

import '../datasources/firebase_month_summary_datasource.dart';

final monthSummaryDataSource =
    Provider.autoDispose((ref) => FirebaseMonthSummaryDataSource());

final monthSummaryRepository = Provider.autoDispose((ref) {
  final dataSource = ref.watch(monthSummaryDataSource);
  return MonthSummaryRepositoryImpl(dataSource);
});
