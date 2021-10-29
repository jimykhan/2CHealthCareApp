import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
class AlertLoader extends StatelessWidget {
  const AlertLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Container(
        margin: EdgeInsets.only(bottom: ApplicationSizing.convert(50)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              spreadRadius: 3,
              offset: const Offset(0.0,0.3),
              color: Colors.grey.withOpacity(0.5),
            )
          ]
        ),

        padding:  EdgeInsets.symmetric(horizontal: ApplicationSizing.horizontalMargin()),
        height: ApplicationSizing.convert(70),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoActivityIndicator(
              radius: ApplicationSizing.convert(12),
            ),
             ApplicationSizing.verticalSpacer(),
             Text("Loading",
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