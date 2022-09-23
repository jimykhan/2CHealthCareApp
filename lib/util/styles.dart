import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';

class Styles {
  static TextStyle PoppinsBold({

    double fontSize = 30,
    String fontFamily = "PoppinsBold",
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.bold,
  }) {
    return TextStyle(
      height: 1.1,
        letterSpacing: 0,
        fontSize: fontSize,
        fontFamily: fontFamily,
        color: color,
        fontWeight: fontWeight);
  }

  static TextStyle PoppinsRegular(
      {double fontSize = 20,
      String fontFamily = "PoppinsRegular",
      Color color = Colors.black,
      FontWeight fontWeight = FontWeight.normal}) {
    return TextStyle(
        fontSize: fontSize,
        fontFamily: fontFamily,
        color: color,
        fontWeight: fontWeight);
  }

  static TextStyle hintStyle() {
    return PoppinsRegular(
      fontWeight: FontWeight.w600,
      color: fontGrayColor,
      fontSize: ApplicationSizing.constSize(15),
    );
  }
  // hintStyle

  static TextStyle RobotoMedium(
      {double fontSize = 9,
      String fontFamily = "RobotoMedium",
      Color color = Colors.black}) {
    return TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
      color: color,
    );
  }

  static TextStyle RobotoMediumUnderLine(
      {double fontSize = 9,
        String fontFamily = "RobotoMedium",
        Color color = Colors.black}) {
    return TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
      color: color,
      decoration: TextDecoration.underline,
      // decorationThickness: 2

    );
  }

  static TextStyle RobotoThin(
      {double fontSize = 9,
      String fontFamily = "RobotoThin",
      Color color = Colors.black}) {
    return TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
      color: color,
    );
  }

  static BoxDecoration boxDecoveraton({int isPaired = 0}) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: isPaired == 1 ? Colors.white : Colors.white60,
        boxShadow: [
          BoxShadow(
              // color: Color(0xff00000029),
              color: Colors.grey.shade200,
              offset: Offset(0, 1),
              blurRadius: 10,
              spreadRadius: 1)
        ]);
  }
}

class CustomShadow{

  static List<BoxShadow> whiteBoxShadowWith15({int isPaired = 0,double? dy,double? dx}) {
    return [
      BoxShadow(
          color: Colors.black.withOpacity(0.15),
          blurRadius: 10,
          spreadRadius: 0,
          offset: Offset(dx??0,dy??15)
      )
    ];
  }

}
