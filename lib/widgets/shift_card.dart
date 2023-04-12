import 'package:flutter/material.dart';

import '../src/core/constants/constants.dart';
import '../src/core/functions/functions.dart';
import '../src/models/shift.dart';
import 'add_or_edit_shift_modal_bottom_sheet.dart';

class ShiftCard extends StatelessWidget {
  const ShiftCard({
    Key? key,
    required this.shift,
  }) : super(key: key);

  final Shift shift;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
        ),
        context: context,
        builder: (context) => Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: AddOrEditShiftModalBottomSheet(
            shift: shift,
          ),
        ),
      ),
      child: Card(
        color: Theme.of(context).colorScheme.surface,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    shift.title,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    Constants.dateFormat.format(shift.startTime),
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Start time: ${Constants.timeFormat.format(shift.startTime)}'),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('End time: ${Constants.timeFormat.format(shift.endTime)}'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, bottom: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Total hours: ${Functions().roundDoubleToString((shift.endTime.difference(shift.startTime).inMinutes / 60), 2)}'),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                          'Money earned: ${Functions().roundDoubleToString(shift.moneyEarned, 2)} ${shift.currency}'),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
