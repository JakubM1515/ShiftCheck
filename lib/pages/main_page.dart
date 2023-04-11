import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shift_check/models/shift.dart';
import 'package:shift_check/widgets/add_shift.dart';
import 'package:shift_check/widgets/nav_drawer.dart';

import '../providers/shifts_provider.dart';
import '../widgets/empty_list.dart';
import '../widgets/shift_card.dart';

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  Widget _listOfShifts() {
    return Consumer(
      builder: (context, ref, child) {
        final shifts = ref.watch(shiftsProvider);
        return Scrollbar(
          child: RefreshIndicator(
            onRefresh: () async => await ref.refresh(fetchShifts),
            child: shifts.isNotEmpty
                ? ListView.builder(
                    itemCount: shifts.length,
                    itemBuilder: (context, index) {
                      final shift = shifts[index];
                      return _buildDismissible(shift, ref, context, index);
                    },
                  )
                : const EmptyList(message: 'No shifts added'),
          ),
        );
      },
    );
  }

  Padding _buildDismissible(
      Shift shift, WidgetRef ref, BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      child: Dismissible(
        direction: DismissDirection.endToStart,
        key: Key(shift.id.toString()),
        onDismissed: (_) {
          ref.read(shiftsProvider.notifier).removeShift(shift);
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text('${shift.title} Deleted'),
                action: SnackBarAction(
                  label: 'UNDO',
                  onPressed: () => ref
                      .read(shiftsProvider.notifier)
                      .undoShiftDelete(index, shift),
                ),
              ),
            );
        },
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          child: const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: FaIcon(
              FontAwesomeIcons.trash,
              size: 40,
            ),
          ),
        ),
        child: ShiftCard(shift: shift),
      ),
    );
  }

  Future<dynamic> _showModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
      ),
      context: context,
      builder: (context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: const AddShift(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Check Your Shifts'),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final shiftsData = ref.watch(fetchShifts);
          return shiftsData.when(
              data: (data) => _listOfShifts(),
              error: (error, stackTrace) => Container(),
              loading: () => const Center(child: CircularProgressIndicator()));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showModalBottomSheet(context);
        },
        child: const FaIcon(FontAwesomeIcons.plus),
      ),
    );
  }
}