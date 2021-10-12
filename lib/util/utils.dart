


import 'package:cupertino_nav/pages/home_tab.dart';
import 'package:cupertino_nav/pages/settings_tab.dart';
import 'package:cupertino_nav/pages/settings_tab2.dart';

import 'scaffold_properties.dart';

ScaffoldProperties getScaffoldPropertiesFromRouteName(String? route, int index) {
  switch (route) {
    case HomeTab.routeName:
      return ScaffoldProperties(title: "home", resizeBottom: true);
    case SettingsTab.routeName:
      return ScaffoldProperties(title: "settings 1", resizeBottom: false);
    case SettingsTab2.routeName:
      return ScaffoldProperties(title: "settings 2", resizeBottom: true);
    case "/":
      return getScaffoldPropertiesFromRoutePages(index);
  }
  return ScaffoldProperties(title: "NO ROUTE FOUND", resizeBottom: true);
}

String getRouteNameFromRoutePages(int index) {
switch (index) {
    case 0:
      return HomeTab.routeName;
    case 1:
      return SettingsTab.routeName;
  }
  return "unknown INDEX $index";
}

ScaffoldProperties getScaffoldPropertiesFromRoutePages(int index) { 
  return getScaffoldPropertiesFromRouteName(getRouteNameFromRoutePages(index), index);
}
