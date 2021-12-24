import 'package:flutter/material.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';

class AppBarTextStyle extends StatelessWidget {
  String? text;
  double? textsize;
  Color? textColor;
  AppBarTextStyle({this.text,this.textColor,this.textsize});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        text ?? "",
        style: Styles.PoppinsRegular(
            color: textColor?? Colors.black,
            fontSize: textsize?? ApplicationSizing.fontScale(18)
        ),
        maxLines: 1,
      ),
    );
  }
}
