import 'package:flutter/material.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
class ToggleButton extends StatefulWidget {
  Function onChange;
  double? buttonWidth;
  // double buttonHeight;
  // double disableHeight;
  // double disableWidth;
  double? enableHeight;
  double? enableWidth;
  Color? enableColor;
  Color? disableColor;
  // Color dotColor;
  bool? value;
  ToggleButton({this.value = false,required this.onChange,this.buttonWidth,this.enableHeight,this.enableWidth,this.enableColor,this.disableColor});
  @override
  _ToggleButtonState createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        widget.onChange(widget.value);
      },
      child: Container(
        width: 40,
        decoration: BoxDecoration(
            color: widget.value! ? appColor : fontGrayColor,
            borderRadius: BorderRadius.circular(20)
        ),
        child: Row(
          mainAxisAlignment: ! widget.value! ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.all(2),
              height: widget.enableHeight?? 20,
              width: widget.enableWidth?? 20,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0.1,0.3),
                  )
                ]
              ),
            )
          ],
        ),
      ),
    );
  }
}