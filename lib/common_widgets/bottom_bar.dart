import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/views/chat/chat_list.dart';
import 'package:twochealthcare/views/home/home.dart';

class BottomBar extends StatelessWidget {
  int selectedIndex;
  BottomBar({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: appColor,
      shape: const CircularNotchedRectangle(),
      notchMargin: 9.0,
      elevation: 1,
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
                            child: Home(),
                            type: PageTransitionType.topToBottom));
                    print("do something on selected index $selectedIndex}");
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    "assets/icons/side_menu/home-icon.svg",
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
  }
}
