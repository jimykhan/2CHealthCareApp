import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';

Widget infoWidget(
    {required String widgetTitle, String? key1, String? value1}
  ){
  return Row(
    children: [
      Expanded(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: ApplicationSizing.horizontalMargin()),
          padding: EdgeInsets.only(bottom: ApplicationSizing.convert(10)),
          // width: MediaQuery.of(applicationContext!.currentContext!).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(ApplicationSizing.convert(10)),
            boxShadow:  [
              BoxShadow(
                blurRadius: 5,
                spreadRadius: 2,
                offset: const Offset(0.3,0.3),
                color: fontGrayColor.withOpacity(0.2)
              )
            ]
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: ApplicationSizing.horizontalMargin(),
                      vertical: ApplicationSizing.convert(5)),
                      decoration: BoxDecoration(
                        color: appColorSecondary,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(ApplicationSizing.convert(10)),
                          bottomRight: Radius.circular(ApplicationSizing.convert(10)),
                          topRight: Radius.circular(ApplicationSizing.convert(2)),
                          bottomLeft: Radius.circular(ApplicationSizing.convert(2))
                        )
                      ),
                      child: Text(widgetTitle,
                        style: Styles.PoppinsRegular(
                          fontWeight: FontWeight.w400,
                          fontSize: ApplicationSizing.fontScale(16),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ApplicationSizing.verticalSpacer(n:10),
              key1 != null ? Container(
                padding: EdgeInsets.symmetric(horizontal: ApplicationSizing.horizontalMargin()),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(key1,style: Styles.PoppinsRegular(
                      fontWeight: FontWeight.bold,
                      fontSize: ApplicationSizing.fontScale(14),
                      color: appColorSecondary,
                    ),),
                    Text(value1??"",style: Styles.PoppinsRegular(
                      fontWeight: FontWeight.w400,
                      fontSize: ApplicationSizing.fontScale(12),
                      color: Colors.black,
                    ),),
                  ],
                ),
              ) : Container(),
             ],
          ),
        ),
      ),
    ],
  );
}