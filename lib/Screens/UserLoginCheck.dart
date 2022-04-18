import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_flutter/Services/Provider/LoginProvider.dart';
import 'package:task_flutter/Services/PushNotificationService.dart';

class UserLoginCheckScreen extends StatefulWidget {
  const UserLoginCheckScreen({Key? key}) : super(key: key);

  @override
  _UserLoginCheckScreenState createState() => _UserLoginCheckScreenState();
}

class _UserLoginCheckScreenState extends State<UserLoginCheckScreen> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        final routeFromMessage = message.data['route'];

        Navigator.pushNamed(context, routeFromMessage);
      }
    });
    PushNotificationService().initilializeNotification(context);
    Future.microtask(() async =>
        await context.read<LoginProvider>().userNavigationStatus(context));
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
