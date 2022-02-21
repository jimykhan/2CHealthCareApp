import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/common_widgets/alert_loader.dart';
import 'package:twochealthcare/common_widgets/app_bar_components/appbar_text_style.dart';
import 'package:twochealthcare/common_widgets/app_bar_components/back_button.dart';
import 'package:twochealthcare/common_widgets/custom_appbar.dart';
import 'package:twochealthcare/common_widgets/input_field/custom_text_erea.dart';
import 'package:twochealthcare/common_widgets/yes_no_question.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/application_route_service.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/care_plan_vm/care_plan_vm.dart';
import 'package:twochealthcare/view_models/profile_vm.dart';
import 'package:twochealthcare/views/care_plan/components/isChallengeChecked.dart';
import 'package:twochealthcare/views/home/components/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CarePlan extends HookWidget {
  CarePlan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApplicationRouteService applicationRouteService =
    useProvider(applicationRouteServiceProvider);
    CarePlanVM carePlanVM = useProvider(carePlanVMProvider);
    useEffect(
          () {
        Future.microtask(() async {
          carePlanVM.getCarePlanByPatientId();
        });

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
          ),
        ),
        body: Stack(
          children: [
            _body(context,carePlanVM: carePlanVM),
            carePlanVM.loadingCarePlan ? AlertLoader() : Container(),
          ],
        )
    );
  }

  _body(context,{required CarePlanVM carePlanVM}) {
    return Container(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                ApplicationSizing.verticalSpacer(n: 15),
                _carePlans(context,carePlanVM: carePlanVM),
                ApplicationSizing.verticalSpacer(n: 15),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _carePlans(context,{required CarePlanVM carePlanVM}) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: ApplicationSizing.horizontalMargin()),
      child: Column(
        children: [
          challenges(carePlanVM: carePlanVM),
          ApplicationSizing.verticalSpacer(),
          advanceDirectives(carePlanVM: carePlanVM),
          ApplicationSizing.verticalSpacer(),
          _goals(carePlanVM: carePlanVM)
        ],
      ),
    );
  }

  challenges({required CarePlanVM carePlanVM}){
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
                      child: IsChallengeChecked(isChecked: carePlanVM.carePlanModel?.challengesWithTransportation??false,
                        pressChecked: () {  },
                        challengeName: "Transportion",
                      ),
                    ),
                    Expanded(
                      flex:2,
                      child: Container(
                        child: IsChallengeChecked(isChecked: carePlanVM.carePlanModel?.challengesWithVision??false,
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
                      child: IsChallengeChecked(isChecked: carePlanVM.carePlanModel?.challengesWithHearing??false,
                        pressChecked: () {  },
                        challengeName: "Hearing",
                      ),
                    ),
                    Expanded(
                      flex:2,
                      child: Container(
                        child: IsChallengeChecked(isChecked: carePlanVM.carePlanModel?.challengesWithMobility??false,
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
                  textEditingController: carePlanVM.challengesController,
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
            isChecked: carePlanVM.carePlanModel?.religionImpactsOnHealthCare??false,
            question: "My Religion/Spirituality impacts my health care:",
            textEditingController: carePlanVM.religionController,
          ),
        ),
      ],
    );
  }

  advanceDirectives({required CarePlanVM carePlanVM}){
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
                isChecked: carePlanVM.carePlanModel?.healthCareAdvancedDirectives??false,
              question: "Healthcare Advance Directives",
                textEditingController: carePlanVM.healthCareAdvancedDirectivesController,
              ),
              ApplicationSizing.verticalSpacer(),
              YesNoQuestion(pressNo: () {  }, pressYes: () {  },
                isChecked: carePlanVM.carePlanModel?.polst??false,
                question: "Physician Orders for Life Sustaining Treatment (POLST)",
                textEditingController: carePlanVM.polstController,
              ),
              ApplicationSizing.verticalSpacer(),
              YesNoQuestion(pressNo: () {  }, pressYes: () {  },
                isChecked: carePlanVM.carePlanModel?.powerOfAttorney??false,
                question: "Power of Attorney (Financial / Healthcare)",
                textEditingController: carePlanVM.powerOfAttorneyController,
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
                  selectedOption: carePlanVM.carePlanModel?.iLive?.toUpperCase().trim() == "alone".toUpperCase() ? 1
                      : carePlanVM.carePlanModel?.iLive?.toUpperCase().trim() == "partner/spouse".toUpperCase() ? 2 :
                  carePlanVM.carePlanModel?.iLive?.toUpperCase().trim() == "ExtendedFamily".toUpperCase() ? 3 :
                  carePlanVM.carePlanModel?.iLive?.toUpperCase().trim() == "other".toUpperCase() ? 4 : 1,
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
                  selectedOption: carePlanVM.carePlanModel?.iLearnBestBy?.toUpperCase().trim() == "reading".toUpperCase() ? 1
                      : carePlanVM.carePlanModel?.iLearnBestBy?.toUpperCase().trim() == "Beingtalkedto".toUpperCase() ? 2 :
                  carePlanVM.carePlanModel?.iLearnBestBy?.toUpperCase().trim() == "Beingshowhow".toUpperCase() ? 3 :
                  carePlanVM.carePlanModel?.iLearnBestBy?.toUpperCase().trim() == "listeningtotapes".toUpperCase() ? 4 : 1,
                  question: "I learn best by",
                  option1: "Reading",
                  option2: "Being talked to",
                  option3: "Being show how",
                  option4: "Listening to tapes", onOption3: () {  }, onOption4: () {  },
                  textEditingController: carePlanVM.iLearnBestByController,

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
                  disableComment: carePlanVM.carePlanModel?.internetAccess??false,
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
                  question: "I have issues with Diet", pressYes: () {  }, pressNo: () {  },
                  isChecked: carePlanVM.carePlanModel?.dietIssues??false,
                  textEditingController: carePlanVM.dietIssuesController,
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
                child: Text("I am concerned about:",
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
                      child: IsChallengeChecked(
                        isChecked: carePlanVM.carePlanModel?.concernedAboutManagingChronicCondition??false,
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
                      child: IsChallengeChecked(
                        isChecked: false,
                        pressChecked: () {  },
                        challengeName: "Financial issues",
                      ),
                    ),
                    Expanded(
                      flex:3,
                      child: Container(
                        child: IsChallengeChecked(
                          isChecked: carePlanVM.carePlanModel?.concernedAboutEmotionalIssues??false,
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
                      child: IsChallengeChecked(
                        isChecked: false,
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
                      child: IsChallengeChecked(
                        isChecked: false,
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
                      child: IsChallengeChecked(
                        isChecked: false,
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
                      child: IsChallengeChecked(
                        isChecked: false,
                        pressChecked: () {  },
                        challengeName: "Spiritual issues",
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IsChallengeChecked(
                        isChecked: carePlanVM.carePlanModel?.concernedAboutFamilyIssues??false,
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
                      child: IsChallengeChecked(
                        isChecked: false,
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
                  textEditingController: carePlanVM.concernedAboutOtherController,
                ),
              )
            ],
          ),
        ),

      ],
    );
  }

  _goals({required CarePlanVM carePlanVM}){
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
              RatingBarIndicator(
                rating: carePlanVM.carePlanModel?.satisfactionWithMedicalCare?.toDouble() ?? 0.0,
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: appColor,
                ),
                itemCount: 5,
                itemSize: 35.0,
                direction: Axis.horizontal,
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
                  textEditingController: carePlanVM.satisfactionController,
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
                  textEditingController: carePlanVM.wantToImproveOnController,
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
