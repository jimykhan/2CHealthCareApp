import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class FilledButton extends StatelessWidget {
  Function()? onTap;
  Color? color1;
  Color? txtcolor;
  String? txt;
  double? h;
  double? w;
  Color? borderColor;
  double? borderwidth;
  double? fontsize;
  String? fontfamily;
  Widget? leftWidget;
  Widget? rigtWidget;

  FilledButton(
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
      required this.onTap});
  @override
  Widget build(BuildContext context) {
    Size size1 = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap ,
      child: Container(
        padding: EdgeInsets.only(right: 10, left: 10),
        height: h ?? ApplicationSizing.convert(50),
        width: w ?? ApplicationSizing.convertWidth(360),
        decoration: BoxDecoration(
            color: color1 ?? appColor,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              width: borderwidth ?? 0,
              color: borderColor ?? appColor,
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            leftWidget ?? Container(),
            const SizedBox(
              width: 10,
            ),
            Text(
              txt ?? "Empty" ,
              style: Styles.PoppinsBold(
                  fontSize: fontsize ?? ApplicationSizing.fontScale(16),
                  color: whiteColor),
            ),
            const SizedBox(
              width: 10,
            ),
            rigtWidget ?? Container(),
          ],
        ),
      ),
    );
  }
}

// class filledButtonWithCenterIcon extends StatelessWidget {
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
//   filledButtonWithCenterIcon(
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
