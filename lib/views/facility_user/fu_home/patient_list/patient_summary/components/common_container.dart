import 'package:flutter/material.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
class CommonContainer extends StatelessWidget {
  Function()? onClick;
  double? horizontalPadding;
  Widget child;
  CommonContainer({this.onClick,required this.child,this.horizontalPadding,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding??18,vertical: 10),
        decoration: BoxDecoration(
            boxShadow: CustomShadow.whiteBoxShadowWith15(dy: 0,dx: 0),
            border: Border.all(
                color: fontGrayColor.withOpacity(0.5),
                width: 1
            ),
            borderRadius: BorderRadius.circular(15),
            color: Colors.white
        ),

        child: child,
      ),
    );
  }
}
