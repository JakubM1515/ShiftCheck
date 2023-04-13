import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
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
          data: (summaries) => ListView.builder(
            itemCount: summaries.length,
            itemBuilder: (context, index) => ListTile(
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${summaries[index].shifts.length} shifts'),
                    const Text('840 PLN earned'),
                    const Text('84 hours in total'),
                  ],
                ),
              ),
              trailing: const FaIcon(FontAwesomeIcons.arrowDown),
            ),
          ),
        ),
      ),
    );
  }
}
