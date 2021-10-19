import 'package:flutter/material.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';

class MenuTextStyle extends StatelessWidget {
  String? text;
  Color? color;
  MenuTextStyle({this.text,this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            text ?? "",
            style: Styles.RobotoMedium(
              color: color??Color(0xff134389),
              fontSize: ApplicationSizing.fontScale(15),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: ApplicationSizing.convert(5),
                bottom: ApplicationSizing.convert(15)),
            height: ApplicationSizing.convert(1),
            color: Colors.white.withOpacity(0.3),
          ),
        ],
      ),
    );
  }
}
