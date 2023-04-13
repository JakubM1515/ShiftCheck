import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:go_router/go_router.dart';
import 'package:shift_check/src/core/constants/constants.dart';
import 'package:shift_check/src/models/shift.dart';
import 'package:shift_check/src/providers/shifts_provider.dart';
import 'package:shift_check/src/widgets/functions/show_snack_bar.dart';

import '../core/functions/functions.dart';

class AddOrEditShiftModalBottomSheet extends ConsumerStatefulWidget {
  final Shift? shift;
  const AddOrEditShiftModalBottomSheet({super.key, this.shift});

  @override
  ConsumerState<AddOrEditShiftModalBottomSheet> createState() =>
      _AddOrEditShiftModalBottomSheetState();
}

class _AddOrEditShiftModalBottomSheetState
    extends ConsumerState<AddOrEditShiftModalBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final title = TextEditingController();
  final currency = TextEditingController();
  final salary = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();
  final date = TextEditingController();
  late TimeOfDay shiftStartTime;
  DateTime shiftDate = DateTime.now();
  TimeOfDay shiftEndTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    if (widget.shift != null) {
      _initShiftData();
    } else {
      _initDefeaultData();
    }
  }

  void _initDefeaultData() {
    endTimeController.text = Constants.timeFormat.format(DateTime.now());
    date.text = Constants.dateFormat.format(DateTime.now());
    title.text = 'Shift';
    currency.text =
        Settings.getValue(Constants.currencyKey, defaultValue: 'PLN')!;
    salary.text =
        Settings.getValue(Constants.salaryKey, defaultValue: 0.toString())!;
  }

  void _initShiftData() {
    title.text = widget.shift!.title;
    currency.text = widget.shift!.currency;
    salary.text = Functions().roundDoubleToString(widget.shift!.salary, 2);
    startTimeController.text =
        Constants.timeFormat.format(widget.shift!.startTime);
    endTimeController.text = Constants.timeFormat.format(widget.shift!.endTime);
    date.text = Constants.dateFormat.format(widget.shift!.startTime);
    shiftStartTime = TimeOfDay(
        hour: int.parse(startTimeController.text.split(":")[0]),
        minute: int.parse(startTimeController.text.split(":")[1]));
    shiftEndTime = TimeOfDay(
        hour: int.parse(endTimeController.text.split(":")[0]),
        minute: int.parse(endTimeController.text.split(":")[1]));
    shiftDate = widget.shift!.startTime;
  }

  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        date.text = Constants.dateFormat.format(pickedDate);
        shiftDate = pickedDate;
      });
    }
  }

  void addShift() async {
    if (_formKey.currentState!.validate()) {
      var startTime = DateTime(shiftDate.year, shiftDate.month, shiftDate.day,
          shiftStartTime.hour, shiftStartTime.minute);
      var endTime = DateTime(
        shiftDate.year,
        shiftDate.month,
        shiftDate.day,
        shiftEndTime.hour,
        shiftEndTime.minute,
      );
      if (!endTime.isAfter(startTime)) {
        endTime = DateTime(
          shiftDate.year,
          shiftDate.month,
          shiftDate.day + 1,
          shiftEndTime.hour,
          shiftEndTime.minute,
        );
      }
      final newShift = Shift(
        id: (ref.read(shiftsProvider).length + 1).toString(),
        salary: Functions().roundDouble(
            double.parse(
              salary.text.replaceAll(',', '.'),
            ),
            2),
        startTime: startTime,
        endTime: endTime,
        title: title.text,
        currency: currency.text,
        moneyEarned: endTime.isAfter(startTime)
            ? (endTime.difference(startTime).inMinutes / 60) *
                double.parse(
                  salary.text.replaceAll(',', '.'),
                )
            : (startTime.difference(endTime).inMinutes / 60) *
                double.parse(
                  salary.text.replaceAll(',', '.'),
                ),
      );
      try {
        await ref.read(shiftsProvider.notifier).addShift(newShift).then(
              (_) =>
                  ShowSnackBar().buildSuccessSnackBar(context, 'Shift added.'),
            );
      } catch (e) {
        ShowSnackBar().buildErrorSnackBar(context);
      }
      if (!mounted) return;
      context.pop();
    }
  }

  void editShift() async {
    if (_formKey.currentState!.validate()) {
      final startTime = DateTime(shiftDate.year, shiftDate.month, shiftDate.day,
          shiftStartTime.hour, shiftStartTime.minute);
      final endTime = DateTime(
        shiftDate.year,
        shiftDate.month,
        shiftDate.day,
        shiftEndTime.hour,
        shiftEndTime.minute,
      );
      final editedShift = widget.shift!.copyWith(
        startTime: startTime,
        endTime: endTime,
        title: title.text,
        moneyEarned: (endTime.difference(startTime).inMinutes / 60) *
            double.parse(
              salary.text.replaceAll(',', '.'),
            ),
        currency: currency.text,
        salary: Functions().roundDouble(
            double.parse(
              salary.text.replaceAll(',', '.'),
            ),
            2),
      );
      try {
        ref.read(shiftsProvider.notifier).editShift(editedShift);
        ShowSnackBar().buildSuccessSnackBar(context, 'Shift edited.');
      } catch (e) {
        ShowSnackBar().buildErrorSnackBar(context);
      }
      if (mounted) {
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildTitleField(),
          Row(
            children: [
              _buildStartTimeField(context),
              const Text('-'),
              _buildEndTimeField(context),
            ],
          ),
          _buildDateField(),
          Row(
            children: [
              _buildSalaryField(),
              _buildCurrencyField(),
            ],
          ),
          _buildButton(),
        ],
      ),
    );
  }

  Padding _buildTitleField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.always,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Type the title';
          }
          return null;
        },
        controller: title,
        decoration: const InputDecoration(
          label: Text('Title'),
          prefixIcon: Icon(Icons.title),
        ),
      ),
    );
  }

  Flexible _buildStartTimeField(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          autovalidateMode: AutovalidateMode.always,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Select the start time';
            }
            return null;
          },
          onTap: () => _pickStartTime(context),
          readOnly: true,
          controller: startTimeController,
          decoration: const InputDecoration(
            labelText: 'Start Time',
            prefixIcon: Icon(Icons.timer_outlined),
          ),
        ),
      ),
    );
  }

  Future<void> _pickStartTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 7, minute: 15),
    );
    if (newTime != null) {
      setState(() {
        startTimeController.text = newTime.format(context);
        shiftStartTime = newTime;
      });
    }
  }

  Flexible _buildEndTimeField(BuildContext context) {
    return Flexible(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.always,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Select the end time';
          }
          return null;
        },
        onTap: () => _pickEndTime(context),
        readOnly: true,
        controller: endTimeController,
        decoration: const InputDecoration(
          labelText: 'End Time',
          prefixIcon: Icon(Icons.timer_outlined),
        ),
      ),
    ));
  }

  Future<void> _pickEndTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime:
          TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute),
    );
    if (newTime != null) {
      setState(() {
        shiftEndTime = newTime;
        endTimeController.text = newTime.format(context);
      });
    }
  }

  Padding _buildDateField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.always,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Select the date';
          }
          return null;
        },
        onTap: () => _pickDate(),
        readOnly: true,
        controller: date,
        decoration: const InputDecoration(
            labelText: 'Date', prefixIcon: Icon(Icons.date_range_outlined)),
      ),
    );
  }

  Padding _buildButton() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Consumer(
        builder: (context, ref, child) => SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: ElevatedButton(
            onPressed: () => widget.shift == null ? addShift() : editShift(),
            child: widget.shift == null
                ? const Text('Add Shift')
                : const Text('Edit Shift'),
          ),
        ),
      ),
    );
  }

  Flexible _buildCurrencyField() {
    return Flexible(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        readOnly: true,
        autovalidateMode: AutovalidateMode.always,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Type the currency';
          }

          return null;
        },
        controller: currency,
        decoration: const InputDecoration(
          labelText: 'Currency',
          prefixIcon: Icon(Icons.currency_exchange),
        ),
      ),
    ));
  }

  Flexible _buildSalaryField() {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          keyboardType: TextInputType.number,
          autovalidateMode: AutovalidateMode.always,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Type the salary per hour';
            }
            var parsedNum = double.tryParse(value);
            if (parsedNum != null && parsedNum <= 0) {
              return 'Salary must be greater than 0';
            }
            if (parsedNum == null) {
              return 'Invalid input';
            }
            return null;
          },
          controller: salary,
          decoration: const InputDecoration(
            labelText: 'Salary per hour',
            prefixIcon: Icon(Icons.attach_money),
          ),
        ),
      ),
    );
  }
}
