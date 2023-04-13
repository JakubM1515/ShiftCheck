import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shift_check/src/shared/models/shift.dart';
import 'package:shift_check/src/shared/widgets/functions/show_snack_bar.dart';
import 'package:shift_check/src/features/shifts/presentation/widgets/add_or_edit_shift_modal_bottom_sheet.dart';
import 'package:shift_check/src/shared/widgets/on_error_widget.dart';
import 'package:shift_check/src/features/menu/presentation/widgets/nav_drawer.dart';

import '../../domain/module/shift_provider.dart';
import '../providers/shifts_provider.dart';
import '../../../../shared/widgets/empty_refreshable_list.dart';
import '../../../../shared/widgets/shift_card.dart';

class MainPage extends ConsumerWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  MainPage({super.key});

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
                : const EmptyRefreshableList(message: 'No shifts added'),
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
          try {
            ref.read(shiftUseCase).deleteShift(shift);
            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text('${shift.title} Deleted'),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      try {
                        ref.read(shiftUseCase).undoShiftDelete(index, shift);
                        ShowSnackBar().buildSuccessSnackBar(
                            _scaffoldKey.currentState!.context, 'Shift added');
                      } catch (e) {
                        ShowSnackBar().buildErrorSnackBar(context);
                      }
                    },
                  ),
                ),
              );
          } catch (e) {
            ShowSnackBar().buildErrorSnackBar(context);
          }
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
        child: const AddOrEditShiftModalBottomSheet(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, ref) {
    ref.listen(shouldEndMotnh, (previous, next) {
      if (next == true) {
        ShowSnackBar().buildSuccessSnackBar(
            context, 'Month just ended! You can see results in history');
        ref.read(shouldEndMotnh.notifier).update((state) => false);
      }
    });
    return Scaffold(
      key: _scaffoldKey,
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Check Your Shifts'),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final shiftsData = ref.watch(fetchShifts);
          return shiftsData.when(
            skipLoadingOnRefresh: true,
            skipError: true,
            data: (data) => _listOfShifts(),
            error: (error, stackTrace) => OnErrorWidget(
              onPressed: () async => await ref.refresh(fetchShifts),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          );
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
