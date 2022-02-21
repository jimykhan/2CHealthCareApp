import 'package:flutter/material.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';

class HeadLineTextStyle extends StatelessWidget {
  String? text;
  HeadLineTextStyle({this.text,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(text??"",
      style: Styles.PoppinsRegular(
          fontSize: ApplicationSizing.constSize(20),
          fontWeight: FontWeight.w600,
          color: Colors.black
      ),),
    );
  }
}
