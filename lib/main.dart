import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_flutter/Screens/HomeScreen.dart';
import 'package:task_flutter/screens/NotifyScreen.dart';
import 'package:task_flutter/Screens/UserLoginCheck.dart';
import 'package:task_flutter/Services/Provider/AuthenticationProvider.dart';
import 'package:task_flutter/Services/Provider/DbProvider.dart';
import 'package:task_flutter/Services/Provider/LoginProvider.dart';
import 'package:task_flutter/Services/Provider/UtilityProvider.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

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
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',

      home: AnimatedSplashScreen(
          duration: 3000,
          splash: Image.asset("assets/dart_icon.png", fit: BoxFit.fitHeight),
          nextScreen: const HomeScreen(),
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Colors.white),
      //    home:HomeScreen()
      routes: {"red": (_) => const NotifyScreen(),
   "home": (_) => const HomeScreen(),},
    );
  }
}
