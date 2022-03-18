import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/common_widgets/alert_loader.dart';
import 'package:twochealthcare/common_widgets/no_data_inlist.dart';
import 'package:twochealthcare/common_widgets/verification_mark.dart';
import 'package:twochealthcare/models/patient_summary/allergy_model.dart';
import 'package:twochealthcare/models/patient_summary/diagnose_model.dart';
import 'package:twochealthcare/models/patient_summary/family_history_model.dart';
import 'package:twochealthcare/models/patient_summary/immunization_model.dart';
import 'package:twochealthcare/models/patient_summary/surgical_history_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/facility_user_view_model/fu_patient_summary_veiw_models/fu_patient_summary_view_model.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/patient_summary/components/common_container.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/patient_summary/components/headline_text_style.dart';

class SurgicalHistoryBody extends HookWidget {
  SurgicalHistoryBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FUPatientSummaryVM _fuPatientSummaryVM = useProvider(fUPatientSummaryVMProvider);
    useEffect(

          () {
        print("init call of surgical");
        Future.microtask(() async {
          await _fuPatientSummaryVM.getSurgicalHistoryByPatientId();
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
            text: "Surgical History",
          ),
          Stack(
            children: [
              _fuPatientSummaryVM.isLoading
                  ? AlertLoader()
                  : _fuPatientSummaryVM.surgicalHistoryList.length == 0 ? NoData()
                  : ListView.separated(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),

                  itemBuilder: (context,index){
                    return surgicalHistoryTile(surgicalHistoryModel: _fuPatientSummaryVM.surgicalHistoryList[index]);
                  },
                  separatorBuilder: (context,index){
                    return SizedBox(height: 10,);
                  },
                  itemCount: _fuPatientSummaryVM.surgicalHistoryList.length)
            ],
          ),
        ],
      ),
    );
  }

  surgicalHistoryTile({required SurgicalHistoryModel surgicalHistoryModel}) {
    return CommonContainer(
      horizontalPadding: 8,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                    // color: Colors.green,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              surgicalHistoryModel.surgeonName?? "",
                              style: Styles.PoppinsRegular(
                                  fontWeight: FontWeight.w500,
                                  fontSize: ApplicationSizing.constSize(18),
                                  color: Colors.black),
                            ),
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
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Operated Date: ",
                      style: Styles.PoppinsRegular(
                        fontSize: ApplicationSizing.constSize(10),
                        fontWeight: FontWeight.w500,
                        color: appColorSecondary,
                      ),
                    ),
                    Text(
                      surgicalHistoryModel.dateOperated??"",
                      style: Styles.PoppinsRegular(
                        fontSize: ApplicationSizing.constSize(10),
                        fontWeight: FontWeight.w500,
                        color: appColor,
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
                  child: Container(
                    // color: Colors.green,
                    child: Column(
                      children: [
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
                                surgicalHistoryModel.notes?? "",
                                style: Styles.PoppinsRegular(
                                    fontWeight: FontWeight.w500,
                                    fontSize: ApplicationSizing.constSize(10),
                                    color: fontGrayColor),
                              ),
                            ),
                          ],
                        ),

                        Container(
                          // color: Colors.pink,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "System :",
                                style: Styles.PoppinsRegular(
                                    fontWeight: FontWeight.w500,
                                    fontSize: ApplicationSizing.constSize(12),
                                    color: appColorSecondary),
                              ),
                              Expanded(
                                child: Text(
                                  surgicalHistoryModel.surgicalSystemName?? "",
                                  style: Styles.PoppinsRegular(
                                      fontWeight: FontWeight.w500,
                                      fontSize: ApplicationSizing.constSize(12),
                                      color: appColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // color: Colors.pink,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Procedure :",
                                style: Styles.PoppinsRegular(
                                    fontWeight: FontWeight.w500,
                                    fontSize: ApplicationSizing.constSize(12),
                                    color: appColorSecondary),
                              ),
                              Expanded(
                                child: Text(
                                  surgicalHistoryModel.procedure?? "",
                                  style: Styles.PoppinsRegular(
                                      fontWeight: FontWeight.w500,
                                      fontSize: ApplicationSizing.constSize(12),
                                      color: appColor),
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  )),

            ],
          ),


        ],
      ),
    );
  }
}