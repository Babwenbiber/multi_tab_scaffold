import 'package:cupertino_nav/pages/home_tab.dart';
import 'package:cupertino_nav/pages/settings_tab.dart';
import 'package:cupertino_nav/pages/settings_tab2.dart';
import 'package:flutter/cupertino.dart';


class Navigation {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeTab.routeName:
        return CupertinoPageRoute(builder: (context) {
          return const HomeTab();
        });
      case SettingsTab.routeName:
        return CupertinoPageRoute(builder: (context) {
          return const SettingsTab();
        });
      case SettingsTab2.routeName:
        return CupertinoPageRoute(builder: (context) {
          return const SettingsTab2();
        });
    }
  }
}