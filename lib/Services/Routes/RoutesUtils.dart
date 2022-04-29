import 'package:flutter/material.dart';
import 'package:task_flutter/Models/ContactsModel.dart';

import 'Arguments.dart';
import 'RouteNames.dart';

class RoutesUtils {
  static navToHome(BuildContext context) {
    Navigator.pushNamed(
      context,
      RouteNames.homeRoute,
    );
  }

  static navToNotify(BuildContext context) {
    Navigator.pushNamed(
      context,
      RouteNames.notifyScreenRoute,
    );
  }

  static navToAboutUser(BuildContext context, {Arguments? userContacts}) {
    Navigator.of(context,rootNavigator: true).pushNamed( RouteNames.aboutScreen, arguments: userContacts);
  }

  ///userLoginStatusScreen
  static navToUserLogCheck(BuildContext context) {
    Navigator.pushReplacementNamed(
      context,
      RouteNames.userLogCheck,
    );
  }

  static navToLoginScreen(BuildContext context) {
    Navigator.pushReplacementNamed(
      context,
      RouteNames.loginScreen,
    );
  }
}
