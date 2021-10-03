import 'package:cupertino_nav/settings_tab.dart';
import 'package:cupertino_nav/settings_tab2.dart';
import 'package:flutter/cupertino.dart';

import 'home_tab.dart';

class Navigation {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/home":
        return CupertinoPageRoute(builder: (context) {
          return const HomeTab();
        });
      case "/settings":
        return CupertinoPageRoute(builder: (context) {
          return const SettingsTab();
        });
      case "/settings2":
        return CupertinoPageRoute(builder: (context) {
          return const SettingsTab2();
        });
    }
  }
}