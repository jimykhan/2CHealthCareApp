import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';

CustomAlertDialog({String? message}) {
  showDialog(
    context: applicationContext!.currentContext!,

    builder: (BuildContext context) {
      // return object of type Dialog
      return Scaffold(

        // color: Colors.transparent,
        backgroundColor: Colors.transparent,
        body: Container(
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: ApplicationSizing.horizontalMargin()),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
                color: Colors.white
            ),
            padding: EdgeInsets.all(
              ApplicationSizing.convert(10)
            ),
            // height: ApplicationSizing.convert(100),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        width: 60,
                        height: 60,
                        decoration:  BoxDecoration(
                          color: Color(0xff116DDA),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle
                            ),
                            child: SvgPicture.asset("assets/icons/i.svg")),
                      ),
                      ApplicationSizing.horizontalSpacer(),
                      Text(message??"",
                        style: Styles.PoppinsRegular(
                            color: Color(0xff4F5153),
                            fontSize: ApplicationSizing.fontScale(20)
                        ),)
                    ],
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Icon(IcoFontIcons.close),
                    ),
                  )
                ],
              ),
          ),
        ),
      );
    },
  );
}