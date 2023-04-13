import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Text(
                'Menu',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.chartSimple),
            title: const Text('Statistics'),
            onTap: () {
              context.pushNamed('statistics');
            },
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.clockRotateLeft),
            title: const Text('History'),
            onTap: () {
              context.pushNamed('history');
            },
          ),
          const Divider(),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.gear),
            title: const Text('Settings'),
            onTap: () {
              context.pushNamed('settings');
            },
          ),
          const AboutListTile(
            // <-- SEE HERE
            icon: FaIcon(FontAwesomeIcons.circleInfo),
            applicationIcon: Icon(
              Icons.local_play,
            ),
            applicationName: 'Shift Check',
            applicationVersion: '1.0.0',
            applicationLegalese: '© 2023 Jakub Marciniak',

            child: Text('About app'),
          ),
        ],
      ),
    );
  }
}
