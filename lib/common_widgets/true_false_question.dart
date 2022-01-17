import 'package:flutter/material.dart';
import 'package:twochealthcare/common_widgets/radio-button.dart';
import 'package:twochealthcare/common_widgets/toggle_button.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';

class TrueFalseQuestion extends StatelessWidget {
  Function() pressYes;
  Function() pressNo;
  bool isChecked;
  String? challengeName;
  TrueFalseQuestion({required this.isChecked,this.challengeName,required this.pressYes,required this.pressNo,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                RadioButton(buttonSelected: isChecked, onchange: pressYes,
                  disableText: false,),
                Text("Yes",style: Styles.PoppinsRegular(
                    fontSize: ApplicationSizing.fontScale(13),
                    color: fontGrayColor
                ),)
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                RadioButton(buttonSelected: !isChecked, onchange: pressNo,
                disableText: false,),
                Text("No",style: Styles.PoppinsRegular(
                    fontSize: ApplicationSizing.fontScale(13),
                    color: fontGrayColor
                ),)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
