import 'package:cupertino_nav/home_tab.dart';
import 'package:cupertino_nav/settings_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'multi_tab_scaffold.dart';
import 'navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      theme: CupertinoThemeData(
        scaffoldBackgroundColor: Colors.grey,
      ),
      home: MultiTabScaffold(items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'Settings')
              ], pages: [HomeTab(), SettingsTab()],),
      onGenerateRoute: Navigation.onGenerateRoute,
    );
  }
}