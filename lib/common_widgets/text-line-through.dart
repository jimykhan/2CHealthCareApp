import 'package:flutter/material.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';

class TextLineThrough extends StatelessWidget {
  String? text;
  bool disableText = true;
  double? LineWidth;
  double? LineHight;
  TextStyle? style;
  TextLineThrough(
      {this.text, required this.disableText, this.LineHight, this.LineWidth,this.style});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Text(text ?? "no text",
              overflow: TextOverflow.clip,
              style: style?? Styles.PoppinsRegular(
                fontSize: ApplicationSizing.fontScale(15),
                fontFamily: "RobotoRegular",
              )),
          disableText
              ? Container(
                  width: LineWidth ?? ApplicationSizing.convertWidth(10),
                  height: LineHight ?? ApplicationSizing.convert(2),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
