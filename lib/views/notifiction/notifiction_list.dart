import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twochealthcare/common_widgets/appbar_text_style.dart';
import 'package:twochealthcare/common_widgets/custom_appbar.dart';
import 'package:twochealthcare/common_widgets/notification_widget.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';

class NotificationList extends StatelessWidget {
  const NotificationList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(ApplicationSizing.convert(80)),
          child: CustomAppBar(
            leadingIcon: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding:
                    EdgeInsets.only(right: ApplicationSizing.convertWidth(10)),
                child: RotatedBox(
                    quarterTurns: 2,
                    child: SvgPicture.asset(
                        "assets/icons/home/right-arrow-icon.svg")),
              ),
            ),
            color1: Colors.white,
            color2: Colors.white,
            hight: ApplicationSizing.convert(80),
            parentContext: context,
            centerWigets: AppBarTextStyle(
              text: "Notification",
            ),
          ),
        ),
        body: _body());
  }

  _body() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ApplicationSizing.verticalSpacer(n: 20),
            Container(
              child: ListView.separated(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        // Navigator.push(context, PageTransition(
                        //     child: NotificationList(), type: PageTransitionType.bottomToTop));
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: ApplicationSizing.horizontalMargin()),
                        child: NotificationWidget(
                          title: "Lorem Ipsum",
                          date: "6 April",
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Container(
                      height: 1,
                      color: fontGrayColor.withOpacity(0.5),
                    );
                  },
                  itemCount: 10),
            ),
            ApplicationSizing.verticalSpacer(),
          ],
        ),
      ),
    );
  }
}
