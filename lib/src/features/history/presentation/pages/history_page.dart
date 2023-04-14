import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:shift_check/src/core/functions/functions.dart';
import 'package:shift_check/src/shared/widgets/empty_refreshable_list.dart';

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
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, __) => OnErrorWidget(onPressed: () {}),
            data: (summaries) => summaries.isNotEmpty
                ? ListView.builder(
                    itemCount: summaries.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: ListTile(
                        onTap: () => context.goNamed('history-detail',
                            extra: summaries[index]),
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
                                  '${Functions().calcTotalMoney(summaries[index].shifts)} earned'),
                              Text(
                                  '${Functions().calcTotalHours(summaries[index].shifts)} hours'),
                            ],
                          ),
                        ),
                        trailing: const FaIcon(FontAwesomeIcons.arrowRight),
                      ),
                    ),
                  )
                : const EmptyRefreshableList(message: 'No history yet.')),
      ),
    );
  }
}
