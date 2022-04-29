import 'package:flutter/material.dart';
import 'package:task_flutter/Screens/LoginScreen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:task_flutter/Services/Routes/Arguments.dart';

import '../../Models/ContactsModel.dart';
import '../../Screens/AboutUser.dart';
import '../../Screens/HomeScreen.dart';
import '../../Screens/NotifyScreen.dart';
import '../../Screens/UserLoginCheck.dart';
import 'RouteNames.dart';

class RoutesServices{
  Route? generateRouteServices(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.homeRoute:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case RouteNames.notifyScreenRoute:
        return MaterialPageRoute(
          builder: (context) => const NotifyScreen(),
        );
      case RouteNames.aboutScreen:

        Arguments? userContacts = settings.arguments as Arguments;
        return MaterialPageRoute(
          builder: (context) => AboutUser(userContacts: userContacts.userContacts),
        );
      case RouteNames.userLogCheck:
        return MaterialPageRoute(
          builder: (context) => const UserLoginCheckScreen(),
        );
      case RouteNames.loginScreen:
        return MaterialPageRoute(
          builder: (context) => LoginScreen(),
        );
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }

  }
}