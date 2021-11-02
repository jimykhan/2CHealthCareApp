import 'package:flutter/material.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';

SnackBarMessage({String? message,bool error = true}){
  ScaffoldMessenger.of(applicationContext!.currentContext!).showSnackBar(
    SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      content: Container(
        // alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: error? errorColor : appColor,
          borderRadius: BorderRadius.circular(10)
        ),
        margin: EdgeInsets.only(
          left: ApplicationSizing.horizontalMargin(),
          right: ApplicationSizing.horizontalMargin(),
          bottom: ApplicationSizing.convert(10),
        ),
          child: Text(message??'')),
    ),
  );
  // ScaffoldMessenger.of(applicationContext!.currentContext!).dispose();
  // Future.delayed(const Duration(seconds: 3),()=> ScaffoldMessenger.of(applicationContext!.currentContext!).dispose());

}