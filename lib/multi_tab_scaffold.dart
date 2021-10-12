import 'package:cupertino_nav/util/scaffold_properties.dart';
import 'package:cupertino_nav/util/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/my_scaffold_bloc.dart';
import 'util/navigation.dart';

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
  int activeIndex = 0;
  @override
  void initState() {
    for (var element in widget.pages) {
      _tabs.add(CupertinoTabView(
        navigatorKey: GlobalKey<NavigatorState>(),
        builder: (context) => element,
        onGenerateRoute: (settings) {
          final route = Navigation.onGenerateRoute(settings);
          BlocProvider.of<MyScaffoldBloc>(context).add(MyScaffoldEvent(
              getScaffoldPropertiesFromRouteName(
                  settings.name, _tabController.index)));
          return route;
        },
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
      child: BlocBuilder<MyScaffoldBloc, MyAbstractScaffoldState>(
          builder: (context, MyAbstractScaffoldState state) {
        late ScaffoldProperties scaffoldProperties;
        if (state is MyScaffoldState) {
          scaffoldProperties = state.scaffoldProperties;
        } else {
          scaffoldProperties =
              getScaffoldPropertiesFromRouteName(getRouteName(), _tabController.index);
        }
        return CupertinoPageScaffold(
          navigationBar:
              CupertinoNavigationBar(middle: Text(scaffoldProperties.title)),
          child: CupertinoTabScaffold(
              controller: _tabController,
              tabBar: CupertinoTabBar(
                onTap: onTap,
                items: widget.items,
              ),
              resizeToAvoidBottomInset: scaffoldProperties.resizeBottom,
              tabBuilder: (BuildContext context, index) {
                return _tabs[index];
              }),
        );
      }),
    );
  }

  void onTap(int tappedIndex) {
    if (activeIndex == tappedIndex) {
      _tabs[_tabController.index]
          .navigatorKey
          ?.currentState
          ?.popUntil(ModalRoute.withName("/"));
    }
    tabStack.remove(tappedIndex);
    tabStack.add(tappedIndex);
    _tabController.index = tappedIndex;
    activeIndex = tappedIndex;
    BuildContext? _context =
        _tabs[_tabController.index].navigatorKey?.currentContext;
    if (_context != null) {
      BlocProvider.of<MyScaffoldBloc>(context).add(MyScaffoldEvent(
          getScaffoldPropertiesFromRouteName(
              ModalRoute.of(_context)?.settings.name, _tabController.index)));
    } else {
      BlocProvider.of<MyScaffoldBloc>(context).add(MyScaffoldEvent(
          getScaffoldPropertiesFromRouteName(getRouteName(), _tabController.index)));
    }
  }

  Future<bool> _onWillPop() async {
    bool canPop =
        _tabs[_tabController.index].navigatorKey?.currentState?.canPop() ??
            false;
    bool willPop = false;
    if (!canPop) {
      if (tabStack.length > 1) {
        tabStack.remove(_tabController.index);
        setState(() {
          _tabController.index = tabStack.last;
        });
        activeIndex = _tabController.index;
      } else {
        willPop = true;
      }
    } else {
      _tabs[_tabController.index].navigatorKey?.currentState?.pop();
    }
    BlocProvider.of<MyScaffoldBloc>(context).add(MyScaffoldEvent(
        getScaffoldPropertiesFromRouteName(
            ModalRoute.of(
                    _tabs[_tabController.index].navigatorKey!.currentContext!)
                ?.settings
                .name,
            _tabController.index)));
    print(
        "current route ${ModalRoute.of(_tabs[_tabController.index].navigatorKey!.currentContext!)?.settings.name}");
    return willPop;
  }

  String getRouteName() {
    BuildContext? context =
        _tabs[_tabController.index].navigatorKey?.currentContext;
    String? route;
    if (context != null) {
      route = ModalRoute.of(context)?.settings.name;
    }
    if (route == null || route == "/") {
      route = getRouteNameFromRoutePages(_tabController.index);
    }
    return route;
  }
}
