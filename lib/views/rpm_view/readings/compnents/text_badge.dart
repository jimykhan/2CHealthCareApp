import 'package:flutter/material.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/styles.dart';

class TextBadge extends StatelessWidget {
  String? text;
   TextBadge({this.text,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
      decoration: BoxDecoration(
        color: appColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(text??"",style: Styles.PoppinsRegular(color: whiteColor),),
    );
  }
}
