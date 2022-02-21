import 'package:flutter/material.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';

class TextFieldTitle extends StatelessWidget {
  String title;
  TextFieldTitle({Key? key,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Text(title,style: Styles.PoppinsRegular(
        fontWeight: FontWeight.w600,
        color: fontGrayColor,
        fontSize: ApplicationSizing.constSize(15),
      ),),
    );
  }
}
