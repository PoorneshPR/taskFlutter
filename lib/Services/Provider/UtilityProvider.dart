import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Screens/HomeScreen.dart';
import '../../generated/l10n.dart';
import '../../screens/BioMetricsScreen.dart';

class UtilityProvider with ChangeNotifier {
  SharedPreferences? pref;
  static const String _tKLanguageCode = "languageCode";

  addMapLocToSP(String titleValue) async {
    SharedPreferences pref;
    pref = await SharedPreferences.getInstance();
    await pref.setString("RecentLocation", titleValue);
    notifyListeners();
  }

  getMapLocToSP() async {
    pref = await SharedPreferences.getInstance();
    String location = '';
    location = pref?.getString("RecentLocation") ??"";
    return location;
  }

  addBoolToSF(bool value) async {
    SharedPreferences pref;
    pref = await SharedPreferences.getInstance();
    await pref.setBool("boolFinger", value);
    notifyListeners();
  }

  getBoolToSF() async {
    pref = await SharedPreferences.getInstance();
    return await pref?.getBool("boolFinger");
  }

  setStringToUserName(String nameValue) async {
    pref = await SharedPreferences.getInstance();
    await pref?.setString("userName", nameValue);
    notifyListeners();
  }

  getStringToUserName() async {
    pref = await SharedPreferences.getInstance();
    return pref?.getString("userName");
  }
  getLocale() async {
    pref= await SharedPreferences.getInstance();
    String languageCode = pref?.getString(_tKLanguageCode) ?? "en";
    return languageCode;
  }
  setLocale(String languageCode) async {
    pref= await SharedPreferences.getInstance();
    pref?.setString(_tKLanguageCode,languageCode);
    print(languageCode);
    return languageCode;
  }

  fingerPrintStatus(BuildContext context) async {
    if (await getBoolToSF() == true) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const BiometricScreen(),
          ));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>const HomeScreen(),
          ));
    }
  }

  Future<bool> showExitPopup(context) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              height: 90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Do you want to exit?"),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            exit(0);
                          },
                          child: const Text("Yes"),
                        ),
                      ),

                      const SizedBox(width: 15),
                      Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("No",
                                style: TextStyle(color: Colors.black)),
                          ))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
