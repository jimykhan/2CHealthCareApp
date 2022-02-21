import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twochealthcare/common_widgets/red_dot.dart';
import 'package:twochealthcare/util/application_colors.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 32,
        width: 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: appColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8)
        ),
        // padding: EdgeInsets.only(right: 20),
        child: Container(
          width: 32,
          height: 32,
          // color: Colors.red,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset("assets/icons/Notifications/bell_icon.svg",
                // width: 10,
                //   height: 10,
              ),
               Positioned(
                  bottom: 17,
                    left: 17,
                    child: RedDot(paddingAll: 4,)),


            ],
          ),
        )
    );
  }
}
