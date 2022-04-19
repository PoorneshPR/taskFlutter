import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:task_flutter/screens/HomeScreen.dart';

class LocalAuth {
  static final localAuthenticate = LocalAuthentication();

  // list of finger print added in local device settings
  static Future<void> authenticate(BuildContext context) async {
    bool isAuth;
    try {
      isAuth = await localAuthenticate.authenticate(
          localizedReason: "Scan FingerPrint to Authenticate",
          biometricOnly: true,
          useErrorDialogs: true,
          stickyAuth: true);
      if (isAuth == true) {
        //TODO
        //Use named routes
        Navigator.pushNamed(
            context,
           'home');
      }

    } on PlatformException catch (e) {
     debugPrint(e.message.toString());
    }
  }

  static Future<bool> canCheckBiometrics() async {
    bool hasBiometric;
    try {
      hasBiometric = await localAuthenticate.canCheckBiometrics;
      return hasBiometric;
    } on PlatformException catch (e) {
      debugPrint(e.message.toString());
      return false;
    }
  }
}
