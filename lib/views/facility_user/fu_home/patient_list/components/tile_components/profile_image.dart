import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ApplicationSizing.constSize(60),
      height: ApplicationSizing.constSize(60),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: appColor, borderRadius: BorderRadius.circular(15)),
      child: SvgPicture.asset(
        "assets/icons/home/user-icon.svg",
      ),
    );
  }
}
