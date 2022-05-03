import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:task_flutter/Screens/HomeScreen.dart';
import 'package:task_flutter/Screens/UserLoginCheck.dart';
import 'package:task_flutter/Services/Provider/AuthenticationProvider.dart';
import 'package:task_flutter/Services/Provider/DbProvider.dart';
import 'package:task_flutter/Services/Provider/LocalProvider.dart';
import 'package:task_flutter/Services/Provider/LoginProvider.dart';
import 'package:task_flutter/Services/Provider/UtilityProvider.dart';
import 'package:task_flutter/Services/Routes/RouteNames.dart';
import 'package:task_flutter/Services/Routes/RoutesServices.dart';
import 'package:task_flutter/Services/Routes/RoutesUtils.dart';
import 'package:task_flutter/screens/NotifyScreen.dart';
import 'Services/Provider/HomeProvider.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<AuthenticationProvider>(
      create: (_) => AuthenticationProvider(),
    ),
    ChangeNotifierProvider<LoginProvider>(
      create: (_) => LoginProvider(),
    ),
    ChangeNotifierProvider<UtilityProvider>(
      create: (_) => UtilityProvider(),
    ),
    ChangeNotifierProvider<DbProvider>(
      create: (_) => DbProvider(),
    ),
    ChangeNotifierProvider<LocalProvider>(
      create: (_) => LocalProvider(),
    ),
    ChangeNotifierProvider<HomeProvider>(
      create: (_) => HomeProvider(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<LocalProvider>(builder: (context, locale, child) =>  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: locale.locale,initialRoute: RouteNames.initialRoute,

      home: AnimatedSplashScreen(
          duration: 3000,
          splash: Image.asset("assets/dart_icon.png", fit: BoxFit.fitHeight),
          nextScreen: const UserLoginCheckScreen(),
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Colors.white),
      //    home:HomeScreen()
      onGenerateRoute: RoutesServices().generateRouteServices,
    ),
    );
  }
}
