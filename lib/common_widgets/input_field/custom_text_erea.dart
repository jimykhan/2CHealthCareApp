import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/util/application_colors.dart';

class CustomTextArea extends StatefulWidget {
  Color? color1;
  Widget? iconWidget;
  Function(String val) onchange;
  Function(String val) onSubmit;
  String? hints;
  Widget? trailingIcon;
  double? borderWidth;
  TextInputType? textInputType;
  TextEditingController? textEditingController;
  bool? obscureText;
  bool? isEnable;
  List<TextInputFormatter>? inputFormatter;
  TextStyle? textStyle;
  int? maxLine;
  double? height;
  CustomTextArea(
      {this.isEnable = true,
        this.obscureText,
        this.textInputType,
        this.borderWidth,
        this.trailingIcon,
        this.hints,
        this.color1,
        this.iconWidget,
        this.textEditingController,
        required this.onchange,
        required this.onSubmit,
        this.inputFormatter,
        this.textStyle,
      this.maxLine,
        this.height
      });
  @override
  _CustomTextAreaState createState() => _CustomTextAreaState();
}

class _CustomTextAreaState extends State<CustomTextArea> {
  Color? borderColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: size.convert(context, 50),
      padding: EdgeInsets.only(right: 8, left: 8),
      decoration: BoxDecoration(
          border: Border.all(
            color: borderColor ?? widget.color1 ?? disableColor,
            width: widget.borderWidth ?? 1.2,
          ),
          borderRadius: BorderRadius.circular(7)),
      child: Row(
        children: <Widget>[
          widget.iconWidget ?? Container(),
          Expanded(
            child: Column(
              children: [
                Container(
                  // height: size.convert(context, 40),
                  height: widget.height ?? 80,
                  child: Focus(
                    onFocusChange: (val) {
                      if (val) {
                        borderColor = appColor;
                        widget.onSubmit;
                        setState(() {});
                      } else {
                        widget.onSubmit;
                        borderColor = null;
                        setState(() {});
                      }

                      print(val);
                    },
                    child: TextFormField(
                      maxLines: widget.maxLine ??10,
                      style: Styles.PoppinsRegular(
                        fontSize: ApplicationSizing.fontScale(14),
                      ),
                      inputFormatters: widget.inputFormatter,
                      onFieldSubmitted: widget.onSubmit,
                      onChanged: widget.onchange,
                      enabled: widget.isEnable ?? true,
                      cursorWidth: 1.2,
                      obscureText: widget.obscureText ?? false,
                      keyboardType: widget.textInputType ?? TextInputType.text,
                      controller: widget.textEditingController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          disabledBorder: InputBorder.none,
                          border: InputBorder.none,
                          hintText: widget.hints ?? "",
                          hintStyle: widget.textStyle ?? Styles.PoppinsRegular(
                              color: fontGrayColor,
                              fontSize: ApplicationSizing.fontScale(12)),
                          labelStyle: TextStyle()
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          widget.trailingIcon ?? Container(),
        ],
      ),
    );
  }
}
