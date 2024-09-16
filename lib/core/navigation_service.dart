import 'package:flutter/material.dart';

class NavigationService 
{
  final GlobalKey<NavigatorState> _navigatorKey;
  NavigationService(this._navigatorKey);
  NavigatorState get navigator => _navigatorKey.currentState!;
  BuildContext get context => _navigatorKey.currentContext!;

  back<T extends Object?>([T? result]) => navigator.pop(result);

  clearStackAndNavigateTo(String route, [Object? arguments]) =>
      navigator.pushNamedAndRemoveUntil(
        route,
        (_) => false,
        arguments: arguments,
      );

  replace(String route, [Object? arguments]) => navigator.pushReplacementNamed(
        route,
        arguments: arguments,
      );

  to(String route, [Object? arguments]) => navigator.pushNamed(
        route,
        arguments: arguments,
      );
}
