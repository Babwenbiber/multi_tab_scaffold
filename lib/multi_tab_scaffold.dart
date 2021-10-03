import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'navigation.dart';

class MultiTabScaffold extends StatefulWidget {
  const MultiTabScaffold(
      {Key? key,
      required this.pages,
      required this.items,
      this.onGenerateRoute})
      : super(key: key);
  final List<Widget> pages;
  final List<BottomNavigationBarItem> items;
  final Route<dynamic>? Function(RouteSettings)? onGenerateRoute;
  final List<NavigatorObserver> navigatorObservers =
      const <NavigatorObserver>[];

  @override
  _MultiTabScaffoldState createState() => _MultiTabScaffoldState();
}

class _MultiTabScaffoldState extends State<MultiTabScaffold> {
  final List<CupertinoTabView> _tabs = [];
  final Set<int> tabStack = {};
  final CupertinoTabController _tabController = CupertinoTabController();

  @override
  void initState() {
    for (var element in widget.pages) {
      _tabs.add(CupertinoTabView(
        navigatorKey: GlobalKey<NavigatorState>(),
        builder: (context) => element,
        onGenerateRoute: Navigation.onGenerateRoute,
        navigatorObservers: widget.navigatorObservers,
      ));
    }
    tabStack.add(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: CupertinoPageScaffold(
        child: CupertinoTabScaffold(
            controller: _tabController,
            tabBar: CupertinoTabBar(
              onTap: onTap,
              items: widget.items,
            ),
            tabBuilder: (BuildContext context, index) {
              return _tabs[index];
            }),
      ),
    );
  }

  void onTap(int tappedIndex) {
    if (_tabController.index == tappedIndex) {
      _tabs[_tabController.index]
          .navigatorKey
          ?.currentState
          ?.popUntil(ModalRoute.withName("/"));
    }
    tabStack.remove(tappedIndex);
    tabStack.add(tappedIndex);
    _tabController.index = tappedIndex;
  }

  Future<bool> _onWillPop() async {
    bool canPop =
        _tabs[_tabController.index].navigatorKey?.currentState?.canPop() ??
            false;

    if (!canPop) {
      if (tabStack.length > 1) {
        tabStack.remove(_tabController.index);
        setState(() {
          _tabController.index = tabStack.last;
        });
      } else {
        return true;
      }
    } else {
      _tabs[_tabController.index].navigatorKey?.currentState?.pop();
    }
    return false;
  }
}
