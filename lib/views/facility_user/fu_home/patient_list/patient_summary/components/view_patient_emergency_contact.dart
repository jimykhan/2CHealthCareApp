import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twochealthcare/common_widgets/input_field/custom_text_field.dart';
import 'package:twochealthcare/common_widgets/mask_formatter.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/views/home/components/widgets.dart';

class ViewPatientEmergencyContact extends StatelessWidget {
  String? title;
  String? name;
  String? primaryNo;
  String? secondayNo;
  String? relationship;
  ViewPatientEmergencyContact({this.name,this.primaryNo,this.relationship,this.secondayNo,this.title,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1,
            color: fontGrayColor,
          )
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(title??"Emergency Contact:",
              style: Styles.PoppinsRegular(
                fontWeight: FontWeight.w500,
                fontSize: ApplicationSizing.fontScale(16),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: ApplicationSizing.convert(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: RichText(
                    text: TextSpan(
                      text: "Name",
                      style: Styles.PoppinsBold(
                          fontSize: ApplicationSizing.fontScale(12),
                          color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: CustomTextField(
                    checkFocus: (val){},
                    onchange: (val) {},
                    textEditingController: TextEditingController(text: name??""),
                    textInputType: TextInputType.text,
                    hints: "Name",
                    isEnable: false,
                    onSubmit: (val) {},
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: ApplicationSizing.convert(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: RichText(
                    text: TextSpan(
                      text: "Primary Phone",
                      style: Styles.PoppinsBold(
                          fontSize: ApplicationSizing.fontScale(12),
                          color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: CustomTextField(
                    checkFocus: (val){},
                    inputFormatter: [MaskFormatter("000-000-0000")],
                    onchange: (val) {},
                    isEnable: false,
                    textEditingController: TextEditingController(text: primaryNo??""),
                    textInputType: TextInputType.phone,
                    hints: "Primary Phone",
                    // color1:
                    // profileVm.isPrimaryPhoneFieldValid ? disableColor : errorColor,
                    onSubmit: (val) {},
                  ),
                ),
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: ApplicationSizing.convert(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: RichText(
                    text: TextSpan(
                      text: "Relationship",
                      style: Styles.PoppinsBold(
                          fontSize: ApplicationSizing.fontScale(12),
                          color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                    child: CustomTextField(
                      checkFocus: (val){},
                      inputFormatter: [MaskFormatter("000-000-0000")],
                      onchange: (val) {},
                      isEnable: false,
                      textEditingController: TextEditingController(text: relationship??""),

                      hints: "Relationship",
                      // color1:
                      // profileVm.isPrimaryPhoneFieldValid ? disableColor : errorColor,
                      onSubmit: (val) {},
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: ApplicationSizing.convert(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: RichText(
                    text: TextSpan(
                      text: "Secondary Phone",
                      style: Styles.PoppinsBold(
                          fontSize: ApplicationSizing.fontScale(12),
                          color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: CustomTextField(
                    checkFocus: (val){},
                    inputFormatter: [MaskFormatter("000-000-0000")],
                    onchange: (val) {},
                    isEnable: false,
                    textEditingController: TextEditingController(text: secondayNo??""),
                    textInputType: TextInputType.phone,
                    hints: "Secondary Phone",
                    // color1:
                    // profileVm.isPrimaryPhoneFieldValid ? disableColor : errorColor,
                    onSubmit: (val) {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
