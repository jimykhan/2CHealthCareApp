import 'package:flutter/material.dart';
import 'package:twochealthcare/common_widgets/check_button.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';

class IsChallengeChecked extends StatelessWidget {
  Function() pressChecked;
  bool isChecked;
  String? challengeName;
   IsChallengeChecked({required this.isChecked,this.challengeName,required this.pressChecked,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomCheckButton(isChecked: true,
            ontap: pressChecked,),
          ApplicationSizing.horizontalSpacer(),
          Text(challengeName??"Transportation",style: Styles.PoppinsRegular(
              fontSize: ApplicationSizing.fontScale(13),
              color: fontGrayColor
          ),)
        ],
      ),
    );
  }
}
