import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:intl/intl.dart';
import 'package:shift_check/constants/constants.dart';
import 'package:shift_check/providers/shifts_provider.dart';

import '../models/shift.dart';

class StatisticsPage extends ConsumerStatefulWidget {
  const StatisticsPage({super.key});

  @override
  ConsumerState<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends ConsumerState<StatisticsPage> {
  double calcTotalHours(List<Shift> shifts) {
    if (shifts.isNotEmpty) {
      double sum = 0;
      for (var shift in shifts) {
        sum += (shift.endTime.difference(shift.startTime).inMinutes) / 60;
      }

      return sum;
    } else {
      return 0;
    }
  }

  double calcMeanShifTime(List<Shift> shifts) {
    if (shifts.isNotEmpty) {
      double sum = 0;
      for (var shift in shifts) {
        sum += (shift.endTime.difference(shift.startTime).inMinutes) / 60;
      }

      return sum / shifts.length;
    } else {
      return 0;
    }
  }

  double calcTotalMoney(List<Shift> shifts) {
    if (shifts.isNotEmpty) {
      double sum = 0;
      for (var shift in shifts) {
        sum += shift.moneyEarned;
      }

      return sum;
    } else {
      return 0;
    }
  }

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
    var totalHours = calcTotalHours(shifts);

    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
      child: Row(
        children: [
          Text(
            'Total hours: ',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            '${roundDoubleToString(totalHours, 2)} h',
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
    var totalMoney = calcTotalMoney(shifts);

    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
      child: Row(
        children: [
          Text(
            'Money earned: ',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            '${roundDoubleToString(totalMoney, 2)} ${Settings.getValue(currencyKey, defaultValue: 'PLN')}',
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
    var meanShiftTime = calcMeanShifTime(shifts);

    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
      child: Row(
        children: [
          Text(
            'Mean shift time: ',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            '${roundDoubleToString(meanShiftTime, 2)} h',
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
        title: const Text('Statistics'),
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
          ],
        ),
      ),
    );
  }
}
