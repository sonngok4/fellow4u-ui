import 'package:flutter/material.dart';

abstract class NavigationService {
  GlobalKey<NavigatorState> get navigatorKey;

  Future<dynamic> navigateTo(String routeName, {dynamic arguments});
  Future<dynamic> navigateToAndRemoveUntil(String routeName,
      {dynamic arguments});
  Future<dynamic> navigateToAndReplace(String routeName, {dynamic arguments});
  void goBack([dynamic result]);
  bool canGoBack();
}

class NavigationServiceImpl implements NavigationService {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  @override
  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return _navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  @override
  Future<dynamic> navigateToAndRemoveUntil(String routeName,
      {dynamic arguments}) {
    return _navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (Route<dynamic> route) => false,
      arguments: arguments,
    );
  }

  @override
  Future<dynamic> navigateToAndReplace(String routeName, {dynamic arguments}) {
    return _navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  @override
  void goBack([dynamic result]) {
    if (canGoBack()) {
      _navigatorKey.currentState!.pop(result);
    }
  }

  @override
  bool canGoBack() {
    return _navigatorKey.currentState!.canPop();
  }
}
