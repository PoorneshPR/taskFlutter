import 'package:flutter/material.dart';

import '../generated/l10n.dart';

class NotifyScreen extends StatefulWidget {
  const NotifyScreen({Key? key}) : super(key: key);

  @override
  _NotifyScreenState createState() => _NotifyScreenState();
}

class _NotifyScreenState extends State<NotifyScreen> {
  @override
  Widget build(BuildContext context) {
    final translated = S.of(context);
    return  Scaffold(
      body: Center(child: Text(translated.NotifyMessage)),
    );
  }
}
