import 'package:flutter/material.dart';
import 'package:task_flutter/screens/UserLoginCheck.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserLoginCheckScreen(),));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 130,
            width: 100,
            child: Image.asset("assets/dart_icon.png",fit: BoxFit.fitHeight),
          ),
          const Center(
              child: Text(
            "TaskFlutter",
            style: TextStyle(fontSize: 25, color: Colors.teal,fontStyle: FontStyle.italic),
          ))
        ],
      ),
    );
  }
}
