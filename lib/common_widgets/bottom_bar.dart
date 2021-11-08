import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/views/chat/chat_list.dart';
import 'package:twochealthcare/views/home/home.dart';
import 'package:twochealthcare/views/home/profile.dart';

class BottomBar extends StatelessWidget {
  int selectedIndex;
  BottomBar({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(MediaQuery.of(context).size.width,70),
      painter: BottomBarPaint(),
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: ApplicationSizing.horizontalMargin()),
        height: ApplicationSizing.convert(60),
        color: Colors.transparent,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  if (selectedIndex != 1) {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            child: Profile(),
                            type: PageTransitionType.topToBottom));
                    print("do something on selected index $selectedIndex}");
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    "assets/icons/bottom_navbar/user-icon.svg",
                    height: ApplicationSizing.convert(25),
                  ),
                ),
              ),
            ),
            ApplicationSizing.horizontalSpacer(n: 180),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  if (selectedIndex != 2) {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            child: ChatList(),
                            type: PageTransitionType.bottomToTop));
                    print("do something on selected index $selectedIndex}");
                  }
                },
                child: Container(
                  // color: Colors.red,
                  alignment: Alignment.center,

                  child: SvgPicture.asset(
                    "assets/icons/bottom_navbar/message-icon.svg",
                    height: ApplicationSizing.convert(25),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    //  BottomAppBar(
    //   // color: appColor,
    //   // shape: const CircularNotchedRectangle(),
    //   // notchMargin: 9.0,
    //   // elevation: 1,
    //   child: CustomPaint(
    //     size: Size(MediaQuery.of(context).size.width,80),
    //     painter: BottomBarPaint(),
    //
    //   ),
    //   child: Container(
    //     margin: EdgeInsets.symmetric(
    //         horizontal: ApplicationSizing.horizontalMargin()),
    //     height: ApplicationSizing.convert(60),
    //     color: Colors.transparent,
    //     child: Row(
    //       children: <Widget>[
    //         Expanded(
    //           flex: 1,
    //           child: InkWell(
    //             onTap: () {
    //               if (selectedIndex != 1) {
    //                 Navigator.pushReplacement(
    //                     context,
    //                     PageTransition(
    //                         child: Home(),
    //                         type: PageTransitionType.topToBottom));
    //                 print("do something on selected index $selectedIndex}");
    //               }
    //             },
    //             child: Container(
    //               alignment: Alignment.center,
    //               child: SvgPicture.asset(
    //                 "assets/icons/side_menu/home-icon.svg",
    //                 height: ApplicationSizing.convert(25),
    //               ),
    //             ),
    //           ),
    //         ),
    //         ApplicationSizing.horizontalSpacer(n: 180),
    //         Expanded(
    //           flex: 1,
    //           child: InkWell(
    //             onTap: () {
    //               if (selectedIndex != 2) {
    //                 Navigator.pushReplacement(
    //                     context,
    //                     PageTransition(
    //                         child: ChatList(),
    //                         type: PageTransitionType.bottomToTop));
    //                 print("do something on selected index $selectedIndex}");
    //               }
    //             },
    //             child: Container(
    //               // color: Colors.red,
    //               alignment: Alignment.center,
    //
    //               child: SvgPicture.asset(
    //                 "assets/icons/bottom_navbar/message-icon.svg",
    //                 height: ApplicationSizing.convert(25),
    //               ),
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}

class BottomBarPaint extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint paint = Paint()..color = Colors.green..style = PaintingStyle.fill;
     Path path = Path()..moveTo(0, 0);
     path.quadraticBezierTo(0, 0, size.width*0.40, 0);
     path.quadraticBezierTo(size.width*0.35, 0, size.width*0.40, 0);
     path.arcToPoint(Offset(size.width*0.60,0),radius: Radius.circular(10),
     clockwise: false);
    path.quadraticBezierTo(size.width*0.60, 0, size.width*0.65, 0);
    path.quadraticBezierTo(size.width*0.80, 0, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawShadow(path, Colors.transparent, 4, false);
    canvas.drawPath(path,paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw false;
  }

}
