

import 'dart:io';
import 'package:flutter/material.dart';


class Helpers{

  static Future<bool> isInternetAvailable() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        //TOAST
        return false;
      }
    } on SocketException catch (_) {
      //TOAST
      return false;
    }
  }
}