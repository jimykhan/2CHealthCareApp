import 'dart:math';
import 'package:flutter/material.dart';

class ApplicationSizing {
  static var guidelineBaseWidth = 360;
  static var guidelineBaseHeight = 752;

  static var shortDimension;
  static var longDimension;
  static var textScale;
  static var width;
  static var height;

   ApplicationSizing(context) {
     width = MediaQuery.of(context).size.width;
     height = MediaQuery.of(context).size.height;
    textScale = MediaQuery.of(context).textScaleFactor;
      shortDimension = width < height ? width : height;
      longDimension = width < height ? height : width;
  }



  static double fontScale(double size) {
    var f = size * textScale;
    return f;
  }
  static double convert(double n){
    double i = (n)/guidelineBaseHeight;
    return i* longDimension;
  }
  static double convertWidth(double n){
    double i = (n)/guidelineBaseWidth;
    return i* shortDimension;
  }
  static Widget verticalSpacer({double n = 10}){
    return SizedBox(height: convert(n),);
  }
  static Widget horizontalSpacer({double n = 10}){
    return SizedBox(width: convertWidth(n),);
  }

  static double horizontalMargin({double n = 15}){
    return convertWidth(n);
  }

  static double hp(size) {
    return (longDimension * size) / 100;
  }

  double wp(size) {
    return (shortDimension * size) / 100;
  }
}