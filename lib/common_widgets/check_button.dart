import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:twochealthcare/util/application_colors.dart';

class CustomCheckButton extends HookWidget {
  bool isChecked;
   CustomCheckButton({required this.isChecked,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: isChecked ? appColor : Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: appColor,
          width: 1
        ),
      ),
      child: isChecked ? Center(
        child: Container(
          // margin: EdgeInsets.all(1),
          child: Icon(Icons.check,
          size: 15,
          color: Colors.white,),
        ),
      ) : Container(),
    );
  }
}
