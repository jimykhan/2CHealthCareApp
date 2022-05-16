import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/common_widgets/alert_loader.dart';
import 'package:twochealthcare/common_widgets/app_bar_components/appbar_text_style.dart';
import 'package:twochealthcare/common_widgets/app_bar_components/back_button.dart';
import 'package:twochealthcare/common_widgets/collapsible_container.dart';
import 'package:twochealthcare/common_widgets/custom_appbar.dart';
import 'package:twochealthcare/common_widgets/input_field/custom_text_erea.dart';
import 'package:twochealthcare/common_widgets/yes_no_question.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/application_route_service.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/care_plan_vm/care_plan_vm.dart';
import 'package:twochealthcare/view_models/facility_user_view_model/fu_patient_summary_veiw_models/fu_patient_summary_view_model.dart';
import 'package:twochealthcare/view_models/profile_vm.dart';
import 'package:twochealthcare/views/care_plan/components/isChallengeChecked.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/patient_summary/components/alliergies_body.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/patient_summary/components/diagnosis_body.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/patient_summary/components/headline_text_style.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/patient_summary/components/medications_body.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/patient_summary/components/view_patient_emergency_contact.dart';
import 'package:twochealthcare/views/home/components/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:twochealthcare/views/home/edit_emergency_contact.dart';

class CarePlan extends HookWidget {
  bool isPatientSummary;
  CarePlan({this.isPatientSummary = false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApplicationRouteService applicationRouteService =
        useProvider(applicationRouteServiceProvider);
    CarePlanVM carePlanVM = useProvider(carePlanVMProvider);
    FUPatientSummaryVM _fuPatientSummaryVM =
        useProvider(fUPatientSummaryVMProvider);
    useEffect(
      () {
        carePlanVM.carePlanHistory.forEach((element) {
          element["isExpand"] = false;
        });
        Future.microtask(() async {
          carePlanVM.getCarePlanByPatientId(
              Id: isPatientSummary
                  ? _fuPatientSummaryVM.patientInfo?.id
                  : null);
          carePlanVM.getChronicConditionsByPatientId(
              Id: isPatientSummary
                  ? _fuPatientSummaryVM.patientInfo?.id
                  : null);
        });

        return () {
          // Dispose Objects here
        };
      },
      const [],
    );
    return isPatientSummary
        ? withOutScaffold(context, carePlanVM: carePlanVM)
        : Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(ApplicationSizing.convert(70)),
              child: CustomAppBar(
                leadingIcon: CustomBackButton(),
                color1: Colors.white,
                color2: Colors.white,
                hight: ApplicationSizing.convert(70),
                parentContext: context,
                centerWigets: AppBarTextStyle(
                  text: "Care Plan",
                ),
              ),
            ),
            body: Stack(
              children: [
                _body(context, carePlanVM: carePlanVM),
                carePlanVM.loadingCarePlan ? AlertLoader() : Container(),
              ],
            ));
  }

  withOutScaffold(context, {required CarePlanVM carePlanVM}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: ApplicationSizing.horizontalMargin()),
          child: HeadLineTextStyle(
            text: "Care Plan",
          ),
        ),
        Stack(
          children: [
            _body(context, carePlanVM: carePlanVM),
            carePlanVM.loadingCarePlan ? AlertLoader() : Container(),
          ],
        ),
      ],
    );
  }

  _body(context, {required CarePlanVM carePlanVM}) {
    return Container(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                ListView.separated(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: (context, index) {
                      return CollapsibleContainer(
                        IsCollaps: carePlanVM.ChangeCollaps,
                        isExpand: carePlanVM.carePlanHistory[index]["isExpand"],
                        title: carePlanVM.carePlanHistory[index]["title"],
                        child: carePlanVM.carePlanHistory[index]["body"],
                        Index: index,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 15,
                      );
                    },
                    itemCount: carePlanVM.carePlanHistory.length),
                ApplicationSizing.verticalSpacer(n: 15),
                _carePlans(context, carePlanVM: carePlanVM),
                ApplicationSizing.verticalSpacer(n: 15),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _carePlans(context, {required CarePlanVM carePlanVM}) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: ApplicationSizing.horizontalMargin()),
      child: Column(
        children: [
          patientAssessment(carePlanVM: carePlanVM),
          ApplicationSizing.verticalSpacer(),
          Psychosocial(carePlanVM: carePlanVM),
          ApplicationSizing.verticalSpacer(),
          socialDemographic(carePlanVM: carePlanVM),
          ApplicationSizing.verticalSpacer(),
          patientResouces(carePlanVM: carePlanVM),
          ApplicationSizing.verticalSpacer(),
          advanceDirectivesSection(carePlanVM: carePlanVM),
          ApplicationSizing.verticalSpacer(),
          _goals(carePlanVM: carePlanVM),
          ApplicationSizing.verticalSpacer(),
          chronicCondition(carePlanVM: carePlanVM)
        ],
      ),
    );
  }

  patientAssessment({required CarePlanVM carePlanVM}) {
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
                        "Patient Assessment",
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
                  "Functional:",
                  style: Styles.PoppinsRegular(
                    fontWeight: FontWeight.w500,
                    fontSize: ApplicationSizing.fontScale(16),
                  ),
                ),
              ),
              Container(
                child: Text(
                  "Do you have any issues with:",
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
                    // Expanded(
                    //   flex:3,
                    //   child: IsChallengeChecked(isChecked: carePlanVM.carePlanModel?.challengesWithTransportation??false,
                    //     pressChecked: () {  },
                    //     challengeName: "Transportion",
                    //   ),
                    // ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: IsChallengeChecked(
                          isChecked:
                              carePlanVM.carePlanModel?.challengesWithVision ??
                                  false,
                          pressChecked: () {},
                          challengeName: "Vision",
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: IsChallengeChecked(
                        isChecked:
                            carePlanVM.carePlanModel?.challengesWithHearing ??
                                false,
                        pressChecked: () {},
                        challengeName: "Hearing",
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
                      flex: 2,
                      child: Container(
                        child: IsChallengeChecked(
                          isChecked: carePlanVM
                                  .carePlanModel?.challengesWithMobility ??
                              false,
                          pressChecked: () {},
                          challengeName: "Mobility",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ApplicationSizing.verticalSpacer(),
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
                  textEditingController: carePlanVM.challengesController,
                ),
              )
            ],
          ),
        ),
        ApplicationSizing.verticalSpacer(),
        Container(
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
                  "Activities of Daily Living:",
                  style: Styles.PoppinsRegular(
                    fontWeight: FontWeight.w500,
                    fontSize: ApplicationSizing.fontScale(16),
                  ),
                ),
              ),
              Container(
                child: Text(
                  "Which of the following can you do on your own?",
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
                      flex: 2,
                      child: Container(
                        child: IsChallengeChecked(
                          isChecked:
                              carePlanVM.carePlanModel?.dailyLivingBath ??
                                  false,
                          pressChecked: () {},
                          challengeName: "Bath",
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: IsChallengeChecked(
                        isChecked:
                            carePlanVM.carePlanModel?.dailyLivingWalk ?? false,
                        pressChecked: () {},
                        challengeName: "Walk",
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
                      flex: 2,
                      child: Container(
                        child: IsChallengeChecked(
                          isChecked:
                              carePlanVM.carePlanModel?.dailyLivingDress ??
                                  false,
                          pressChecked: () {},
                          challengeName: "Dress",
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: IsChallengeChecked(
                          isChecked:
                              carePlanVM.carePlanModel?.dailyLivingEat ?? false,
                          pressChecked: () {},
                          challengeName: "Eat",
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
                      flex: 2,
                      child: Container(
                        child: IsChallengeChecked(
                          isChecked:
                              carePlanVM.carePlanModel?.dailyLivingTransfer ??
                                  false,
                          pressChecked: () {},
                          challengeName: "Transfer in/out of chair, etc.",
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: IsChallengeChecked(
                          isChecked:
                              carePlanVM.carePlanModel?.dailyLivingRestroom ??
                                  false,
                          pressChecked: () {},
                          challengeName: "Use the restroom",
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
                      child: Container(
                        child: IsChallengeChecked(
                          isChecked:
                              carePlanVM.carePlanModel?.dailyLivingNone ??
                                  false,
                          pressChecked: () {},
                          challengeName: "None",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ApplicationSizing.verticalSpacer(),
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
                  hints: "Daily Living",
                  textEditingController: carePlanVM.dailyLivingController,
                ),
              )
            ],
          ),
        ),
        ApplicationSizing.verticalSpacer(),
        Container(
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
                  "Instrumental Daily Activities:",
                  style: Styles.PoppinsRegular(
                    fontWeight: FontWeight.w500,
                    fontSize: ApplicationSizing.fontScale(16),
                  ),
                ),
              ),
              Container(
                child: Text(
                  "Which of the following can you do on your own?",
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
                      flex: 2,
                      child: Container(
                        child: IsChallengeChecked(
                          isChecked: carePlanVM
                                  .carePlanModel?.instrumentalDailyGrocery ??
                              false,
                          pressChecked: () {},
                          challengeName: "Shop for groceries",
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: IsChallengeChecked(
                        isChecked: carePlanVM
                                .carePlanModel?.instrumentalDailyTelephone ??
                            false,
                        pressChecked: () {},
                        challengeName: "Use the telephone",
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
                      flex: 2,
                      child: Container(
                        child: IsChallengeChecked(
                          isChecked: carePlanVM
                                  .carePlanModel?.instrumentalDailyHouseWork ??
                              false,
                          pressChecked: () {},
                          challengeName: "Housework",
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: IsChallengeChecked(
                          isChecked: carePlanVM
                                  .carePlanModel?.instrumentalDailyFinances ??
                              false,
                          pressChecked: () {},
                          challengeName: "Handle finances",
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
                      flex: 2,
                      child: Container(
                        child: IsChallengeChecked(
                          isChecked: carePlanVM.carePlanModel
                                  ?.instrumentalDailyTransportation ??
                              false,
                          pressChecked: () {},
                          challengeName: "Drive/use public transportation",
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: IsChallengeChecked(
                          isChecked: carePlanVM
                                  .carePlanModel?.instrumentalDailyMeals ??
                              false,
                          pressChecked: () {},
                          challengeName: "Make meals",
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
                      flex: 2,
                      child: Container(
                        child: IsChallengeChecked(
                          isChecked: carePlanVM
                                  .carePlanModel?.instrumentalDailyMedication ??
                              false,
                          pressChecked: () {},
                          challengeName: "Take medications",
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: IsChallengeChecked(
                          isChecked:
                              carePlanVM.carePlanModel?.instrumentalDailyNone ??
                                  false,
                          pressChecked: () {},
                          challengeName: "None",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ApplicationSizing.verticalSpacer(),
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
                  hints: "Daily Activity",
                  textEditingController: carePlanVM.dailyLivingController,
                ),
              )
            ],
          ),
        ),
        ApplicationSizing.verticalSpacer(),
        // Container(
        //   padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        //   decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(10),
        //       border: Border.all(
        //         width: 1,
        //         color: fontGrayColor,
        //       )
        //   ),
        //   child: YesNoQuestion(pressNo: () {  }, pressYes: () {  },
        //     isChecked: carePlanVM.carePlanModel?.religionImpactsOnHealthCare??false,
        //     question: "My Religion/Spirituality impacts my health care:",
        //     textEditingController: carePlanVM.religionController,
        //   ),
        // ),
      ],
    );
  }

  Psychosocial({required CarePlanVM carePlanVM}) {
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
                        "PHQ-2 :",
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
        fourOptionQuestion(
          onOption1: () {},
          onOption2: () {},
          selectedOption: (carePlanVM.carePlanModel?.littleInterest ?? 0) + 1,
          question: "Little interest or pleasure in doing things",
          option1: "0",
          option2: "+1",
          option3: "+2",
          option4: "+3",
          disableComment: true,
          onOption3: () {},
          onOption4: () {},
        ),
        ApplicationSizing.verticalSpacer(),
        fourOptionQuestion(
          onOption1: () {},
          onOption2: () {},
          selectedOption: (carePlanVM.carePlanModel?.feelingDown ?? 0) + 1,
          question: "Feeling down, depressed or hopeless",
          option1: "0",
          option2: "+1",
          option3: "+2",
          option4: "+3",
          disableComment: false,
          onOption3: () {},
          onOption4: () {},
          textEditingController: carePlanVM.feelingDownController,
        ),
        ApplicationSizing.verticalSpacer(),
      ],
    );
  }

  socialDemographic({required CarePlanVM carePlanVM}) {
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
                        "Social/Demographic",
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
        TextFieldQuestion(
            question:
                "Do you require help with transportation/ Have adequate access to healthcare:",
            textEditingController: carePlanVM.requireTransportationController),
        ApplicationSizing.verticalSpacer(),
        fourOptionQuestion(
          onOption1: () {},
          onOption2: () {},
          selectedOption: carePlanVM.carePlanModel?.iLive
                      ?.toUpperCase()
                      .trim() ==
                  "alone".toUpperCase()
              ? 1
              : carePlanVM.carePlanModel?.iLive?.toUpperCase().trim() ==
                      "partner/spouse".toUpperCase()
                  ? 2
                  : carePlanVM.carePlanModel?.iLive?.toUpperCase().trim() ==
                          "ExtendedFamily".toUpperCase()
                      ? 3
                      : carePlanVM.carePlanModel?.iLive?.toUpperCase().trim() ==
                              "other".toUpperCase()
                          ? 4
                          : 1,
          question: "Patient live",
          option1: "Alone",
          option2: "Partner/Spouse",
          option3: "Extended Family",
          option4: "Other",
          disableComment: true,
          onOption3: () {},
          onOption4: () {},
        ),
        ApplicationSizing.verticalSpacer(),
        TextFieldQuestion(
            question: "English as a second language (ESL):",
            textEditingController: carePlanVM.eSLController),

        // YesNoQuestion(pressNo: () {  }, pressYes: () {  },
        //   isChecked: carePlanVM.carePlanModel?.healthCareAdvancedDirectives??false,
        //   question: "Healthcare Advance Directives",
        //   textEditingController: carePlanVM.healthCareAdvancedDirectivesController,
        // ),
        // ApplicationSizing.verticalSpacer(),
        // YesNoQuestion(pressNo: () {  }, pressYes: () {  },
        //   isChecked: carePlanVM.carePlanModel?.polst??false,
        //   question: "Physician Orders for Life Sustaining Treatment (POLST)",
        //   textEditingController: carePlanVM.polstController,
        // ),
        ApplicationSizing.verticalSpacer(),
        YesNoQuestion(
          pressNo: () {},
          pressYes: () {},
          isChecked: carePlanVM.carePlanModel?.internetAccess ?? false,
          question: "Patient Have Internet Access",
          textEditingController: carePlanVM.powerOfAttorneyController,
          disableComment: true,
        ),
        ApplicationSizing.verticalSpacer(),
        YesNoQuestion(
          pressNo: () {},
          pressYes: () {},
          isChecked: carePlanVM.carePlanModel?.cellPhone ?? false,
          question: "Patient Have Cell Phone",
          disableComment: true,
        ),
        ApplicationSizing.verticalSpacer(),
        TextFieldQuestion(
          question: "Patients Cell Phone number is:",
          textEditingController: carePlanVM.patientPhoneNo,
          isTextArea: false,
        ),
        ApplicationSizing.verticalSpacer(),
        YesNoQuestion(
          pressNo: () {},
          pressYes: () {},
          isChecked: false,
          question: "Patients can respond to Text Messages",
          disableComment: true,
        ),
        ApplicationSizing.verticalSpacer(),
        ViewPatientEmergencyContact(
          name: carePlanVM.carePlanModel?.emergencyContactName,
          relationship: carePlanVM.carePlanModel?.emergencyContactRelationship,
          secondayNo:
              carePlanVM.carePlanModel?.emergencyContactSecondaryPhoneNo,
          primaryNo: carePlanVM.carePlanModel?.emergencyContactPrimaryPhoneNo,
        ),

        ApplicationSizing.verticalSpacer(),
        ViewPatientEmergencyContact(
          title: "Do you have a designated caregiver?",
          name: carePlanVM.carePlanModel?.careGiverContactName,
          relationship: carePlanVM.carePlanModel?.careGiverContactRelationship,
          secondayNo:
              carePlanVM.carePlanModel?.careGiverContactSecondaryPhoneNo,
          primaryNo: carePlanVM.carePlanModel?.careGiverContactPrimaryPhoneNo,
        ),
        ApplicationSizing.verticalSpacer(),

        // Container(
        //   padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        //   decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(10),
        //       border: Border.all(
        //         width: 1,
        //         color: fontGrayColor,
        //       )
        //   ),
        //   child: Container(
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         fourOptionQuestion(onOption1: () {  }, onOption2: () {  },
        //           selectedOption: carePlanVM.carePlanModel?.iLearnBestBy?.toUpperCase().trim() == "reading".toUpperCase() ? 1
        //               : carePlanVM.carePlanModel?.iLearnBestBy?.toUpperCase().trim() == "Beingtalkedto".toUpperCase() ? 2 :
        //           carePlanVM.carePlanModel?.iLearnBestBy?.toUpperCase().trim() == "Beingshowhow".toUpperCase() ? 3 :
        //           carePlanVM.carePlanModel?.iLearnBestBy?.toUpperCase().trim() == "listeningtotapes".toUpperCase() ? 4 : 1,
        //           question: "I learn best by",
        //           option1: "Reading",
        //           option2: "Being talked to",
        //           option3: "Being show how",
        //           option4: "Listening to tapes", onOption3: () {  }, onOption4: () {  },
        //           textEditingController: carePlanVM.iLearnBestByController,
        //
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        // ApplicationSizing.verticalSpacer(),
        // Container(
        //   padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        //   decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(10),
        //       border: Border.all(
        //         width: 1,
        //         color: fontGrayColor,
        //       )
        //   ),
        //   child: Container(
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         YesNoQuestion(
        //           question: "I have access to the Internet", pressYes: () {  }, pressNo: () {  }, isChecked: false,
        //           disableComment: carePlanVM.carePlanModel?.internetAccess??false,
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        // ApplicationSizing.verticalSpacer(),
        // Container(
        //   padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        //   decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(10),
        //       border: Border.all(
        //         width: 1,
        //         color: fontGrayColor,
        //       )
        //   ),
        //   child: Container(
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         YesNoQuestion(
        //           question: "I have issues with Diet", pressYes: () {  }, pressNo: () {  },
        //           isChecked: carePlanVM.carePlanModel?.dietIssues??false,
        //           textEditingController: carePlanVM.dietIssuesController,
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        // ApplicationSizing.verticalSpacer(),
        // Container(
        //   padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        //   decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(10),
        //       border: Border.all(
        //         width: 1,
        //         color: fontGrayColor,
        //       )
        //   ),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Container(
        //         child: Text("I am concerned about:",
        //           style: Styles.PoppinsRegular(
        //             fontWeight: FontWeight.w500,
        //             fontSize: ApplicationSizing.fontScale(16),
        //           ),
        //         ),
        //       ),
        //       ApplicationSizing.verticalSpacer(),
        //       Container(
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Expanded(
        //               child: IsChallengeChecked(
        //                 isChecked: carePlanVM.carePlanModel?.concernedAboutManagingChronicCondition??false,
        //                 pressChecked: () {  },
        //                 challengeName: "My ability to manage my chronic condition",
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //       ApplicationSizing.verticalSpacer(n: 5),
        //       Container(
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Expanded(
        //               flex:3,
        //               child: IsChallengeChecked(
        //                 isChecked: false,
        //                 pressChecked: () {  },
        //                 challengeName: "Financial issues",
        //               ),
        //             ),
        //             Expanded(
        //               flex:3,
        //               child: Container(
        //                 child: IsChallengeChecked(
        //                   isChecked: carePlanVM.carePlanModel?.concernedAboutEmotionalIssues??false,
        //                   pressChecked: () {  },
        //                   challengeName: "Emotional issues",
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //       ApplicationSizing.verticalSpacer(n: 5),
        //       Container(
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Expanded(
        //               child: IsChallengeChecked(
        //                 isChecked: false,
        //                 pressChecked: () {  },
        //                 challengeName: "Having access to Healthcare",
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //       ApplicationSizing.verticalSpacer(n: 5),
        //       Container(
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Expanded(
        //               child: IsChallengeChecked(
        //                 isChecked: false,
        //                 pressChecked: () {  },
        //                 challengeName: "My decrease energy level / Fatigue",
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //       ApplicationSizing.verticalSpacer(n: 5),
        //       Container(
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Expanded(
        //               child: IsChallengeChecked(
        //                 isChecked: false,
        //                 pressChecked: () {  },
        //                 challengeName: "Thinking or memory problems",
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //       ApplicationSizing.verticalSpacer(n: 5),
        //       Container(
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Expanded(
        //               flex: 1,
        //               child: IsChallengeChecked(
        //                 isChecked: false,
        //                 pressChecked: () {  },
        //                 challengeName: "Spiritual issues",
        //               ),
        //             ),
        //             Expanded(
        //               flex: 1,
        //               child: IsChallengeChecked(
        //                 isChecked: carePlanVM.carePlanModel?.concernedAboutFamilyIssues??false,
        //                 pressChecked: () {  },
        //                 challengeName: "Family issues",
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //       ApplicationSizing.verticalSpacer(n: 5),
        //       Container(
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Expanded(
        //               child: IsChallengeChecked(
        //                 isChecked: false,
        //                 pressChecked: () {  },
        //                 challengeName: "End of life issues",
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //       ApplicationSizing.verticalSpacer(),
        //       Container(
        //         child: Text("Other Comments",
        //           style: Styles.PoppinsRegular(
        //               fontWeight: FontWeight.w500,
        //               fontSize: ApplicationSizing.fontScale(16),
        //               color: fontGrayColor
        //           ),
        //         ),
        //       ),
        //       Container(
        //         margin: EdgeInsets.symmetric(
        //             horizontal: 5,
        //             vertical: 5
        //         ),
        //         child: CustomTextArea(
        //           onchange: (val){}, onSubmit: (val){},
        //           isEnable: false,
        //           hints: "Comments..",
        //           textEditingController: carePlanVM.concernedAboutOtherController,
        //         ),
        //       )
        //     ],
        //   ),
        // ),
      ],
    );
  }

  patientResouces({required CarePlanVM carePlanVM}) {
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
                        "Patient Resources",
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ApplicationSizing.verticalSpacer(),
              Container(
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
                        "Is the patient utilizing any Community/Social Services (HHC/Skilled Nursing etc.):",
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
                          // Expanded(
                          //   flex:3,
                          //   child: IsChallengeChecked(isChecked: carePlanVM.carePlanModel?.challengesWithTransportation??false,
                          //     pressChecked: () {  },
                          //     challengeName: "Transportion",
                          //   ),
                          // ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              child: IsChallengeChecked(
                                isChecked: carePlanVM
                                        .carePlanModel?.discussWithPhysician ??
                                    false,
                                pressChecked: () {},
                                challengeName: "Home Health Care",
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: IsChallengeChecked(
                              isChecked: carePlanVM
                                      .carePlanModel?.discussWithPhysician ??
                                  false,
                              pressChecked: () {},
                              challengeName: "Skilled Nursing",
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
                            flex: 2,
                            child: Container(
                              child: IsChallengeChecked(
                                isChecked: carePlanVM
                                        .carePlanModel?.discussWithPhysician ??
                                    false,
                                pressChecked: () {},
                                challengeName: "Physiotherapy",
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              child: IsChallengeChecked(
                                isChecked: carePlanVM
                                        .carePlanModel?.discussWithPhysician ??
                                    false,
                                pressChecked: () {},
                                challengeName: "Home Hospice",
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
                            flex: 2,
                            child: Container(
                              child: IsChallengeChecked(
                                isChecked: carePlanVM
                                        .carePlanModel?.discussWithPhysician ??
                                    false,
                                pressChecked: () {},
                                challengeName: "Other",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ApplicationSizing.verticalSpacer(),
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
                        textEditingController: carePlanVM.challengesController,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        ApplicationSizing.verticalSpacer(),
      ],
    );
  }

  // advanceDirectives({required CarePlanVM carePlanVM}){
  //   return Column(
  //     children: [
  //       Row(
  //         children: [
  //           Expanded(
  //             child: Container(
  //               padding: EdgeInsets.symmetric(
  //                   horizontal: ApplicationSizing.horizontalMargin()),
  //               decoration: boxDecoration,
  //               child: Container(
  //                 margin: EdgeInsets.symmetric(vertical: 3),
  //                 child: Row(
  //                   children: [
  //                     Text(
  //                       "Advance Directives",
  //                       style: Styles.PoppinsRegular(
  //                           fontWeight: FontWeight.w700,
  //                           fontSize: ApplicationSizing.fontScale(15),
  //                           color: Colors.white),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //       ApplicationSizing.verticalSpacer(),
  //       Container(
  //         padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
  //         decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(10),
  //             border: Border.all(
  //               width: 1,
  //               color: fontGrayColor,
  //             )
  //         ),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             YesNoQuestion(pressNo: () {  }, pressYes: () {  },
  //               isChecked: carePlanVM.carePlanModel?.healthCareAdvancedDirectives??false,
  //             question: "Healthcare Advance Directives",
  //               textEditingController: carePlanVM.healthCareAdvancedDirectivesController,
  //             ),
  //             ApplicationSizing.verticalSpacer(),
  //             YesNoQuestion(pressNo: () {  }, pressYes: () {  },
  //               isChecked: carePlanVM.carePlanModel?.polst??false,
  //               question: "Physician Orders for Life Sustaining Treatment (POLST)",
  //               textEditingController: carePlanVM.polstController,
  //             ),
  //             ApplicationSizing.verticalSpacer(),
  //             YesNoQuestion(pressNo: () {  }, pressYes: () {  },
  //               isChecked: carePlanVM.carePlanModel?.powerOfAttorney??false,
  //               question: "Power of Attorney (Financial / Healthcare)",
  //               textEditingController: carePlanVM.powerOfAttorneyController,
  //             ),
  //
  //
  //           ],
  //         ),
  //       ),
  //       ApplicationSizing.verticalSpacer(),
  //       Container(
  //         padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
  //         decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(10),
  //             border: Border.all(
  //               width: 1,
  //               color: fontGrayColor,
  //             )
  //         ),
  //         child: Container(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               fourOptionQuestion(onOption1: () {  }, onOption2: () {  },
  //                 selectedOption: carePlanVM.carePlanModel?.iLive?.toUpperCase().trim() == "alone".toUpperCase() ? 1
  //                     : carePlanVM.carePlanModel?.iLive?.toUpperCase().trim() == "partner/spouse".toUpperCase() ? 2 :
  //                 carePlanVM.carePlanModel?.iLive?.toUpperCase().trim() == "ExtendedFamily".toUpperCase() ? 3 :
  //                 carePlanVM.carePlanModel?.iLive?.toUpperCase().trim() == "other".toUpperCase() ? 4 : 1,
  //                 question: "I live",
  //                 option1: "Alone",
  //                 option2: "Partner/Spouse",
  //                 option3: "Extended Family",
  //                 option4: "Other",
  //                 disableComment: true, onOption3: () {  }, onOption4: () {  },
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //       ApplicationSizing.verticalSpacer(),
  //       Container(
  //         padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
  //         decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(10),
  //             border: Border.all(
  //               width: 1,
  //               color: fontGrayColor,
  //             )
  //         ),
  //         child: Container(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               fourOptionQuestion(onOption1: () {  }, onOption2: () {  },
  //                 selectedOption: carePlanVM.carePlanModel?.iLearnBestBy?.toUpperCase().trim() == "reading".toUpperCase() ? 1
  //                     : carePlanVM.carePlanModel?.iLearnBestBy?.toUpperCase().trim() == "Beingtalkedto".toUpperCase() ? 2 :
  //                 carePlanVM.carePlanModel?.iLearnBestBy?.toUpperCase().trim() == "Beingshowhow".toUpperCase() ? 3 :
  //                 carePlanVM.carePlanModel?.iLearnBestBy?.toUpperCase().trim() == "listeningtotapes".toUpperCase() ? 4 : 1,
  //                 question: "I learn best by",
  //                 option1: "Reading",
  //                 option2: "Being talked to",
  //                 option3: "Being show how",
  //                 option4: "Listening to tapes", onOption3: () {  }, onOption4: () {  },
  //                 textEditingController: carePlanVM.iLearnBestByController,
  //
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //       ApplicationSizing.verticalSpacer(),
  //       Container(
  //         padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
  //         decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(10),
  //             border: Border.all(
  //               width: 1,
  //               color: fontGrayColor,
  //             )
  //         ),
  //         child: Container(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               YesNoQuestion(
  //                 question: "I have access to the Internet", pressYes: () {  }, pressNo: () {  }, isChecked: false,
  //                 disableComment: carePlanVM.carePlanModel?.internetAccess??false,
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //       ApplicationSizing.verticalSpacer(),
  //       Container(
  //         padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
  //         decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(10),
  //             border: Border.all(
  //               width: 1,
  //               color: fontGrayColor,
  //             )
  //         ),
  //         child: Container(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               YesNoQuestion(
  //                 question: "I have issues with Diet", pressYes: () {  }, pressNo: () {  },
  //                 isChecked: carePlanVM.carePlanModel?.dietIssues??false,
  //                 textEditingController: carePlanVM.dietIssuesController,
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //       ApplicationSizing.verticalSpacer(),
  //       Container(
  //         padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
  //         decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(10),
  //             border: Border.all(
  //               width: 1,
  //               color: fontGrayColor,
  //             )
  //         ),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Container(
  //               child: Text("I am concerned about:",
  //                 style: Styles.PoppinsRegular(
  //                   fontWeight: FontWeight.w500,
  //                   fontSize: ApplicationSizing.fontScale(16),
  //                 ),
  //               ),
  //             ),
  //             ApplicationSizing.verticalSpacer(),
  //             Container(
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Expanded(
  //                     child: IsChallengeChecked(
  //                       isChecked: carePlanVM.carePlanModel?.concernedAboutManagingChronicCondition??false,
  //                       pressChecked: () {  },
  //                       challengeName: "My ability to manage my chronic condition",
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             ApplicationSizing.verticalSpacer(n: 5),
  //             Container(
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Expanded(
  //                     flex:3,
  //                     child: IsChallengeChecked(
  //                       isChecked: false,
  //                       pressChecked: () {  },
  //                       challengeName: "Financial issues",
  //                     ),
  //                   ),
  //                   Expanded(
  //                     flex:3,
  //                     child: Container(
  //                       child: IsChallengeChecked(
  //                         isChecked: carePlanVM.carePlanModel?.concernedAboutEmotionalIssues??false,
  //                         pressChecked: () {  },
  //                         challengeName: "Emotional issues",
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             ApplicationSizing.verticalSpacer(n: 5),
  //             Container(
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Expanded(
  //                     child: IsChallengeChecked(
  //                       isChecked: false,
  //                       pressChecked: () {  },
  //                       challengeName: "Having access to Healthcare",
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             ApplicationSizing.verticalSpacer(n: 5),
  //             Container(
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Expanded(
  //                     child: IsChallengeChecked(
  //                       isChecked: false,
  //                       pressChecked: () {  },
  //                       challengeName: "My decrease energy level / Fatigue",
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             ApplicationSizing.verticalSpacer(n: 5),
  //             Container(
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Expanded(
  //                     child: IsChallengeChecked(
  //                       isChecked: false,
  //                       pressChecked: () {  },
  //                       challengeName: "Thinking or memory problems",
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             ApplicationSizing.verticalSpacer(n: 5),
  //             Container(
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Expanded(
  //                     flex: 1,
  //                     child: IsChallengeChecked(
  //                       isChecked: false,
  //                       pressChecked: () {  },
  //                       challengeName: "Spiritual issues",
  //                     ),
  //                   ),
  //                   Expanded(
  //                     flex: 1,
  //                     child: IsChallengeChecked(
  //                       isChecked: carePlanVM.carePlanModel?.concernedAboutFamilyIssues??false,
  //                       pressChecked: () {  },
  //                       challengeName: "Family issues",
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             ApplicationSizing.verticalSpacer(n: 5),
  //             Container(
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Expanded(
  //                     child: IsChallengeChecked(
  //                       isChecked: false,
  //                       pressChecked: () {  },
  //                       challengeName: "End of life issues",
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             ApplicationSizing.verticalSpacer(),
  //             Container(
  //               child: Text("Other Comments",
  //                 style: Styles.PoppinsRegular(
  //                     fontWeight: FontWeight.w500,
  //                     fontSize: ApplicationSizing.fontScale(16),
  //                     color: fontGrayColor
  //                 ),
  //               ),
  //             ),
  //             Container(
  //               margin: EdgeInsets.symmetric(
  //                   horizontal: 5,
  //                   vertical: 5
  //               ),
  //               child: CustomTextArea(
  //                 onchange: (val){}, onSubmit: (val){},
  //                 isEnable: false,
  //                 hints: "Comments..",
  //                 textEditingController: carePlanVM.concernedAboutOtherController,
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //
  //     ],
  //   );
  // }
  advanceDirectivesSection({required CarePlanVM carePlanVM}) {
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
                        "Advance Directives Section",
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
        YesNoQuestion(
          pressNo: () {},
          pressYes: () {},
          isChecked: carePlanVM.carePlanModel?.advancedDirectivesPlans ?? false,
          question: "Are your Advanced Directives Plans in place?",
          disableComment: true,
        ),
        ApplicationSizing.verticalSpacer(),
        YesNoQuestion(
          pressNo: () {},
          pressYes: () {},
          isChecked: carePlanVM.carePlanModel?.discussWithPhysician ?? false,
          question:
              "Would you like to discuss this further with your physician?",
          textEditingController: carePlanVM.discussWithPhysicianController,
        ),
        ApplicationSizing.verticalSpacer(),
      ],
    );
  }

  _goals({required CarePlanVM carePlanVM}) {
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
                  "How satisfied I am with the current medical care",
                  style: Styles.PoppinsRegular(
                    fontWeight: FontWeight.w500,
                    fontSize: ApplicationSizing.fontScale(16),
                  ),
                ),
              ),
              RatingBarIndicator(
                rating: carePlanVM.carePlanModel?.satisfactionWithMedicalCare
                        ?.toDouble() ??
                    0.0,
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
                  textEditingController: carePlanVM.satisfactionController,
                ),
              ),
              ApplicationSizing.verticalSpacer(),
              Container(
                child: Text(
                  "I want to improve on",
                  style: Styles.PoppinsRegular(
                    fontWeight: FontWeight.w500,
                    fontSize: ApplicationSizing.fontScale(16),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: CustomTextArea(
                  onchange: (val) {},
                  onSubmit: (val) {},
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

  chronicCondition({required CarePlanVM carePlanVM}) {
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
                        "Chronic Condition",
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
        TextFieldQuestion(
            question: "Chronic Obstructive Pulmonary Disease and Bronchiectasi",
            textEditingController: carePlanVM.chronicObstructiveController),
        ApplicationSizing.verticalSpacer(),
        TextFieldQuestion(
            question: "Asthma",
            textEditingController: carePlanVM.asthmaController),
        ApplicationSizing.verticalSpacer(),
        TextFieldQuestion(
            question: "Depression",
            textEditingController: carePlanVM.depressionController),
      ],
    );
  }
}
