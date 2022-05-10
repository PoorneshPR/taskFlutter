import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_flutter/utils/hexcolors.dart';

class FontStyle{
  static TextStyle grey14Medium =  TextStyle(
      fontSize: 14, fontWeight: FontWeight.w600, color: HexColors("#727272"));
      static TextStyle black14Medium =  TextStyle(
      fontSize: 14, fontWeight: FontWeight.w500, color: HexColors("#090909"));
  static TextStyle blackofferPriceProduct15Medium=const TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w700);
  static TextStyle greyPriceProduct12Medium=TextStyle(color: HexColors("#727272"),fontSize: 12,fontWeight: FontWeight.w500,decoration: TextDecoration.lineThrough);
  static TextStyle black13medium = const TextStyle(
      fontSize: 13, fontWeight: FontWeight.w400, color: Colors.black);
  static TextStyle white10medium = const TextStyle(
      fontSize: 10, fontWeight: FontWeight.w500, color: Colors.white);
  static TextStyle grey12Regular = TextStyle(
      fontSize: 12, fontWeight: FontWeight.w400, color: HexColors('#767676'));
  static TextStyle black15Bold = TextStyle(
      fontSize: 15, fontWeight: FontWeight.bold, color: HexColors("#111111"));
}