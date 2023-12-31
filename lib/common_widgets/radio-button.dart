import 'package:flutter/material.dart';
import 'package:twochealthcare/common_widgets/text-line-through.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';

class RadioButton extends StatelessWidget {
  Function()? onchange;
  String? text;
  bool? disableText = true;
  bool buttonSelected = false;
  bool? isExpand = false;
  bool noText;
  double? LineWidth;
  double? LineHight;
  TextStyle? style;
  RadioButton(
      {this.onchange,
      this.text,
      this.disableText,
      required this.buttonSelected,
      this.LineHight,
      this.LineWidth,
      this.noText = false,
      this.isExpand = false,
      this.style});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          InkWell(
            onTap: onchange ?? null,
            child: Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      width: 2,
                      color: buttonSelected
                          ? appColor
                          : Colors.black.withOpacity(0.6))),
              child: buttonSelected
                  ? Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: appColor,
                          border: Border.all(width: 1.5, color: Colors.white)),
                    )
                  : Container(
                      width: 0.1,
                      height: 0.1,
                    ),
            ),
          ),
          noText
              ? Container()
              : SizedBox(
                  width: ApplicationSizing.convertWidth(10),
                ),
          noText
              ? Container()
              : isExpand??false ? Expanded(
                child: TextLineThrough(
                    text: text ?? "",
                    disableText: disableText!,
                    LineHight: LineHight,
                    LineWidth: LineWidth,
                    style: style,
                  ),
              ) :  TextLineThrough(
                  text: text ?? "",
                  disableText: disableText!,
                  LineHight: LineHight,
                  LineWidth: LineWidth,
                  style: style,
                ),
        ],
      ),
    );
  }
}
