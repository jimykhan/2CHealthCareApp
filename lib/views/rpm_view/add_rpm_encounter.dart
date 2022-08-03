import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
import 'package:twochealthcare/models/rpm_models/rpm_logs_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/rpm_vm/rpm_encounter_vm.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/patient_summary/components/encounters_components/change_billing_provider.dart';

class AddRPMEncounter extends HookWidget {
  int patientId;
  RpmLogModel? rpmEncounter;
  AddRPMEncounter({this.rpmEncounter,Key? key, required this.patientId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RpmEncounterVM _rmpEncounterVM = useProvider(rpmEncounterVMProvider);
    useEffect(
      () {
        _rmpEncounterVM.addEncounterLoader = false;
        _rmpEncounterVM.initialState(rpmEncounter: rpmEncounter);
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
            text: "Add Rpm Encounter",
          ),
          leadingIcon: CrossIconButton(
            onClick: () {
              Navigator.pop(context);
            },
          ),
          trailingIcon: _rmpEncounterVM.addEncounterLoader
              ? SimpleLoader()
              : TickIconButton(
            color: _rmpEncounterVM.isFormValid ? appColor : fontGrayColor,
            onClick: _rmpEncounterVM.isFormValid
                ? () {
              rpmEncounter != null ? _rmpEncounterVM.editRpmEncounter(patientId: patientId, rpmEncounterId: rpmEncounter!.id!) : _rmpEncounterVM.addRpmEncounter(patientId: patientId);
            }
                : null,
          ),
          addLeftMargin: true,
          color1: Colors.white,
          color2: Colors.white,
          hight: ApplicationSizing.convert(70),
          parentContext: context,

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
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    // height: MediaQuery.of(context).size.height - 270,
                    child: Column(
                      children: [
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
                                      onchange: _rmpEncounterVM.formValidation,
                                      onSubmit: _rmpEncounterVM.formValidation,
                                      hints: 'Date',
                                      isEnable: false,
                                      textStyle: Styles.hintStyle(),
                                      textEditingController:
                                          _rmpEncounterVM.dateController,
                                    )),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    SqureIconButton(
                                      onClick: () {
                                        _rmpEncounterVM.pickDateTime(context);
                                      },
                                      svgPictureUrl:
                                          "assets/icons/calendar.svg",
                                    ),
                                  ],
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
                                title: 'Duration',
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 1),
                                child: CustomTextField(
                                  checkFocus: (val){},
                                  textEditingController:
                                      _rmpEncounterVM.durationController,
                                  textInputType: TextInputType.number,
                                  onchange: _rmpEncounterVM.formValidation,
                                  onSubmit: _rmpEncounterVM.formValidation,
                                  hints: 'Duration In Minutes',
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
                                title: 'Service Type',
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 1),
                                child: DropDownButton(
                                  dropDownValue:
                                      _rmpEncounterVM.selecteServiceType,
                                  onChange: (String? value) {
                                    print("${value}");
                                    _rmpEncounterVM.selecteServiceType =
                                        value ?? "";
                                    _rmpEncounterVM.notifyListeners();
                                  },
                                  menuList: _rmpEncounterVM.serviceType,
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
                                  textEditingController:
                                      _rmpEncounterVM.notesController,
                                  onchange: _rmpEncounterVM.formValidation,
                                  onSubmit: _rmpEncounterVM.formValidation,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  // color: Colors.blue,
                                  child: Row(
                                    children: [
                                      Text(
                                        "Current Billing Provider:",
                                        style: Styles.PoppinsRegular(
                                          fontSize: ApplicationSizing.constSize(12),
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "${_rmpEncounterVM.selectedBillingProvider?.firstName??""} ${_rmpEncounterVM.selectedBillingProvider?.lastName??""}",
                                          style: Styles.PoppinsRegular(
                                              fontSize: ApplicationSizing.constSize(12),
                                              fontWeight: FontWeight.w700,
                                              color: fontGrayColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                onTap: (){
                                  GenerateAlert(child: ChangeBillingProvider());
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(width: 1.5,color: appColor)
                                      )
                                  ),
                                  child: Text(
                                    "Change Provider",
                                    style: Styles.PoppinsRegular(
                                        fontSize: ApplicationSizing.constSize(11),
                                        fontWeight: FontWeight.w700,
                                        color: appColor
                                    ),
                                  ),
                                ),
                              ),
                              // Expanded(
                              //   flex: 1,
                              //   child: Container(
                              //     alignment: Alignment.center,
                              //     decoration: BoxDecoration(
                              //       border: Border(
                              //         bottom: BorderSide(width: 1.5,color: appColor)
                              //       )
                              //     ),
                              //     child: Text(
                              //       "Change Provider",
                              //       style: Styles.PoppinsRegular(
                              //         fontSize: ApplicationSizing.constSize(11),
                              //         fontWeight: FontWeight.w700,
                              //         color: appColor
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: Row(
                            children: [
                              CustomCheckButton(
                                ontap: _rmpEncounterVM.setIsProviderRpm,
                                isChecked: _rmpEncounterVM.isProviderRpm,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "CPT 99091",
                                style: Styles.PoppinsRegular(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
            // Container(
            //   margin: EdgeInsets.symmetric(vertical: 20),
            //   // color: Colors.amber,
            //   alignment: Alignment.bottomCenter,
            //   child: Row(
            //     children: [
            //       Expanded(
            //         flex: 1,
            //         child: FilledButton(
            //           onTap: () {
            //             GenerateAlert(child: ChangeBillingProvider());
            //           },
            //           color1: appColorSecondary,
            //           borderColor: appColorSecondary,
            //           txt: "change provider".toUpperCase(),
            //           paddingLeftRight: 0,
            //           fontsize: 13,
            //         ),
            //       ),
            //       SizedBox(
            //         width: 10,
            //       ),
            //       Expanded(
            //           flex: 1,
            //           child: _rmpEncounterVM.addEncounterLoader
            //               ? SimpleLoader()
            //               : FilledButton(
            //             onTap: _rmpEncounterVM.isFormValid
            //                 ? () {
            //               _rmpEncounterVM.addRpmEncounter(
            //                   patientId: patientId);
            //             }
            //                 : null,
            //             color1: _rmpEncounterVM.isFormValid
            //                 ? appColor
            //                 : appColorLight,
            //             borderColor: _rmpEncounterVM.isFormValid
            //                 ? appColor
            //                 : appColorLight,
            //             txt: "Add encounter".toUpperCase(),
            //             paddingLeftRight: 0,
            //             fontsize: 13,
            //           )),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
