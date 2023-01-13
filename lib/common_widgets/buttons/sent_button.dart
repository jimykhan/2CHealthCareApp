import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';

class SendButton extends StatelessWidget {
  bool withBackground;
  Function()? ontap;
   SendButton({Key? key,this.withBackground = false,this.ontap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
          padding: EdgeInsets.all(withBackground ? 8 : 0),
          decoration: withBackground ?
              BoxDecoration(
                color: appColor,
                shape: BoxShape.circle
              )
              : null,
          child: Icon(
          Icons.send,
          color: withBackground ? whiteColor : AppBarEndColor,
          size: ApplicationSizing.convert(23),
        ),
      ),
    );
  }
}
