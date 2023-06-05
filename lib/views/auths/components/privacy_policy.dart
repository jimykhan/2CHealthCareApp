import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:twochealthcare/common_widgets/check_button.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/patient_summary/components/costom_url_launcher.dart';
import 'package:twochealthcare/views/open_bottom_modal.dart';

class PrivacyPolicy extends StatelessWidget {

  Function(bool) onChecked;
  bool isChecked;
   PrivacyPolicy({Key? key,required this.isChecked,required this.onChecked}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomCheckButton(
            isChecked: isChecked,
          ontap: (){
            onChecked(!isChecked);
          },),
          SizedBox(width: 10,),
          Expanded(
            child: Container(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "By logging into your account, you agree to the ",
                        style: Styles.RobotoMedium(
                          fontSize: ApplicationSizing.fontScale(12),
                        )
                    ),
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            openBottomModalDisableDrag(
                                child: CostomUrlLauncher(
                                    url:  "https://2chealth.com/terms-of-use/",
                                  height: MediaQuery.of(context).size.height/1.5,
                                    ));
                            print('Terms of Service"');
                          },
                      text: "Term & Conditions",
                        style: Styles.RobotoMediumUnderLine(
                          fontSize: ApplicationSizing.fontScale(12),
                            color: appColor
                        )
                    ),
                    TextSpan(
                      text: " and ",
                        style: Styles.RobotoMedium(
                          fontSize: ApplicationSizing.fontScale(12),
                        )
                    ),
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            openBottomModalDisableDrag(
                                child: CostomUrlLauncher(
                                  url:  "https://2chealth.com/privacy-policy",
                                  height: MediaQuery.of(context).size.height/1.5,
                                ));
                            print('Privacy Policy');
                          },
                      text: "Privacy Policy",
                        style: Styles.RobotoMediumUnderLine(
                          fontSize: ApplicationSizing.fontScale(12),
                          color: appColor
                        )
                    ),
                    TextSpan(
                      text: " of 2C Health Solutions",
                        style: Styles.RobotoMedium(
                          fontSize: ApplicationSizing.fontScale(12),
                        )
                    ),
                  ]
                ),

              ),
            ),
          )
        ],
      ),
    );
  }
}


