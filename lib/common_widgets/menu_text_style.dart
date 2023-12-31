import 'package:flutter/material.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';

class MenuTextStyle extends StatelessWidget {
  String? text;
  Color? color;
  double? fontSize;
  bool isPadding;
  MenuTextStyle({this.text,this.color,this.fontSize,this.isPadding = true});
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
       margin: !isPadding ? const EdgeInsets.only(top: 0,left: 0)  : const EdgeInsets.only(left: 10),
      // padding: const EdgeInsets.only(top: 4),
      child: Text(
        text ?? "",
        style: Styles.PoppinsRegular(
            color: color?? appColor,
            fontSize: fontSize ?? ApplicationSizing.fontScale(15),
            fontWeight: FontWeight.w400
        ),
      ),
    );
  }
}
