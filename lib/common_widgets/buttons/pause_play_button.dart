import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';

class PausePlayButton extends StatelessWidget {
  bool withBackground;
  bool isPause;
  Function()? ontap;
  PausePlayButton({Key? key,this.withBackground = false,this.ontap,this.isPause = false}) : super(key: key);

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
          isPause ? Icons.pause_circle_outline : Icons.play_circle_outline,
          color: withBackground ? whiteColor : errorColor,
          size: ApplicationSizing.convert(23),
        ),
      ),
    );
  }
}
