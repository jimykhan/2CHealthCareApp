import 'package:flutter/material.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
class ErrorText extends StatelessWidget {
  String text;
  ErrorText({Key? key,required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
      style: Styles.PoppinsRegular(
        fontSize: ApplicationSizing.fontScale(10),
        color: errorColor
      ),
    );
  }
}
