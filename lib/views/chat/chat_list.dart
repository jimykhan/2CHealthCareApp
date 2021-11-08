import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twochealthcare/common_widgets/appbar_text_style.dart';
import 'package:twochealthcare/common_widgets/bottom_bar.dart';
import 'package:twochealthcare/common_widgets/custom_appbar.dart';
import 'package:twochealthcare/common_widgets/notification_widget.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/views/home/home.dart';
import 'package:twochealthcare/views/home/profile.dart';
class ChatList extends StatelessWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(ApplicationSizing.convert(80)),
          child: CustomAppBar(
            leadingIcon: Container(),
            color1: Colors.white,
            color2: Colors.white,
            hight: ApplicationSizing.convert(80),
            parentContext: context,
            centerWigets: AppBarTextStyle(
              text: "Chat List",
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          // backgroundColor: Colors.black,
          // child: SvgPicture.asset(
          //   "assets/icons/bottom_navbar/user-icon.svg",
          //   height: ApplicationSizing.convert(25),
          // ),
          child: Container(
            width: 60,
            height: 60,
            padding: EdgeInsets.all(15),
            child: SvgPicture.asset(
              "assets/icons/side_menu/home-icon.svg",
              height: ApplicationSizing.convert(25),
            ),
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    colors: [Color(0Xff4EAF48), Color(0xff60E558)])),
          ),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                PageTransition(
                  child: Home(),
                  type: PageTransitionType.bottomToTop,
                ));
          },
        ),
        bottomNavigationBar: BottomBar(selectedIndex: 2,),
        body: _body());
  }
  _body(){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: Text("Coming Soon...",
              style: Styles.PoppinsRegular(
                fontWeight: FontWeight.w500,
                color: appColor,
                fontSize: ApplicationSizing.fontScale(15),
              ),),
          ),
        ],
      ),
    );
  }
}
