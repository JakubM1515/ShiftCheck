import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

import '../constants/constants.dart';

late final StateProvider<bool> darkModeProvider;

class AppThemeProvider {
  static void initAppTheme() {
    final darkMode = Settings.getValue(Constants.darkModeKey, defaultValue: true);
    darkModeProvider = StateProvider(
      (ref) => darkMode!,
    );
  }
}
