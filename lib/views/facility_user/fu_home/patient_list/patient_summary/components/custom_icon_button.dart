import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';

class CustomIconButton extends StatelessWidget {
  double? width;
  double? height;
  String? text;
  Color? bgColor;
  Color? fontColor;
  Function()? onClick;

  CustomIconButton({this.width,this.height,this.text,this.bgColor,this.fontColor,this.onClick,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        height: height??50,
        width: width??MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            boxShadow: CustomShadow.whiteBoxShadowWith15(dy: 0,dx: 0),
            border: Border.all(
                color: fontGrayColor.withOpacity(0.5),
                width: 1
            ),
            borderRadius: BorderRadius.circular(15),
            color: bgColor??Color(0xffF0F1F5)
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/icons/clock_icon.svg"),
            SizedBox(width: 7,),
            Text(text??"CCM",style: Styles.PoppinsRegular(
                fontWeight: FontWeight.w600,
                fontSize: ApplicationSizing.constSize(16),
                color: fontColor?? appColorSecondary
            ),),
          ],
        ),
      ),
    );
  }
}
