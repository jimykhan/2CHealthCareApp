import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twochealthcare/util/application_sizing.dart';

class CircularSvgIcon extends StatelessWidget {
  double? iconSize;
  String? iconUrl;
  Color? bgColor;
  Color? iconColor;
  double? padding;
  Widget? fluentSystemIcons;
  Function()? ontap;
  CircularSvgIcon({this.iconSize,this.iconUrl,this.bgColor,this.ontap,this.fluentSystemIcons,this.padding,this.iconColor,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap ?? (){},
      child: Container(
        padding: EdgeInsets.all(padding??0),
        alignment: Alignment.center,
        width: iconSize?? ApplicationSizing.convert(20),
        height: iconSize?? ApplicationSizing.convert(20),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: bgColor?? Colors.red,
        ),
        child: fluentSystemIcons?? SvgPicture.asset(iconUrl?? "assets/icons/Icon_Back.svg" ,color: iconColor??Colors.white,),
      ),
    );
  }
}