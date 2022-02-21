import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twochealthcare/util/application_colors.dart';

class DrawerMenuButton extends StatelessWidget {
  const DrawerMenuButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 32,
        width: 32,
        alignment: Alignment.center,
        // margin: EdgeInsets.only(left: 10),
        // padding: EdgeInsets.only(left: 8),
        decoration: BoxDecoration(
            color: appColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8)
        ),
        // padding: EdgeInsets.only(right: 20),
        child:
        SvgPicture.asset("assets/icons/side_menu/menu_icon.svg",
        // width: 10,
        //   height: 10,
        )
    );
  }
}
