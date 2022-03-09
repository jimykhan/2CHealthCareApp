import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
class SqureIconButton extends StatelessWidget {
  String? svgPictureUrl;
  Color? bgColor;
  Function() onClick;
  SqureIconButton({this.svgPictureUrl,this.bgColor,required this.onClick,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        width: ApplicationSizing.constSize(52),
        height: ApplicationSizing.constSize(52),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: bgColor??appColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: SvgPicture.asset(svgPictureUrl??"assets/icons/filter_icon.svg"),
      ),
    );
  }
}
