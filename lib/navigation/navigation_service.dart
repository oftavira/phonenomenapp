import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setUpLocator() {
  locator.registerLazySingleton<AppNavigator>(() => AppNavigator());
}

/// Contiene GlobalKeys para el estado del Scaffold y de la navegacion

class AppNavigator {
  final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
}
