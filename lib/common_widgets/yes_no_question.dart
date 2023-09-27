import 'package:flutter/material.dart';
import 'package:twochealthcare/common_widgets/input_field/custom_text_erea.dart';
import 'package:twochealthcare/common_widgets/input_field/custom_text_field.dart';
import 'package:twochealthcare/common_widgets/radio-button.dart';
import 'package:twochealthcare/common_widgets/toggle_button.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';

class YesNoQuestion extends StatelessWidget {
  Function() pressYes;
  Function() pressNo;
  bool isChecked;
  String? challengeName;
  String? question;
  bool disableComment;
  bool disableDecoration;
  TextEditingController? textEditingController;
  YesNoQuestion(
      {required this.isChecked,
      this.challengeName,
      required this.pressYes,
      required this.pressNo,
      this.textEditingController,
      this.question,
      this.disableComment = false,
      this.disableDecoration = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: disableDecoration ? null : BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1,
            color: fontGrayColor,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              question ?? "My Religion/Spirituality impacts my health care:",
              style: Styles.PoppinsRegular(
                fontWeight: FontWeight.w500,
                fontSize: ApplicationSizing.fontScale(16),
              ),
            ),
          ),
          ApplicationSizing.verticalSpacer(),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      RadioButton(
                        buttonSelected: isChecked,
                        onchange: pressYes,
                        disableText: false,
                      ),
                      Text(
                        "Yes",
                        style: Styles.PoppinsRegular(
                            fontSize: ApplicationSizing.fontScale(13),
                            color: fontGrayColor),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      RadioButton(
                        buttonSelected: !isChecked,
                        onchange: pressNo,
                        disableText: false,
                      ),
                      Text(
                        "No",
                        style: Styles.PoppinsRegular(
                            fontSize: ApplicationSizing.fontScale(13),
                            color: fontGrayColor),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          ApplicationSizing.verticalSpacer(),
          disableComment
              ? Container()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        "Other Comments",
                        style: Styles.PoppinsRegular(
                            fontWeight: FontWeight.w500,
                            fontSize: ApplicationSizing.fontScale(16),
                            color: fontGrayColor),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: CustomTextArea(
                        onchange: (val) {},
                        onSubmit: (val) {},
                        isEnable: false,
                        hints: "Comments..",
                        textEditingController: textEditingController,
                      ),
                    )
                  ],
                )
        ],
      ),
    );
  }
}

class fourOptionQuestion extends StatelessWidget {
  Function() onOption1;
  Function() onOption2;
  Function() onOption3;
  Function() onOption4;
  int selectedOption;
  String? challengeName;
  String? question;
  bool disableComment;
  String? option1;
  String? option2;
  String? option3;
  String? option4;
  TextEditingController? textEditingController;
  fourOptionQuestion(
      {this.challengeName,
      this.textEditingController,
      this.question,
      this.disableComment = false,
      this.option1,
      this.option2,
      this.option3,
      this.option4,
      required this.onOption1,
      required this.onOption2,
      required this.onOption3,
      required this.onOption4,
      this.selectedOption = 1,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1,
            color: fontGrayColor,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              question ?? "My Religion/Spirituality impacts my health care:",
              style: Styles.PoppinsRegular(
                fontWeight: FontWeight.w500,
                fontSize: ApplicationSizing.fontScale(16),
              ),
            ),
          ),
          ApplicationSizing.verticalSpacer(),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: RadioButton(
                        buttonSelected: selectedOption == 1 ? true : false,
                        onchange: onOption1,
                        disableText: false,
                        text: option1 ?? "",
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: RadioButton(
                        buttonSelected: selectedOption == 2 ? true : false,
                        onchange: onOption2,
                        disableText: false,
                        text: option2 ?? "",
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: RadioButton(
                        buttonSelected: selectedOption == 3 ? true : false,
                        onchange: onOption3,
                        disableText: false,
                        text: option3 ?? "",
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: RadioButton(
                        buttonSelected: selectedOption == 4 ? true : false,
                        onchange: onOption4,
                        disableText: false,
                        text: option4 ?? "",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ApplicationSizing.verticalSpacer(),
          disableComment
              ? Container()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        "Other Comments",
                        style: Styles.PoppinsRegular(
                            fontWeight: FontWeight.w500,
                            fontSize: ApplicationSizing.fontScale(16),
                            color: fontGrayColor),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: CustomTextArea(
                        onchange: (val) {},
                        onSubmit: (val) {},
                        isEnable: false,
                        hints: "Comments..",
                        textEditingController: textEditingController,
                      ),
                    )
                  ],
                )
        ],
      ),
    );
  }
}

class TextFieldQuestion extends StatelessWidget {
  String? question;
  TextEditingController? textEditingController;
  bool isTextArea;
  TextFieldQuestion(
      {this.textEditingController,
      this.question,
      this.isTextArea = true,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1,
            color: fontGrayColor,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              question ?? "Other Comments",
              style: Styles.PoppinsRegular(
                fontWeight: FontWeight.w500,
                fontSize: ApplicationSizing.fontScale(16),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: isTextArea
                ? CustomTextArea(
                    onchange: (val) {},
                    onSubmit: (val) {},
                    isEnable: false,
                    hints: "Comments..",
                    textEditingController: textEditingController,
                  )
                : CustomTextField(
                    onchange: (val) {},
                    onSubmit: (val) {},
                    isEnable: false,
                    hints: "Comments..",
                    textEditingController: textEditingController,
                    checkFocus: (val) {},
                  ),
          )
        ],
      ),
    );
  }
}
