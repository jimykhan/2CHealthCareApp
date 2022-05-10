import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
class CollapsibleContainer extends StatelessWidget {
  Function(bool isCollaps,int Index) IsCollaps;
  bool isExpand;
  Widget child;
  String? title;
  int Index;
  CollapsibleContainer({required this.IsCollaps,required this.isExpand,required this.child,this.title,required this.Index,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  AnimatedContainer(
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 22),
          decoration: BoxDecoration(
              color: Color(0xffF0F1F5),
              border: Border.all(
                  color: Color(0xffD2D2D2),
                  width: 1
              ),
              borderRadius: BorderRadius.circular(10)
          ),
          duration: Duration(seconds: 1),
          child: Column(
            children: [
              InkWell(
                onTap: ()=> IsCollaps(isExpand,Index),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(title??"",
                          style: Styles.PoppinsBold(
                              fontSize: ApplicationSizing.constSize(18),
                              fontWeight: FontWeight.w700,
                              color: appColor
                          ),
                        ),
                      ),
                      RotatedBox(
                      quarterTurns: !isExpand ? 0 : 2,
                          child: SvgPicture.asset("assets/icons/arrow_down.svg",color: appColor,)),
                    ],
                  ),
                ),
              ),
              !isExpand ? AnimatedContainer(
                duration: Duration(seconds: 1),
                color: Colors.red,
                height: 0,
              ) : AnimatedContainer(
                duration: Duration(seconds: 1),
                child: child,
              ),
            ],
          )
      );
  }
}
