import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/common_widgets/alert_loader.dart';
import 'package:twochealthcare/common_widgets/no_data_inlist.dart';
import 'package:twochealthcare/common_widgets/verification_mark.dart';
import 'package:twochealthcare/models/patient_summary/allergy_model.dart';
import 'package:twochealthcare/models/patient_summary/diagnose_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/facility_user_view_model/fu_patient_summary_veiw_models/fu_patient_summary_view_model.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/patient_summary/components/common_container.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/patient_summary/components/headline_text_style.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/patient_summary/components/matline_plus.dart';
import 'package:twochealthcare/views/open_bottom_modal.dart';

class DiagnosisBody extends HookWidget {
  DiagnosisBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FUPatientSummaryVM _fuPatientSummaryVM = useProvider(fUPatientSummaryVMProvider);
    useEffect(

          () {
        print("init call of allegies");
        Future.microtask(() async {
          await _fuPatientSummaryVM.getDiagnosisByPatientId();
        });
        return () {};
      },
      const [],
    );
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: ApplicationSizing.horizontalMargin()),
      width: MediaQuery.of(context).size.width,
      // color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeadLineTextStyle(
            text: "Diagnosis",
          ),
          Stack(
            children: [
              _fuPatientSummaryVM.isLoading
                  ? AlertLoader(bottomMargin: 350)
                  : _fuPatientSummaryVM.diagnoseList.length == 0 ? NoData()
                  : ListView.separated(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),

                  itemBuilder: (context,index){
                    return diagnoseTile(diagnoseModel: _fuPatientSummaryVM.diagnoseList[index]);
                  },
                  separatorBuilder: (context,index){
                    return SizedBox(height: 10,);
                  },
                  itemCount: _fuPatientSummaryVM.diagnoseList.length)
            ],
          ),
        ],
      ),
    );
  }

  diagnoseTile({required DiagnoseModel diagnoseModel}) {
    return CommonContainer(
      horizontalPadding: 8,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  flex: 5,
                  child: Container(
                    // color: Colors.green,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              diagnoseModel.icdCode?? "",
                              style: Styles.PoppinsRegular(
                                  fontWeight: FontWeight.w500,
                                  fontSize: ApplicationSizing.constSize(18),
                                  color: Colors.black),
                            ),
                            InkWell(
                              onTap: () {
                                openBottomModalDisableDrag(
                                    child: MadLinePlus(
                                      url: diagnoseModel.medlineUrl??"",
                                    ));
                              },
                              child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: SvgPicture.asset(
                                      "assets/icons/medicine_info_icon.svg")),
                            )
                            // Container(
                            //     padding: EdgeInsets.symmetric(horizontal: 10),
                            //     child: SvgPicture.asset(
                            //         "assets/icons/medicine_info_icon.svg"))
                          ],
                        ),

                      ],
                    ),
                  )),
              Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: appColorSecondary),
                        child: Text(
                          diagnoseModel.isChronic?? false ? "InActive" :"Active",
                          style: Styles.PoppinsRegular(
                              fontWeight: FontWeight.w500,
                              fontSize: ApplicationSizing.constSize(8),
                              color: whiteColor),
                        ),
                      ),
                    ],
                  ),
              ),
            ],
          ),
          SizedBox(height:2,),
          Row(
            children: [
              Expanded(
                  flex: 9,
                  child: Container(
                    // color: Colors.green,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                diagnoseModel.description?? "",
                                style: Styles.PoppinsRegular(
                                    fontWeight: FontWeight.w500,
                                    fontSize: ApplicationSizing.constSize(10),
                                    color: fontGrayColor),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Notes :",
                              style: Styles.PoppinsRegular(
                                  fontWeight: FontWeight.w500,
                                  fontSize: ApplicationSizing.constSize(10),
                                  color: fontGrayColor),
                            ),
                            Expanded(
                              child: Text(
                                diagnoseModel.note?? "",
                                style: Styles.PoppinsRegular(
                                    fontWeight: FontWeight.w500,
                                    fontSize: ApplicationSizing.constSize(10),
                                    color: fontGrayColor),
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  )),
              Expanded(
                flex: 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Is CCM",
                          style: Styles.PoppinsRegular(
                              fontWeight: FontWeight.w500,
                              fontSize: ApplicationSizing.constSize(10),
                              color: appColor),
                        ),
                        VerificationMark(isVerified: diagnoseModel.isOnCcm?? false,),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Is RPM",
                          style: Styles.PoppinsRegular(
                              fontWeight: FontWeight.w500,
                              fontSize: ApplicationSizing.constSize(10),
                              color: appColor),
                        ),
                        VerificationMark(isVerified: diagnoseModel.isOnRpm?? false,),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height:2,),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  // color: Colors.red,
                  child: Row(
                    children: [
                      Text(
                        "Diagnose date: ",
                        style: Styles.PoppinsRegular(
                          fontSize: ApplicationSizing.constSize(10),
                          fontWeight: FontWeight.w500,
                          color: appColorSecondary,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          diagnoseModel.diagnosisDate??"",
                          style: Styles.PoppinsRegular(
                            fontSize: ApplicationSizing.constSize(10),
                            fontWeight: FontWeight.w500,
                            color: appColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.centerRight,
                  // color: Colors.blue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Resolved date: ",
                        style: Styles.PoppinsRegular(
                          fontSize: ApplicationSizing.constSize(10),
                          fontWeight: FontWeight.w500,
                          color: appColorSecondary,
                        ),
                      ),
                      Text(
                        diagnoseModel.resolvedDate??"",
                        style: Styles.PoppinsRegular(
                          fontSize: ApplicationSizing.constSize(10),
                          fontWeight: FontWeight.w500,
                          color: appColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}