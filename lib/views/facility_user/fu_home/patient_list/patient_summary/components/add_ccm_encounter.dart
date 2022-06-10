import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/common_widgets/aler_dialogue.dart';
import 'package:twochealthcare/common_widgets/alert_loader.dart';
import 'package:twochealthcare/common_widgets/app_bar_components/appbar_text_style.dart';
import 'package:twochealthcare/common_widgets/app_bar_components/cross_icon_button.dart';
import 'package:twochealthcare/common_widgets/app_bar_components/tick_icon_button.dart';
import 'package:twochealthcare/common_widgets/buttons/icon_button.dart';
import 'package:twochealthcare/common_widgets/check_button.dart';
import 'package:twochealthcare/common_widgets/custom_appbar.dart';
import 'package:twochealthcare/common_widgets/drop_down/drop_down_button.dart';
import 'package:twochealthcare/common_widgets/filled_button.dart';
import 'package:twochealthcare/common_widgets/input_field/custom_text_erea.dart';
import 'package:twochealthcare/common_widgets/input_field/custom_text_field.dart';
import 'package:twochealthcare/common_widgets/heading_text/text_field_title.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/rpm_vm/ccm_encounter_vm.dart';
import 'package:twochealthcare/view_models/rpm_vm/rpm_encounter_vm.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/patient_summary/components/encounters_components/change_billing_provider.dart';

class AddCCMEncounter extends HookWidget {
  int patientId;
  int ccmmonthlyStatus;
  AddCCMEncounter(
      {Key? key, required this.patientId, required this.ccmmonthlyStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    CcmEncounterVM _ccmEncounterVM = useProvider(ccmEncounterVMProvider);
    useEffect(
      () {
        _ccmEncounterVM.ccmmonthlyStatus = ccmmonthlyStatus;
        _ccmEncounterVM.initialState();
        Future.microtask(() async {});
        return () {};
      },
      const [],
    );
    return Scaffold(
      primary: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(ApplicationSizing.convert(90)),
        child: CustomAppBar(
          centerWigets: AppBarTextStyle(
            text: "Add CCM Encounter",
          ),
          leadingIcon: CrossIconButton(
            onClick: () {
              Navigator.pop(context);
            },
          ),
          color1: Colors.white,
          color2: Colors.white,
          hight: ApplicationSizing.convert(70),
          parentContext: context,
          trailingIcon: _ccmEncounterVM.addEncounterLoader
              ? SimpleLoader()
              : TickIconButton(
                  color: _ccmEncounterVM.isFormValid ? appColor : fontGrayColor,
                  onClick: _ccmEncounterVM.isFormValid
                      ? () {
                          _ccmEncounterVM.addCcmEncounter(patientId: patientId);
                        }
                      : null,
                ),
          addLeftMargin: true,
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: ApplicationSizing.horizontalMargin()),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35), topRight: Radius.circular(35)),
          // color: Colors.pink
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFieldTitle(
                      title: 'Service Name',
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 1),
                      child: DropDownButton(
                        dropDownValue: _ccmEncounterVM.selecteServiceName,
                        onChange: _ccmEncounterVM.onServiceNameChange,
                        menuList: _ccmEncounterVM.ccmserviceName,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFieldTitle(
                      title: 'Date',
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 1),
                      child: Row(
                        children: [
                          Expanded(
                              child: CustomTextField(
                                checkFocus: (val){},
                            onchange: _ccmEncounterVM.formValidation,
                            onSubmit: _ccmEncounterVM.formValidation,
                            hints: 'Date',
                            isEnable: false,
                            textStyle: Styles.hintStyle(),
                            textEditingController:
                                _ccmEncounterVM.dateController,
                          )),
                          SizedBox(
                            width: 8,
                          ),
                          SqureIconButton(
                            onClick: () {
                              _ccmEncounterVM.pickDateTime(context);
                            },
                            svgPictureUrl: "assets/icons/calendar.svg",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFieldTitle(
                              title: 'Start Time',
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 1),
                              child: InkWell(
                                onTap: () {
                                  _ccmEncounterVM.pickTime(context);
                                },
                                child: CustomTextField(
                                  checkFocus: (val){},
                                  textEditingController:
                                      _ccmEncounterVM.startTimeController,
                                  textInputType: TextInputType.number,
                                  onchange: _ccmEncounterVM.formValidation,
                                  onSubmit: _ccmEncounterVM.formValidation,
                                  hints: 'Start Time',
                                  isEnable: false,
                                  textStyle: Styles.hintStyle(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFieldTitle(
                              title: 'End Time',
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 1),
                              child: CustomTextField(
                                checkFocus: (val){},
                                textEditingController:
                                    _ccmEncounterVM.endTimeController,
                                textInputType: TextInputType.number,
                                onchange: _ccmEncounterVM.formValidation,
                                onSubmit: _ccmEncounterVM.formValidation,
                                hints: 'End Time',
                                isEnable: false,
                                bgColor: disableColor,
                                textStyle: Styles.hintStyle(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFieldTitle(
                      title: 'Duration In Minutes',
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 1),
                      child: CustomTextField(
                        checkFocus: (val){},
                        textEditingController:
                            _ccmEncounterVM.durationController,
                        textInputType: TextInputType.number,
                        inputFormatter: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onchange: _ccmEncounterVM.onDurationChange,
                        onSubmit: _ccmEncounterVM.formValidation,
                        hints: '0',
                        textStyle: Styles.hintStyle(),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFieldTitle(
                      title: 'Notes',
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 1),
                      child: CustomTextArea(
                        textEditingController: _ccmEncounterVM.notesController,
                        onchange: _ccmEncounterVM.formValidation,
                        onSubmit: _ccmEncounterVM.formValidation,
                        hints: '',
                        textStyle: Styles.hintStyle(),
                        maxLine: 20,
                        height: 100,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: Row(
                  children: [
                    Text(
                      "Current Provider:",
                      style: Styles.PoppinsRegular(
                        fontSize: ApplicationSizing.constSize(12),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "${_ccmEncounterVM.currentUser?.fullName}",
                      style: Styles.PoppinsRegular(
                          fontSize: ApplicationSizing.constSize(12),
                          fontWeight: FontWeight.w700,
                          color: fontGrayColor),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: disableColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xffFFF3CD),
                ),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                margin: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  "Acknowledge/update monthly status to save",
                  style: Styles.PoppinsRegular(
                      color: Color(0xffA47723),
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Monthly Status :",
                      style: Styles.PoppinsRegular(
                          fontSize: ApplicationSizing.constSize(13),
                          fontWeight: FontWeight.w700,
                          color: fontGrayColor),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                      margin: EdgeInsets.only(top: 1),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: _ccmEncounterVM.selecteMonthlyStatus ==
                                    "Not Started"
                                ? Colors.red
                                : appColor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10)),

                      // width: (_ccmEncounterVM.selecteMonthlyStatus == "Call not answered" || _ccmEncounterVM.selecteMonthlyStatus == "Partially Completed") ? 200 : 100,
                      width: 180,
                      height: 50,
                      child: DropDownButton(
                        dropDownValue: _ccmEncounterVM.selecteMonthlyStatus,
                        hiddingIcon: true,
                        isAlignCenter: true,
                        onChange: _ccmEncounterVM.onMonthlyStatusChange,
                        menuList: _ccmEncounterVM.monthlyStatuses,
                        bgColor: appColor,
                        borderColor: appColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
