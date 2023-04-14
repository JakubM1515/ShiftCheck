import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shift_check/src/features/menu/domain/module/settings_provider.dart';

import '../../../../core/constants/constants.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  Widget _buildGeneralSettings(BuildContext context) {
    return SettingsGroup(title: 'General', children: [
      Column(
        children: [
          Row(
            children: [
              _buildSalarySettings(),
              _buildCurrencySettings(),
            ],
          ),
          Row(
            children: [
              _buildAppThemeSettings(),
            ],
          ),
        ],
      ),
    ]);
  }

  Flexible _buildAppThemeSettings() {
    return Flexible(
      child: Consumer(
        builder: (context, ref, child) => SwitchSettingsTile(
          onChange: (val) => ref.read(settingsUseCase).changeTheme(val),
          title: 'Dark Mode',
          settingKey: Constants.darkModeKey,
          leading: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.primary),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: FaIcon(FontAwesomeIcons.solidMoon, color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }

  Flexible _buildCurrencySettings() {
    return Flexible(
      child: TextInputSettingsTile(
        initialValue: 'PLN',
        settingKey: Constants.currencyKey,
        title: 'Currency',
        autovalidateMode: AutovalidateMode.always,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please, enter the currency';
          }
          return null;
        },
      ),
    );
  }

  Flexible _buildSalarySettings() {
    return Flexible(
      child: TextInputSettingsTile(
        initialValue: '22.9',
        keyboardType: TextInputType.number,
        settingKey: Constants.salaryKey,
        autovalidateMode: AutovalidateMode.always,
        title: 'Salary per hour',
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildGeneralSettings(context),
          ],
        ),
      ),
    );
  }
}
