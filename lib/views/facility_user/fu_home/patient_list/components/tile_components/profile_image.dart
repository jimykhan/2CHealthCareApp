import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ApplicationSizing.constSize(55),
      height: ApplicationSizing.constSize(55),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: appColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10)
      ),
      child: SvgPicture.asset("assets/icons/home/user-icon.svg",
      ),
    );
  }
}
