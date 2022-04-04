import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:twochealthcare/main.dart';

openBottomModal({required Widget child}){
  return showMaterialModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: applicationContext!.currentContext!,
      builder: (context) {
        return child;
      }
  );
}

openBottomModalDisableDrag({required Widget child}){
  return showMaterialModalBottomSheet(
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      context: applicationContext!.currentContext!,
      builder: (context) {
        return child;
      }
  );
}