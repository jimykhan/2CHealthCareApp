import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';

class CustomCheckButton extends HookWidget {
  bool isChecked;
  Function() ontap;
  Function(bool)? onOptionReturn;
  String? optionText;
  CustomCheckButton(
      {required this.isChecked, required this.ontap, this.optionText,this.onOptionReturn, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onOptionReturn != null ? () => onOptionReturn!(!isChecked)  : ontap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: isChecked ? appColor : Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: appColor, width: 1),
            ),
            child: isChecked
                ? Center(
                    child: Container(
                      // margin: EdgeInsets.all(1),
                      child: Icon(
                        Icons.check,
                        size: 15,
                        color: Colors.white,
                      ),
                    ),
                  )
                : Container(),
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Text(
              optionText ?? "",
              style: Styles.PoppinsRegular(
                  fontSize: ApplicationSizing.fontScale(13),
                  color: fontGrayColor),
            ),
          )
        ],
      ),
    );
  }
}
