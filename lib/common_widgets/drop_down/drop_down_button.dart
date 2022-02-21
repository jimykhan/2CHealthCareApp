import 'package:flutter/material.dart';
import 'package:twochealthcare/constants/strings.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';

class DropDownButton extends StatelessWidget {
  List<String> menuList ;
  String dropDownValue;
  Function(String? value) onChange;
   DropDownButton({Key? key,required this.menuList,required this.onChange,required this.dropDownValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.only(right: 8, left: 8),
            decoration: BoxDecoration(
                border: Border.all(
                  color:  disableColor,
                  width:  1.2,
                ),
                borderRadius: BorderRadius.circular(7)),
            child: DropdownButton<String>(
              value: dropDownValue,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down,
                size: 30,),
              // iconSize: 24,
              // elevation: 16,
              style: Styles.PoppinsRegular(
                fontSize: ApplicationSizing.fontScale(14),
              ),
              underline: Container(),
              onChanged: onChange,
              items: menuList
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,
                    style: Styles.PoppinsRegular(
                      fontSize: ApplicationSizing.fontScale(14),
                    ),
                  ),
                );
              })
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
