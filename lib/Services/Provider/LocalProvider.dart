import 'package:flutter/cupertino.dart';

import 'UtilityProvider.dart';

class LocalProvider with ChangeNotifier{
  Locale ? _locale;
  Locale get locale => _locale ?? const Locale('en');
  String language = '';
  String selectedLanguage = '';
  Future<void> getLocalLocale() async {
    language = await UtilityProvider().getLocale();
    _locale = Locale(language);
    notifyListeners();
  }
  void updateSelectedLanguage(String val) {
    _locale = Locale(val);
    UtilityProvider().setLocale(val);
    selectedLanguage = val;
    notifyListeners();
  }

}