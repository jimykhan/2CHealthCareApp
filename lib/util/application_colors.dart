import 'dart:math';

import 'package:flutter/cupertino.dart';

Color appColor = Color(0xff4EAF48);
Color appColorSecondary = Color(0xff134389);
Color drawerColor = Color(0xff27373D);
Color drawerSelectMenuColor = Color(0xff3D5860);
Color disableColor = Color(0xffdddddd);
Color whiteColor = Color(0xffffffff);
Color errorColor = Color(0xffff0000);
Color backGroundColor = Color(0xffEDEDED);
Color darkColor = Color(0xff033E71);
Color AppBarStartColor = Color(0xff134389);
Color AppBarEndColor = Color(0xff4EAF48);
Color fontGrayColor = Color(0xff939393);

Color randomColorPick(){

  Color randomColor = Color(0xff4EAF48);
  List<Color> allColor = [
    Color(0xffFF3E39),
    Color(0xffEF831F),
    Color(0xff18A9C9),
    appColor,
    appColorSecondary,
    drawerColor,
    drawerSelectMenuColor,
    errorColor,
    darkColor,
    AppBarEndColor,
    AppBarStartColor,
  ];
  Random random = new Random();
  int randomNumber = random.nextInt(allColor.length);

  for(int i = 0; i <= allColor.length; i++){
    if(randomNumber == i){
      randomColor = allColor[i];
    }
  }


  return randomColor;
}