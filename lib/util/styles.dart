import 'package:flutter/material.dart';

class Styles {
  static TextStyle PoppinsBold(
      {double fontSize = 30,
        String fontFamily = "PoppinsBold",
        Color color = Colors.black,
        FontWeight fontWeight = FontWeight.bold
      }) {
    return TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
      color: color,
      fontWeight: fontWeight
    );
  }

  static TextStyle PoppinsRegular(
      {double fontSize = 20,
        String fontFamily = "PoppinsRegular",
        Color color = Colors.black,
        FontWeight fontWeight = FontWeight.normal
      }) {
    return TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
      color: color,
      fontWeight: fontWeight
    );
  }

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