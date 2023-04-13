import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shift_check/src/features/history/data/module/module.dart';
import 'package:shift_check/src/features/history/domain/usecases/month_summary_usecase.dart';

final monthSummaryUseCase = Provider.autoDispose(
  (ref) {
    final repo = ref.watch(monthSummaryRepository);
    return MonthSummaryUseCase(repo);
  },
);

final fetchMonthSummaries = FutureProvider.autoDispose(
  (ref) => ref.watch(monthSummaryUseCase).getSummaries(),
);
