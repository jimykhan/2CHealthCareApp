import 'package:flutter/material.dart';
import 'package:twochealthcare/util/styles.dart';

class FlexibleButton extends StatelessWidget {
  Function()? ontap;
  Widget child;
  Color? color1;
  Color? color2;
   FlexibleButton({this.ontap,required this.child,this.color1,this.color2,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [color1?? Color(0xff388333), color2?? Color(0xff4EAF48)],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            borderRadius: BorderRadius.circular(10),

          ),
          child: child
        )
    );
  }
}
