import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/common_widgets/alert_loader.dart';
import 'package:twochealthcare/common_widgets/appbar_text_style.dart';
import 'package:twochealthcare/common_widgets/back_button.dart';
import 'package:twochealthcare/common_widgets/custom_appbar.dart';
import 'package:twochealthcare/common_widgets/custom_text_erea.dart';
import 'package:twochealthcare/common_widgets/yes_no_question.dart';
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
          ApplicationSizing.verticalSpacer(),
          advanceDirectives(),
          ApplicationSizing.verticalSpacer(),
          _goals()
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
                        "Demographics",
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
          child: YesNoQuestion(pressNo: () {  }, pressYes: () {  },
            isChecked: false,
            question: "My Religion/Spirituality impacts my health care:",
          ),
        ),
      ],
    );
  }

  advanceDirectives(){
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
                        "Advance Directives",
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
              YesNoQuestion(pressNo: () {  }, pressYes: () {  },
                isChecked: false,
              question: "Healthcare Advance Directives",
              ),
              ApplicationSizing.verticalSpacer(),
              YesNoQuestion(pressNo: () {  }, pressYes: () {  },
                isChecked: false,
                question: "Physician Orders for Life Sustaining Treatment (POLST)",
              ),
              ApplicationSizing.verticalSpacer(),
              YesNoQuestion(pressNo: () {  }, pressYes: () {  },
                isChecked: false,
                question: "Power of Attorney (Financial / Healthcare)",
              ),


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
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                fourOptionQuestion(onOption1: () {  }, onOption2: () {  },
                  selectedOption: 2,
                  question: "I live",
                  option1: "Alone",
                  option2: "Partner/Spouse",
                  option3: "Extended Family",
                  option4: "Other",
                  disableComment: true, onOption3: () {  }, onOption4: () {  },
                ),
              ],
            ),
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
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                fourOptionQuestion(onOption1: () {  }, onOption2: () {  },
                  selectedOption: 3,
                  question: "I learn best by",
                  option1: "Reading",
                  option2: "Being talked to",
                  option3: "Being show how",
                  option4: "Listening to tapes", onOption3: () {  }, onOption4: () {  },

                ),
              ],
            ),
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
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                YesNoQuestion(
                  question: "I have access to the Internet", pressYes: () {  }, pressNo: () {  }, isChecked: false,
                  disableComment: true,
                ),
              ],
            ),
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
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                YesNoQuestion(
                  question: "I have issues with Diet", pressYes: () {  }, pressNo: () {  }, isChecked: false,

                ),
              ],
            ),
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
                      child: IsChallengeChecked(isChecked: true,
                        pressChecked: () {  },
                        challengeName: "My ability to manage my chronic condition",
                      ),
                    ),
                  ],
                ),
              ),
              ApplicationSizing.verticalSpacer(n: 5),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex:3,
                      child: IsChallengeChecked(isChecked: true,
                        pressChecked: () {  },
                        challengeName: "Financial issues",
                      ),
                    ),
                    Expanded(
                      flex:3,
                      child: Container(
                        child: IsChallengeChecked(isChecked: true,
                          pressChecked: () {  },
                          challengeName: "Emotional issues",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ApplicationSizing.verticalSpacer(n: 5),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: IsChallengeChecked(isChecked: true,
                        pressChecked: () {  },
                        challengeName: "Having access to Healthcare",
                      ),
                    ),
                  ],
                ),
              ),
              ApplicationSizing.verticalSpacer(n: 5),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: IsChallengeChecked(isChecked: true,
                        pressChecked: () {  },
                        challengeName: "My decrease energy level / Fatigue",
                      ),
                    ),
                  ],
                ),
              ),
              ApplicationSizing.verticalSpacer(n: 5),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: IsChallengeChecked(isChecked: true,
                        pressChecked: () {  },
                        challengeName: "Thinking or memory problems",
                      ),
                    ),
                  ],
                ),
              ),
              ApplicationSizing.verticalSpacer(n: 5),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: IsChallengeChecked(isChecked: true,
                        pressChecked: () {  },
                        challengeName: "Spiritual issues",
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IsChallengeChecked(isChecked: true,
                        pressChecked: () {  },
                        challengeName: "Family issues",
                      ),
                    ),
                  ],
                ),
              ),
              ApplicationSizing.verticalSpacer(n: 5),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: IsChallengeChecked(isChecked: true,
                        pressChecked: () {  },
                        challengeName: "End of life issues",
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

      ],
    );
  }

  _goals(){
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
                        "Goals",
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
                child: Text("How satisfied I am with the current medical care",
                  style: Styles.PoppinsRegular(
                    fontWeight: FontWeight.w500,
                    fontSize: ApplicationSizing.fontScale(16),
                  ),
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
              ),
              ApplicationSizing.verticalSpacer(),
              Container(
                child: Text("I want to improve on",
                  style:  Styles.PoppinsRegular(
                    fontWeight: FontWeight.w500,
                    fontSize: ApplicationSizing.fontScale(16),
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
      ],
    );
  }


}
