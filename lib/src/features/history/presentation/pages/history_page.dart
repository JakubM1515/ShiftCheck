import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shift_check/src/shared/widgets/on_error_widget.dart';

import '../../domain/module/month_summary_provider.dart';

class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final summariesData = ref.watch(fetchMonthSummaries);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'History',
        ),
      ),
      body: SafeArea(
        child: summariesData.when(
          loading: () => const CircularProgressIndicator(),
          error: (_, __) => OnErrorWidget(onPressed: () {}),
          data: (summaries) => Container(),
        ),
      ),
    );
  }
}
