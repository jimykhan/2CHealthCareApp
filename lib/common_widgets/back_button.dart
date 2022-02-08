import 'package:flutter/material.dart';
import 'package:twochealthcare/util/application_colors.dart';
class CustomBackButton extends StatelessWidget {
  const CustomBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>Navigator.pop(context),
      child: Container(
        height: 32,
        width: 32,
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 10),
        padding: EdgeInsets.only(left: 8),
        decoration: BoxDecoration(
          color: appColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8)
        ),
        child: Icon(Icons.arrow_back_ios,
          color: Colors.black,),
      ),
    );
  }
}
