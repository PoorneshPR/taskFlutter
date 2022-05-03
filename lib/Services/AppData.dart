

class AppData{
  static final AppData _instance = AppData._internal();
  factory AppData() => _instance;
  AppData._internal();

  // STAGING URL
  static String baseUrl = "https://run.mocky.io/v3/";

}