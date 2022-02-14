import 'package:flutter/material.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/views/home/components/widgets.dart';

class MenuTile extends StatelessWidget {
  bool isSelected;
  String menuText;
  int index;
  MenuTile({this.isSelected = true,this.menuText = "",required this.index,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? appColor : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: CustomShadow.whiteBoxShadowWith15(dy: 1),
       ),
      padding: EdgeInsets.symmetric(horizontal: 9,vertical: 4),
      child: Text(menuText,style: Styles.PoppinsRegular(
        fontWeight: FontWeight.w500,
        fontSize: ApplicationSizing.constSize(16),
        color: isSelected ? Colors.white : Colors.black
      ),),
    );
  }
}
