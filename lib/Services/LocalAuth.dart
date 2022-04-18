import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:task_flutter/screens/HomeScreen.dart';

class LocalAuth {
  static final localAuthenticate = LocalAuthentication();

  // list of finger print added in local device settings
  static Future<bool> authenticate(BuildContext context) async {
    bool isAuth;
    try {
      isAuth = await localAuthenticate.authenticate(
          localizedReason: "Scan FingerPrint to Authenticate",
          biometricOnly: true,
          useErrorDialogs: true,
          stickyAuth: true);
      if (isAuth == true) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>   const HomeScreen(),
            ));

      }
      return isAuth;
    } on PlatformException catch (e) {
      return false;
    }
  }

  static Future<bool> canCheckBiometrics(BuildContext context) async {
    bool hasBiometric;
    try {
      hasBiometric = await localAuthenticate.canCheckBiometrics;
      if (hasBiometric) {
        await authenticate(context);
      }
      return hasBiometric;
    } on PlatformException catch (e) {
      return false;
    }
  }
}
