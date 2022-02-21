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