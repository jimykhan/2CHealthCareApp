import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';

SnackBarMessage({String? message,bool error = true}){
  BotToast.showCustomNotification(
      toastBuilder: (void Function() cancelFunc) {
        return Container(
          // alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: error? errorColor : appColor,
                borderRadius: BorderRadius.circular(10)
            ),
            margin: EdgeInsets.only(
              left: ApplicationSizing.horizontalMargin(),
              right: ApplicationSizing.horizontalMargin(),
              bottom: ApplicationSizing.convert(50),
            ),
            child: Text(message??'',
              style: Styles.PoppinsRegular(fontSize: 12,
              color: Colors.white),
            ));
      },
      align: Alignment.bottomCenter
  );
}