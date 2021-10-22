import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twochealthcare/common_widgets/appbar_text_style.dart';
import 'package:twochealthcare/common_widgets/bottom_bar.dart';
import 'package:twochealthcare/common_widgets/custom_appbar.dart';
import 'package:twochealthcare/common_widgets/notification_widget.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
class ChatList extends StatelessWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(ApplicationSizing.convert(80)),
          child: CustomAppBar(
            leadingIcon: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.only(right:ApplicationSizing.convertWidth(10)),
                child: RotatedBox(
                    quarterTurns: 2,child: SvgPicture.asset("assets/icons/home/right-arrow-icon.svg")),
              ),
            ),
            color1: Colors.white,
            color2: Colors.white,
            hight: ApplicationSizing.convert(80),
            parentContext: context,
            centerWigets: AppBarTextStyle(
              text: "Chat List",
            ),
          ),
        ),
        bottomNavigationBar: BottomBar(selectedIndex: 2,),
        body: _body());
  }
  _body(){
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ApplicationSizing.verticalSpacer(n: 20),
            Container(
              child: Text("Comming Soon...",
              style: Styles.PoppinsRegular(
                fontWeight: FontWeight.w500,
                color: appColor,
                fontSize: ApplicationSizing.fontScale(15),
              ),),
            ),
            ApplicationSizing.verticalSpacer(),
          ],
        ),
      ),
    );
  }
}
