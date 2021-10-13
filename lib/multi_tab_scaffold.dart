import 'package:cupertino_nav/util/scaffold_properties.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/my_scaffold_bloc.dart';

class NamedWidget {
  final String routeName;
  final Widget page;

  const NamedWidget({required this.routeName, required this.page});
}

class MultiTabScaffold extends StatelessWidget {
  const MultiTabScaffold(
      {Key? key,
      required this.pages,
      required this.items,
      required this.onGenerateRoute,
      this.getScaffoldPropertiesFromRouteName,
      this.navigatorObservers})
      : super(key: key);

  final List<NamedWidget> pages;
  final List<BottomNavigationBarItem> items;
  final CupertinoPageRoute<dynamic> Function(RouteSettings) onGenerateRoute;
  final ScaffoldProperties Function(String? routeName)?
      getScaffoldPropertiesFromRouteName;
  final List<NavigatorObserver>? navigatorObservers;

  @override
  Widget build(BuildContext context) => BlocProvider(
      create: (context) => MyScaffoldBloc(),
      child: _MultiTabScaffold(
        pages: pages,
        items: items,
        onGenerateRoute: (settings) {
          final route = onGenerateRoute(settings);
          return CupertinoPageRoute(
              builder: route.builder,
              title: route.title,
              settings: route.settings.copyWith(name: settings.name),
              maintainState: route.maintainState,
              fullscreenDialog: route.fullscreenDialog);
        },
        getScaffoldPropertiesFromRouteName:
            getScaffoldPropertiesFromRouteName ??
                (_) => ScaffoldProperties(title: ""),
        navigatorObservers: navigatorObservers ?? [],
      ));
}

class _MultiTabScaffold extends StatefulWidget {
  const _MultiTabScaffold(
      {Key? key,
      required this.pages,
      required this.items,
      required this.onGenerateRoute,
      required this.getScaffoldPropertiesFromRouteName,
      required this.navigatorObservers})
      : super(key: key);
  final List<NamedWidget> pages;
  final List<BottomNavigationBarItem> items;
  final CupertinoPageRoute<dynamic> Function(RouteSettings) onGenerateRoute;
  final ScaffoldProperties Function(String? routeName)
      getScaffoldPropertiesFromRouteName;
  final List<NavigatorObserver> navigatorObservers;

  @override
  _MultiTabScaffoldState createState() => _MultiTabScaffoldState();
}

class _MultiTabScaffoldState extends State<_MultiTabScaffold> {
  final List<CupertinoTabView> _tabs = [];
  final Set<int> _tabStack = {};
  final CupertinoTabController _tabController = CupertinoTabController();
  late ScaffoldProperties Function(String? routeName)
      _getScaffoldPropertiesFromRouteName;
  int _activeIndex = 0;

  @override
  void initState() {
    _getScaffoldPropertiesFromRouteName =
        widget.getScaffoldPropertiesFromRouteName;
    for (var element in widget.pages) {
      _tabs.add(CupertinoTabView(
        navigatorKey: GlobalKey<NavigatorState>(),
        builder: (context) => element.page,
        onGenerateRoute: (settings) {
          final CupertinoPageRoute route = widget.onGenerateRoute(settings);
          BuildContext? _context =
              _tabs[_tabController.index].navigatorKey?.currentContext;
          final x = ModalRoute.of(_context ?? context)?.settings.name;
          BlocProvider.of<MyScaffoldBloc>(context).add(MyScaffoldEvent(
              _getScaffoldPropertiesFromRouteNameAndFunction(settings.name,
                  _tabController.index, _getScaffoldPropertiesFromRouteName)));
          return route;
        },
        navigatorObservers: widget.navigatorObservers,
      ));
    }
    _tabStack.add(0);
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
          scaffoldProperties = _getScaffoldPropertiesFromRouteNameAndFunction(
              _getRouteName(),
              _tabController.index,
              _getScaffoldPropertiesFromRouteName);
        }
        return CupertinoPageScaffold(
          navigationBar:
              CupertinoNavigationBar(middle: Text(scaffoldProperties.title)),
          child: CupertinoTabScaffold(
              controller: _tabController,
              tabBar: CupertinoTabBar(
                onTap: _onTap,
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

  void _onTap(int tappedIndex) {
    if (_activeIndex == tappedIndex) {
      _tabs[_tabController.index]
          .navigatorKey
          ?.currentState
          ?.popUntil(ModalRoute.withName("/"));
    }
    _tabStack.remove(tappedIndex);
    _tabStack.add(tappedIndex);
    _tabController.index = tappedIndex;
    _activeIndex = tappedIndex;
    BuildContext? _context =
        _tabs[_tabController.index].navigatorKey?.currentContext;
    if (_context != null) {
      print("iscurrent ${ModalRoute.of(_context)?.settings}");
      BlocProvider.of<MyScaffoldBloc>(context).add(MyScaffoldEvent(
          _getScaffoldPropertiesFromRouteNameAndFunction(
              ModalRoute.of(_context)?.settings.name,
              _tabController.index,
              _getScaffoldPropertiesFromRouteName)));
    } else {
      BlocProvider.of<MyScaffoldBloc>(context).add(MyScaffoldEvent(
          _getScaffoldPropertiesFromRouteNameAndFunction(_getRouteName(),
              _tabController.index, _getScaffoldPropertiesFromRouteName)));
    }
  }

  Future<bool> _onWillPop() async {
    bool canPop =
        _tabs[_tabController.index].navigatorKey?.currentState?.canPop() ??
            false;
    bool willPop = false;
    if (!canPop) {
      if (_tabStack.length > 1) {
        _tabStack.remove(_tabController.index);
        setState(() {
          _tabController.index = _tabStack.last;
        });
        _activeIndex = _tabController.index;
      } else {
        willPop = true;
      }
    } else {
      _tabs[_tabController.index].navigatorKey?.currentState?.pop();
    }
    BlocProvider.of<MyScaffoldBloc>(context).add(MyScaffoldEvent(
        _getScaffoldPropertiesFromRouteNameAndFunction(
            ModalRoute.of(
                    _tabs[_tabController.index].navigatorKey!.currentContext!)
                ?.settings
                .name,
            _tabController.index,
            _getScaffoldPropertiesFromRouteName)));
    return willPop;
  }

  String _getRouteName() {
    BuildContext? context =
        _tabs[_tabController.index].navigatorKey?.currentContext;
    String? route;
    if (context != null) {
      route = ModalRoute.of(context)?.settings.name;
    }
    if (route == null || route == "/") {
      route = _getRouteNameFromRoutePages(_tabController.index);
    }
    return route;
  }

  ScaffoldProperties _getScaffoldPropertiesFromRouteNameAndFunction(
      String? route, int index, Function(String? route) defaultFunction) {
    if (route == "/") {
      return _getScaffoldPropertiesFromRoutePages(index);
    }
    return defaultFunction(route);
  }

  String _getRouteNameFromRoutePages(int index) {
    return widget.pages[index].routeName;
  }

  ScaffoldProperties _getScaffoldPropertiesFromRoutePages(int index) {
    return _getScaffoldPropertiesFromRouteNameAndFunction(
        _getRouteNameFromRoutePages(index),
        index,
        _getScaffoldPropertiesFromRouteName);
  }
}
