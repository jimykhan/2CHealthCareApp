import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';

class DeleteButton extends StatelessWidget {
  bool withBackground;
  Function()? ontap;
  DeleteButton({Key? key,this.withBackground = false,this.ontap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.all(withBackground ? 8 : 8),
        decoration: withBackground ?
        BoxDecoration(
            color: appColor,
            shape: BoxShape.circle
        )
            : null,
        child: Icon(
          Icons.delete,
          color: withBackground ? whiteColor : errorColor,
          size: ApplicationSizing.convert(23),
        ),
      ),
    );
  }
}
