import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:shift_check/src/features/history/domain/models/month_summary.dart';
import 'package:shift_check/src/features/shifts/presentation/widgets/shift_card.dart';

import '../../../../shared/animations/animations.dart';

class HistoryDetailPage extends StatelessWidget {
  final MonthSummary summary;
  const HistoryDetailPage({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
                '${DateFormat('MMMM').format(summary.date)} ${summary.date.year}')
            .animate(effects: Animations.appBarTitleAnimation),
      ),
      body: SafeArea(
        child: Scrollbar(
          child: ListView.builder(
            itemCount: summary.shifts.length,
            itemBuilder: (context, index) => Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
              child: ShiftCard(
                shift: summary.shifts[index],
                toEdit: false,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
