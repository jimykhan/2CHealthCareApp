import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/common_widgets/alert_loader.dart';
import 'package:twochealthcare/common_widgets/appbar_text_style.dart';
import 'package:twochealthcare/common_widgets/back_button.dart';
import 'package:twochealthcare/common_widgets/check_button.dart';
import 'package:twochealthcare/common_widgets/custom_appbar.dart';
import 'package:twochealthcare/common_widgets/custom_text_erea.dart';
import 'package:twochealthcare/common_widgets/custom_text_field.dart';
import 'package:twochealthcare/common_widgets/error_text.dart';
import 'package:twochealthcare/common_widgets/filled_button.dart';
import 'package:twochealthcare/common_widgets/loader.dart';
import 'package:twochealthcare/common_widgets/mask_formatter.dart';
import 'package:twochealthcare/common_widgets/notification_widget.dart';
import 'package:twochealthcare/common_widgets/true_false_question.dart';
import 'package:twochealthcare/constants/strings.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/application_route_service.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/profile_vm.dart';
import 'package:twochealthcare/views/care_plan/components/isChallengeChecked.dart';
import 'package:twochealthcare/views/home/components/widgets.dart';

class CarePlan extends HookWidget {
  CarePlan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApplicationRouteService applicationRouteService =
    useProvider(applicationRouteServiceProvider);
    ProfileVm profileVM = useProvider(profileVMProvider);
    useEffect(
          () {
        profileVM.initEditEmergencyContactInfo();
        Future.microtask(() async {});

        return () {
          // Dispose Objects here
        };
      },
      const [],
    );
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(ApplicationSizing.convert(80)),
          child: CustomAppBar(
            leadingIcon: CustomBackButton(),
            color1: Colors.white,
            color2: Colors.white,
            hight: ApplicationSizing.convert(80),
            parentContext: context,
            centerWigets: AppBarTextStyle(
              text: "Care Plan",
            ),
            // trailingIcon: InkWell(
            //   onTap: (){
            //   },
            //   child: Container(
            //     padding: EdgeInsets.all(5),
            //     child: Icon(Icons.check,
            //       color: appColor,),
            //   ),
            // ),
          ),
        ),
        body: Stack(
          children: [
            _body(context,profileVm: profileVM),
            profileVM.loading ? AlertLoader() : Container(),
          ],
        )
    );
  }

  _body(context,{required ProfileVm profileVm}) {
    return Container(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                ApplicationSizing.verticalSpacer(n: 15),
                _carePlans(context,profileVm: profileVm),
                ApplicationSizing.verticalSpacer(n: 15),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _carePlans(context,{required ProfileVm profileVm}) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: ApplicationSizing.horizontalMargin()),
      child: Column(
        children: [
          challenges(),
        ],
      ),
    );
  }

  challenges(){
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: ApplicationSizing.horizontalMargin()),
                decoration: boxDecoration,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    children: [
                      Text(
                        "Emergency Contact",
                        style: Styles.PoppinsRegular(
                            fontWeight: FontWeight.w700,
                            fontSize: ApplicationSizing.fontScale(15),
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        ApplicationSizing.verticalSpacer(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 1,
              color: fontGrayColor,
            )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text("I have challenges with:",
                  style: Styles.PoppinsRegular(
                    fontWeight: FontWeight.w500,
                    fontSize: ApplicationSizing.fontScale(16),
                  ),
                ),
              ),
              ApplicationSizing.verticalSpacer(),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex:3,
                      child: IsChallengeChecked(isChecked: true,
                        pressChecked: () {  },
                        challengeName: "Transportion",
                      ),
                    ),
                    Expanded(
                      flex:2,
                      child: Container(
                        child: IsChallengeChecked(isChecked: true,
                          pressChecked: () {  },
                          challengeName: "Vision",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ApplicationSizing.verticalSpacer(),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex:3,
                      child: IsChallengeChecked(isChecked: true,
                        pressChecked: () {  },
                        challengeName: "Hearing",
                      ),
                    ),
                    Expanded(
                      flex:2,
                      child: Container(
                        child: IsChallengeChecked(isChecked: true,
                          pressChecked: () {  },
                          challengeName: "Mobility",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ApplicationSizing.verticalSpacer(),
              Container(
                child: Text("Other Comments",
                  style: Styles.PoppinsRegular(
                    fontWeight: FontWeight.w500,
                    fontSize: ApplicationSizing.fontScale(16),
                    color: fontGrayColor
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 5
                ),
                child: CustomTextArea(
                  onchange: (val){}, onSubmit: (val){},
                  isEnable: false,
                  hints: "Comments..",
                ),
              )
            ],
          ),
        ),
        ApplicationSizing.verticalSpacer(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 1,
                color: fontGrayColor,
              )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text("My Religion/Spirituality impacts my health care:",
                  style: Styles.PoppinsRegular(
                    fontWeight: FontWeight.w500,
                    fontSize: ApplicationSizing.fontScale(16),
                  ),
                ),
              ),
              ApplicationSizing.verticalSpacer(),
              TrueFalseQuestion(pressYes: () {

              }, pressNo: () {  }, isChecked: true,
              ),
              ApplicationSizing.verticalSpacer(),
              Container(
                child: Text("Other Comments",
                  style: Styles.PoppinsRegular(
                      fontWeight: FontWeight.w500,
                      fontSize: ApplicationSizing.fontScale(16),
                      color: fontGrayColor
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 5
                ),
                child: CustomTextArea(
                  onchange: (val){}, onSubmit: (val){},
                  isEnable: false,
                  hints: "Comments..",
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

}
