import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OnErrorWidget extends StatelessWidget {
  final void Function()? onPressed;
  const OnErrorWidget({super.key, required this.onPressed});

  void _buildSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: Container(
            padding: const EdgeInsets.all(16),
            height: 90,
            decoration: const BoxDecoration(
              color: Color(0xFFC72C41),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: LimitedBox(
                      child: FaIcon(FontAwesomeIcons.triangleExclamation)),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ooops...',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      Text(
                        'Cannot load data from database. Try again.',
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _buildSnackBar(context),
    );
    return Center(
      child: ElevatedButton(
        onPressed: onPressed,
        child: const Text(
          'Try again',
        ),
      ),
    );
  }
}
