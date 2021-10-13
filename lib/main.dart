import 'package:cupertino_nav/pages/home_tab.dart';
import 'package:cupertino_nav/pages/settings_tab.dart';
import 'package:cupertino_nav/util/scaffold_properties.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'multi_tab_scaffold.dart';
import 'pages/settings_tab2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: const CupertinoThemeData(
        scaffoldBackgroundColor: Colors.grey,
      ),
      home: MultiTabScaffold(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings')
        ],
        onGenerateRoute: (settings) {
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
          return CupertinoPageRoute(builder: (context) {
            return const HomeTab();
          });
        },
        getScaffoldPropertiesFromRouteName: (String? route) {
          switch (route) {
            case HomeTab.routeName:
              return ScaffoldProperties(title: "home", resizeBottom: true);
            case SettingsTab.routeName:
              return ScaffoldProperties(
                  title: "settings 1", resizeBottom: false);
            case SettingsTab2.routeName:
              return ScaffoldProperties(
                  title: "settings 2", resizeBottom: true);
          }
          return ScaffoldProperties(
              title: "NO ROUTE FOUND", resizeBottom: true);
        },
        pages: const [
          NamedWidget(page: HomeTab(), routeName: HomeTab.routeName),
          NamedWidget(page: SettingsTab(), routeName: SettingsTab.routeName)
        ],
      ),
    );
  }
}
