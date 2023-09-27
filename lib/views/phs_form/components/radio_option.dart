import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';

class RadioOption extends HookWidget {
  bool isChecked;
  Function() ontap;
  String? optionText;
  RadioOption({required this.isChecked, required this.ontap,this.optionText, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: isChecked ? appColor : Colors.white,
              
              border: Border.all(color: appColor, width: 1),
              shape: BoxShape.circle,
            ),
            child: isChecked
                ? Center(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(

                        color: appColor,
                        shape: BoxShape.circle
                      ),
                      // margin: EdgeInsets.all(1),
                      
                    ),
                  )
                : Container(),
          ),

          Container(
            margin: EdgeInsets.only(left: 10),
            child: Text(
              optionText??"",
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
