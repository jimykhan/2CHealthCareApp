import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
class AddButton extends StatelessWidget {
  Function()? onClick;
  Color? color;
  AddButton({this.onClick,Key? key,this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
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
          child:Icon(Icons.add,
            color: color??appColor,)
      ),
    );
  }


}
