import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twochealthcare/common_widgets/alert_loader.dart';
import 'package:twochealthcare/common_widgets/app_bar_components/appbar_text_style.dart';
import 'package:twochealthcare/common_widgets/app_bar_components/back_button.dart';
import 'package:twochealthcare/common_widgets/custom_appbar.dart';
import 'package:twochealthcare/common_widgets/floating_button.dart';
import 'package:twochealthcare/common_widgets/no_data_inlist.dart';
import 'package:twochealthcare/common_widgets/toggle_button.dart';
import 'package:twochealthcare/models/modalities_models/modalities_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/application_route_service.dart';
import 'package:twochealthcare/services/shared_pref_services.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/rpm_vm/modalities_reading_vm.dart';
import 'package:twochealthcare/views/rpm_view/readings/bg_reading.dart';
import 'package:twochealthcare/views/rpm_view/readings/blood_pressure_reading.dart';
import 'package:twochealthcare/views/rpm_view/readings/dex_com_reading.dart';
import 'package:twochealthcare/views/rpm_view/readings/pulse_ox_reading.dart';
import 'package:twochealthcare/views/rpm_view/readings/weight_reading.dart';

class ModalitiesReading extends HookWidget {
  int paitentId;

  ModalitiesReading({Key? key,this.paitentId = -1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sharedPrefService = useProvider(sharedPrefServiceProvider);
    final modalitiesReadingVM = useProvider(modalitiesReadingVMProvider);
    ApplicationRouteService applicationRouteService =
        useProvider(applicationRouteServiceProvider);
    useEffect(
      () {
        Future.microtask(() async {});
        modalitiesReadingVM.isActiveModality = false;
        modalitiesReadingVM.modalitiesLoading = true;
        modalitiesReadingVM.getModalitiesByUserId();
        return () {
          // Dispose Objects here
        };
      },
      const [],
    );

    return Scaffold(
      primary: false,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(ApplicationSizing.convert(90)),
        child: CustomAppBar(
          leadingIcon: CustomBackButton(),
          color1: Colors.white,
          color2: Colors.white,
          hight: ApplicationSizing.convert(70),
          parentContext: context,
          centerWigets: AppBarTextStyle(
            text: "My Readings",
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingButton(),
      body: _body(
        sharedPrefServices: sharedPrefService,
        modalitiesReadingVM: modalitiesReadingVM,
      ),
    );
  }

  _body(
      {SharedPrefServices? sharedPrefServices,
      ModalitiesReadingVM? modalitiesReadingVM}) {
    return Container(
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                ApplicationSizing.verticalSpacer(n: 20),
                (!modalitiesReadingVM!.modalitiesLoading &&
                        !modalitiesReadingVM.isActiveModality)
                    ? NoData()
                    : Container(
                        child: ListView.separated(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemBuilder: (context, index) {
                              ModalitiesModel modality =
                                  modalitiesReadingVM.modalitiesList[index];
                              return (modality.id == 0 && modality.lastReading == null)
                                  ? Container()
                                  : InkWell(
                                      onTap: () {
                                        if (modality.modality == "BP") {
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  child: BloodPressureReading(
                                                      selectedMonth: modality.month!,
                                                      selectedYear: modality.year!),
                                                  type: PageTransitionType
                                                      .fade));
                                        }
                                        else if (modality.modality == "BG") {
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  child: BGReading(
                                                      selectedMonth: modality.month!,
                                                      selectedYear: modality.year!),
                                                  type: PageTransitionType
                                                      .fade));
                                        }
                                        else if (modality.modality == "WT") {
                                          Navigator.push(context, PageTransition(
                                              child:  WeightReading(
                                                selectedMonth: modality.month!,
                                                selectedYear: modality.year!,
                                              ), type: PageTransitionType.fade));
                                        }
                                        else if (modality.modality == "PO") {
                                          Navigator.push(context, PageTransition(
                                              child:  PulseOxReading(
                                                selectedMonth: modality.month!,
                                                selectedYear: modality.year!,
                                              ), type: PageTransitionType.fade));
                                        }
                                        else if (modality.modality == "CGM") {
                                          Navigator.push(context, PageTransition(
                                              child:  DexcomCGM(patientId: paitentId,), type: PageTransitionType.fade));
                                        }

                                      },
                                      child:  Container(
                                        margin: EdgeInsets.symmetric(
                                          horizontal: ApplicationSizing
                                              .horizontalMargin(),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: ApplicationSizing
                                              .horizontalMargin(),
                                          vertical:
                                              ApplicationSizing.convert(15),
                                        ),
                                        decoration: BoxDecoration(
                                          color: modality.modality == "BP"
                                              ? const Color(0xffFD5C58)
                                              : modality.modality == "BG"
                                                  ? const Color(0xffFFA654)
                                                  : modality.modality == "WT"
                                                      ? const Color(0xff548EFF)
                                                      : modality.modality ==
                                                              "CGM"
                                                          ? const Color(
                                                              0xffBE54FF)
                                                          : const Color(
                                                              0xff23B8B8),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              // color:Colors.amber,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                      child: Text(

                                                        modality.modalityName ??
                                                            "",
                                                        style: Styles.PoppinsBold(

                                                            fontSize:
                                                                ApplicationSizing
                                                                    .fontScale(
                                                                        16),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      // color: Colors.green,
                                                      alignment: Alignment.centerRight,
                                                      child: Text(
                                                          modality.lastReadingDate ?? "",
                                                          textAlign: TextAlign.right,
                                                          style:  TextStyle(
                                                              letterSpacing: 0,
                                                              fontSize: ApplicationSizing.fontScale(10),
                                                              fontWeight:
                                                                  FontWeight.w500,
                                                              color:
                                                                  Colors.white)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical:
                                                      ApplicationSizing.convert(
                                                          0)),
                                              // color:Colors.blueAccent,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                      margin: EdgeInsets.symmetric(
                                                          vertical:
                                                              ApplicationSizing
                                                                  .convert(10)),
                                                      alignment:
                                                          Alignment.center,
                                                      child: SvgPicture.asset(
                                                        modality.modality ==
                                                                "BP"
                                                            ? "assets/icons/readings/heart-icon.svg"
                                                            : modality.modality ==
                                                                    "BG"
                                                                ? "assets/icons/readings/blood-glucose-icon.svg"
                                                                : modality.modality ==
                                                                        "WT"
                                                                    ? "assets/icons/readings/weight-icon.svg"
                                                                    : modality.modality ==
                                                                            "CGM"
                                                                        ? "assets/icons/readings/blood-glucose-icon.svg"
                                                                    : modality.modality ==
                                                                          "PO" ? "assets/icons/readings/pulse-oximeter.svg"
                                                                        : "assets/icons/readings/blood-glucose-icon.svg",
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 5,
                                                    child: Container(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          RichText(
                                                              text: TextSpan(
                                                                  children: [
                                                                TextSpan(
                                                                  text: modality
                                                                          .lastReading ??
                                                                      "",
                                                                  style: Styles.PoppinsBold(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w800,
                                                                      fontSize:
                                                                          ApplicationSizing.fontScale(25),
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                                TextSpan(
                                                                    text: modality
                                                                            .lastReadingUnit ??
                                                                        "",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            ApplicationSizing.fontScale(
                                                                                10),
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        color: Colors
                                                                            .white)),
                                                              ])),
                                                          // ApplicationSizing.horizontalSpacer(),
                                                          // RichText(
                                                          //     text: TextSpan(
                                                          //       children: [
                                                          //         TextSpan(
                                                          //           text: "90",
                                                          //           style: Styles.PoppinsRegular(
                                                          //             fontWeight: FontWeight.bold,
                                                          //             fontSize: ApplicationSizing.fontScale(30),
                                                          //             color: Colors.white
                                                          //           )
                                                          //         ),
                                                          //         TextSpan(
                                                          //           text: "dia",
                                                          //           style: Styles.PoppinsRegular(
                                                          //             fontSize: ApplicationSizing.fontScale(10),
                                                          //             color: Colors.white
                                                          //           )
                                                          //         ),
                                                          //       ]
                                                          //     )
                                                          // ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              // color: Colors.black,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                      flex: 6,
                                                      child: Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: RichText(
                                                            text: TextSpan(
                                                                children: [
                                                              TextSpan(
                                                                  text: modality
                                                                              .lastReadingContext ==
                                                                          null
                                                                      ? ""
                                                                      : modality.modality ==
                                                                              "BP"
                                                                          ? "Heart Rate : "
                                                                          : "Meal Context : ",
                                                                  style: Styles.PoppinsRegular(
                                                                      fontSize:
                                                                          ApplicationSizing.fontScale(
                                                                              10),
                                                                      color: Colors
                                                                          .white)),
                                                              TextSpan(
                                                                  text: modality
                                                                          .lastReadingContext ??
                                                                      "",
                                                                  style: Styles.PoppinsRegular(
                                                                      fontSize:
                                                                          ApplicationSizing.fontScale(
                                                                              10),
                                                                      color: Colors
                                                                          .white)),
                                                            ])),
                                                      )),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      child: ToggleButton(
                                                        onChange: (val) {},
                                                        value: modality.id == 0
                                                            ? false
                                                            : true,
                                                        // enableColor: modality.id == 0 ? AppBarEndColor : appColor,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                            },
                            separatorBuilder: (context, index) {
                              return Container(
                                height: 15,
                              );
                            },
                            itemCount:
                                modalitiesReadingVM.modalitiesList.length),
                      ),
                ApplicationSizing.verticalSpacer(n: 70),
              ],
            ),
            modalitiesReadingVM.modalitiesLoading ? AlertLoader() : Container(),
          ],
        ),
      ),
    );
  }
}
