import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:shift_check/src/core/functions/functions.dart';
import 'package:shift_check/src/features/history/domain/models/month_summary.dart';
import 'package:shift_check/src/shared/widgets/empty_refreshable_list.dart';

import 'package:shift_check/src/shared/widgets/on_error_widget.dart';

import '../../../../shared/animations/animations.dart';
import '../../domain/module/month_summary_provider.dart';

class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});

  ListView _buildListOfSummaries(List<MonthSummary> summaries) {
    return ListView.builder(
      itemCount: summaries.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ListTile(
          onTap: () =>
              context.goNamed('history-detail', extra: summaries[index]),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat('MMMM').format(summaries[index].date),
              ),
              Text(
                summaries[index].date.year.toString(),
              ),
            ],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${summaries[index].shifts.length} shifts'),
                Text(
                    '${Functions.calcTotalMoney(summaries[index].shifts)} earned'),
                Text(
                    '${Functions.calcTotalHours(summaries[index].shifts)} hours'),
              ],
            ),
          ),
          trailing: const FaIcon(FontAwesomeIcons.arrowRight),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, ref) {
    final summariesData = ref.watch(fetchMonthSummaries);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'History',
        ).animate(effects: Animations.appBarTitleAnimation),
      ),
      body: SafeArea(
        child: summariesData.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, __) => OnErrorWidget(
                  onPressed: () async =>
                      await ref.refresh(fetchMonthSummaries.future),
                ),
            data: (summaries) => summaries.isNotEmpty
                ? _buildListOfSummaries(summaries)
                : const EmptyRefreshableList(message: 'No history yet.')),
      ),
    );
  }
}
