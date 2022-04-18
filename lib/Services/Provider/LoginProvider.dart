import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_flutter/Services/Provider/UtilityProvider.dart';
import '../../screens/LoginScreen.dart';
class LoginProvider with ChangeNotifier {
  String _email = "";
  String _userName = "";
  String _pwd = "";

  String get getEmail => _email;

  String get getUserName => _userName;

  String get getPwd => _pwd;
  SharedPreferences? userLoginStatus;

  String? validatePwdStructure(String? value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    if (value!.isNotEmpty) {
      if(value.length>=8){

      if (!regExp.hasMatch(value)) {
        return "password isn't valid";
      }
      return null;}

      else{
        return "Password Length should be more than 8 characters";
      }}
    else {
      return "Password shouldn't be empty";
    }
  }

  String? validateEmailStructure(String? value) {
    if (EmailValidator.validate(value!)) {
      return null;
    } else {
      return "Email isn't valid";
    }
  }

  Future signInUser(
      String email, String pwd, String name, BuildContext context) async {
    _userName = name;
    _email = email;
    _pwd = pwd;

    notifyListeners();
  }

  Future<bool?> userGetLoginCheck() async {
    userLoginStatus = await SharedPreferences.getInstance();
    return userLoginStatus?.getBool(
      "loginStatus"
    );

  }

  Future userSetLoginCheck(bool value) async {
    userLoginStatus = await SharedPreferences.getInstance();
    userLoginStatus?.setBool("loginStatus", value);

    await userGetLoginCheck();
    notifyListeners();
  }

  userNavigationStatus(BuildContext context) async {
    if (await userGetLoginCheck() == true) {
      await UtilityProvider().fingerPrintStatus(context);}

    else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));

    }
  }
}
