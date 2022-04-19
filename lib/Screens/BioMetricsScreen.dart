import 'package:flutter/material.dart';
import '../Services/LocalAuth.dart';

class BiometricScreen extends StatefulWidget {
  const BiometricScreen({Key? key}) : super(key: key);

  @override
  _BiometricScreenState createState() => _BiometricScreenState();
}

class _BiometricScreenState extends State<BiometricScreen> {
  checkAuthGo(BuildContext context) async {
    if (await LocalAuth.canCheckBiometrics() == true) {
     await LocalAuth.authenticate(context);
    }
  }

  @override
  void initState() {
    checkAuthGo(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white38, body: Container());
  }
}
