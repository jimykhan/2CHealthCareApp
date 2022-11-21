import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';

class AlertLoader extends StatelessWidget {
  double bottomMargin;
  AlertLoader({this.bottomMargin = 50,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.3),
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Container(
        margin: EdgeInsets.only(bottom: ApplicationSizing.convert(bottomMargin)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                spreadRadius: 3,
                offset: const Offset(0.0, 0.3),
                color: Colors.grey.withOpacity(0.5),
              )
            ]),
        width: ApplicationSizing.fontScale(80),
        height: ApplicationSizing.fontScale(80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoActivityIndicator(
              radius: 12,
            ),
            ApplicationSizing.verticalSpacer(),
            Text(
              "Loading",
              style: Styles.PoppinsRegular(
                fontSize: ApplicationSizing.fontScale(12),
                color: fontGrayColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SimpleLoader extends StatelessWidget {
  Color? color;
   SimpleLoader({this.color,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CupertinoActivityIndicator(
        radius: 12,
        color: color?? appColor,
      ),
    );
  }
}
