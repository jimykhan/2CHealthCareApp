import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';

AlertMessage(context,{String? message,Function()? onConfirm,String? confirmText, String? ignoreText}){
  showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('Application Update!',style: Styles.PoppinsBold(fontSize: ApplicationSizing.fontScale(14)),),
          content: Text(message??'Do you really want to delete?',style: Styles.PoppinsRegular(fontSize: ApplicationSizing.fontScale(13)),),
          actions: <Widget>[
            TextButton(
                onPressed: onConfirm,
                child: Text(confirmText??'Yes')),
            TextButton(
              onPressed: () {
                Navigator.pop(context); //close Dialog
              },
              child: Text(ignoreText??'Later'),
            )
          ],
        );
      }
  );
}