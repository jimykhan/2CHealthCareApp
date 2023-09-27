import 'package:flutter/material.dart';
import 'package:twochealthcare/common_widgets/check_button.dart';
import 'package:twochealthcare/common_widgets/input_field/custom_text_erea.dart';
import 'package:twochealthcare/common_widgets/radio-button.dart';
import 'package:twochealthcare/models/phs_form_models/phs_q_option_model.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';

class MutiSelectOptionQuestion extends StatelessWidget {
  Function(int id,bool isSelect) onOptionClick;
  List<PhsFormOptionRecords> phsFormOptionRecords;
  String? question;
  String? optionText;

  MutiSelectOptionQuestion(
      {required this.onOptionClick,
      this.question,
      required this.phsFormOptionRecords,
      this.optionText,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
            width: MediaQuery.of(context).size.width,
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              runAlignment: WrapAlignment.spaceAround,
              children: phsFormOptionRecords
                      ?.map((e) => Container(
                            margin: EdgeInsets.only(right: 10),
                            child: CustomCheckButton(
                              isChecked: e.isSelected ?? false,
                              ontap: () {
                                
                              },
                              onOptionReturn: (flag) {
                                onOptionClick(e.id ?? -1,flag);
                              },
                              optionText: e.text,
                            ),
                          ))
                      .toList() ??
                  [],
            ),
          )
        ],
      ),
    );
  }
}
