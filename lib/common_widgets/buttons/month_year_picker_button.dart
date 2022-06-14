import 'package:flutter/material.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/styles.dart';

class MonthYearPickerButton extends StatelessWidget {
  String? buttonText;
  Function()? onClick;
  MonthYearPickerButton({this.onClick,this.buttonText,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        width: 170,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: fontGrayColor,
            width: 1
          ),
          borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(buttonText??"Please Choose Date",
              style: Styles.PoppinsBold(
                fontSize: 12
              ),
            ),

            Icon(Icons.keyboard_arrow_down_sharp,)
          ],
        ),
      ),
    );
  }
}
