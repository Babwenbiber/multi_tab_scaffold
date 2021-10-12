import 'package:cupertino_nav/bloc/navstate_bloc.dart';
import 'package:cupertino_nav/pages/home_tab.dart';
import 'package:cupertino_nav/pages/settings_tab.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'multi_tab_scaffold.dart';
import 'navigation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final NavstateBloc bloc = NavstateBloc();
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: CupertinoApp(
        theme: const CupertinoThemeData(
          scaffoldBackgroundColor: Colors.grey,
        ),
        home: MultiTabScaffold(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings')
          ],
          onGenerateRoute: (settings) => Navigation.onGenerateRoute(settings),
          pages: const [HomeTab(), SettingsTab()],
        ),
        onGenerateRoute: Navigation.onGenerateRoute,
      ),
    );
  }
}
