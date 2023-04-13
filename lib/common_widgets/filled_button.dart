import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class CustomFilledButton extends StatelessWidget {
  Function()? onTap;
  Color? color1;
  Color? txtcolor;
  String? txt;
  double? h;
  double? w;
  double paddingLeftRight;
  Color? borderColor;
  double? borderwidth;
  double? fontsize;
  double? borderRadius;
  String? fontfamily;
  Widget? leftWidget;
  Widget? rigtWidget;

  CustomFilledButton(
      {this.borderColor,
      this.borderwidth,
      this.fontfamily,
      this.color1,
      this.txt,
      this.h,
      this.w,
      this.txtcolor,
      this.fontsize,
      this.leftWidget,
      this.rigtWidget,
      required this.onTap,
        this.borderRadius,
        this.paddingLeftRight = 10,
      });
  @override
  Widget build(BuildContext context) {
    Size size1 = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(right: paddingLeftRight, left: paddingLeftRight),
        height: h ?? ApplicationSizing.convert(50),
        width: w ?? ApplicationSizing.convertWidth(360),
        decoration: BoxDecoration(
            color: color1 ?? appColor,
            borderRadius: BorderRadius.circular(borderRadius??7),
            border: Border.all(
              width: borderwidth ?? 0,
              color: borderColor ?? appColor,
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            leftWidget ?? Container(),
             SizedBox(
              width: paddingLeftRight,
            ),
            Text(
              txt ?? "Empty",
              style: Styles.PoppinsBold(
                  fontSize: fontsize ?? ApplicationSizing.fontScale(16),
                  color: txtcolor??whiteColor),
            ),
             SizedBox(
              width: paddingLeftRight,
            ),
            rigtWidget ?? Container(),
          ],
        ),
      ),
    );
  }
}

// class CustomFilledButtonWithCenterIcon extends StatelessWidget {
//   final Function onTap;
//   Color color1;
//   Color txtcolor;
//   String txt;
//   String SvgIcon;
//   double h;
//   double w;
//   Color borderColor;
//   double borderwidth;
//   double fontsize;
//   String fontfamily;
//   Widget leftWidget;
//   Widget rigtWidget;
//
//   CustomFilledButtonWithCenterIcon(
//       {this.borderColor,
//       this.borderwidth,
//       this.fontfamily,
//       this.color1,
//       this.txt,
//       this.h,
//       this.w,
//       this.txtcolor,
//       this.fontsize,
//       this.leftWidget,
//       this.rigtWidget,
//       this.onTap,
//       this.SvgIcon});
//   @override
//   Widget build(BuildContext context) {
//     Size size1 = MediaQuery.of(context).size;
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: EdgeInsets.only(right: 10, left: 10),
//         height: h ?? size1.longestSide * 0.07202928,
//         width: w ?? size.convertWidth(context, 368),
//         decoration: BoxDecoration(
//           color: color1 == null ? appColor : color1,
//           borderRadius: BorderRadius.circular(5),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             leftWidget ?? Container(),
//             Row(
//               children: [
//                 // SvgIcon == null ? Container() :  SvgPicture.asset(SvgIcon),
//                 SizedBox(
//                   width: size.convertWidth(context, 6),
//                 ),
//                 Text(
//                   txt == null ? "Empty" : txt,
//                   style: style.RobotoRegular(
//                       fontSize: fontsize ?? size.convert(context, 14),
//                       color: whiteColor),
//                 ),
//               ],
//             ),
//             rigtWidget ?? Container(),
//           ],
//         ),
//       ),
//     );
//   }
// }
