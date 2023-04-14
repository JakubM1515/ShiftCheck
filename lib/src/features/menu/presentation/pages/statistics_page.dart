import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:intl/intl.dart';
import 'package:shift_check/src/core/constants/constants.dart';
import 'package:shift_check/src/features/shifts/presentation/providers/shifts_provider.dart';

import '../../../../core/functions/functions.dart';
import '../../../../shared/animations/animations.dart';
import '../../../shifts/domain/models/shift.dart';

class StatisticsPage extends ConsumerStatefulWidget {
  const StatisticsPage({super.key});

  @override
  ConsumerState<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends ConsumerState<StatisticsPage> {
  Padding _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
      child: Text(
        'Current month: ${DateFormat('MMMM').format(DateTime.now())} ',
        style: Theme.of(context).textTheme.headline4,
      ),
    );
  }

  Padding _buildNumberOfShifts(BuildContext context, List<Shift> shifts) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
      child: Row(
        children: [
          Text(
            'Number of shifts: ',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            shifts.length.toString(),
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Padding _buildTotalHours(BuildContext context, List<Shift> shifts) {
    var totalHours = Functions.calcTotalHours(shifts);

    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
      child: Row(
        children: [
          Text(
            'Total hours: ',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            '${Functions.roundDoubleToString(totalHours, 2)} h',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Padding _buildMoneyEarned(BuildContext context, List<Shift> shifts) {
    var totalMoney = Functions.calcTotalMoney(shifts);

    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
      child: Row(
        children: [
          Text(
            'Money earned: ',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            '${Functions.roundDoubleToString(totalMoney, 2)} ${Settings.getValue(Constants.currencyKey, defaultValue: 'PLN')}',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Padding _buildMeanShiftTime(BuildContext context, List<Shift> shifts) {
    var meanShiftTime = Functions.calcMeanShifTime(shifts);

    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
      child: Row(
        children: [
          Text(
            'Mean shift time: ',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            '${Functions.roundDoubleToString(meanShiftTime, 2)} h',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var shifts = ref.watch(shiftsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics')
            .animate(effects: Animations.appBarTitleAnimation),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(context),
            const Divider(),
            _buildNumberOfShifts(context, shifts),
            _buildTotalHours(context, shifts),
            _buildMoneyEarned(context, shifts),
            _buildMeanShiftTime(context, shifts),
          ].animate(
              interval: 100.ms, effects: Animations.contentColumnAnimation),
        ),
      ),
    );
  }
}
