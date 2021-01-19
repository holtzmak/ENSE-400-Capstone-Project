import 'package:flutter/material.dart';

/// [NavigationItem] holds all information when building [BottomNavigationBarItem].
class NavigationItem {
  /// The label content of [BottomNavigationBarItem]
  final String label;

  /// The icon content of [BottomNavigationBarItem]
  final IconData icon;

  /// Screen initial route that will be handled in [onGenerateRoute]
  final String initialRoute;

  /// The route generator for it's inner [Navigator]
  final RouteFactory onGenerateRoute;

  final GlobalKey<NavigatorState> navigatorState;

  NavigationItem({
    this.navigatorState,
    @required this.initialRoute,
    @required this.onGenerateRoute,
    @required this.label,
    @required this.icon,
  });
}
