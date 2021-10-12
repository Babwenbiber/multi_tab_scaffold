


import 'package:cupertino_nav/pages/home_tab.dart';
import 'package:cupertino_nav/pages/settings_tab.dart';
import 'package:cupertino_nav/pages/settings_tab2.dart';

import 'navbar_state.dart';

NavbarState getNavbarStateFromRouteName(String? route, int index) {
  switch (route) {
    case HomeTab.routeName:
      return NavbarState(title: "home", resizeBottom: true);
    case SettingsTab.routeName:
      return NavbarState(title: "settings 1", resizeBottom: false);
    case SettingsTab2.routeName:
      return NavbarState(title: "settings 2", resizeBottom: true);
    case "/":
      return getNavbarStateFromRoutePages(index);
  }
  return NavbarState(title: "NO ROUTE FOUND", resizeBottom: true);
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

NavbarState getNavbarStateFromRoutePages(int index) { 
  return getNavbarStateFromRouteName(getRouteNameFromRoutePages(index), index);
}
