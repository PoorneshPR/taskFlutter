import 'package:flutter/material.dart';
import '../Services/LocalAuth.dart';

class BiometricScreen extends StatefulWidget {
  const BiometricScreen({Key? key}) : super(key: key);

  @override
  _BiometricScreenState createState() => _BiometricScreenState();
}

class _BiometricScreenState extends State<BiometricScreen> {
  checkAuthGo() async {
    if (LocalAuth.canCheckBiometrics(context) == true) {
      LocalAuth.canCheckBiometrics(context);
    }
  }

  @override
  void initState() {
    checkAuthGo();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white38, body: Container());
  }
}
