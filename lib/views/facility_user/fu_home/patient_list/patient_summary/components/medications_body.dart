import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/common_widgets/alert_loader.dart';
import 'package:twochealthcare/common_widgets/no_data_inlist.dart';
import 'package:twochealthcare/models/patient_summary/madication_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/facility_user_view_model/fu_patient_summary_veiw_models/fu_patient_summary_view_model.dart';
import 'package:twochealthcare/views/rpm_view/add_rpm_encounter.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/patient_summary/components/common_container.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/patient_summary/components/headline_text_style.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/patient_summary/components/costom_url_launcher.dart';
import 'package:twochealthcare/views/home/components/widgets.dart';
import 'package:twochealthcare/views/open_bottom_modal.dart';

class MedicationsBody extends HookWidget {
  MedicationsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FUPatientSummaryVM _fuPatientSummaryVM =
        useProvider(fUPatientSummaryVMProvider);
    useEffect(
      () {
        print("init call of medications");
        Future.microtask(() async {
          await _fuPatientSummaryVM.getMedicationByPatientId();
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
            text: "Medication Records",
          ),
          SizedBox(
            height: 15,
          ),
          Stack(
            children: [
              _fuPatientSummaryVM.isLoading
                  ? AlertLoader(bottomMargin: 350)
                  : _fuPatientSummaryVM.medicationList.length == 0
                      ? NoData()
                      : ListView.separated(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemBuilder: (context, index) {
                            return medicineTile(
                                medicationModel:
                                    _fuPatientSummaryVM.medicationList[index],
                                fuPatientSummaryVM: _fuPatientSummaryVM);
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 10,
                            );
                          },
                          itemCount: _fuPatientSummaryVM.medicationList.length)
            ],
          ),
        ],
      ),
    );
  }

  medicineTile(
      {required MedicationModel medicationModel,
      FUPatientSummaryVM? fuPatientSummaryVM}) {
    return CommonContainer(
      horizontalPadding: 8,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 4,
              child: Container(
                // color: Colors.green,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            medicationModel.medicationName ?? "",
                            style: Styles.PoppinsRegular(
                                fontWeight: FontWeight.w500,
                                fontSize: ApplicationSizing.constSize(14),
                                color: Colors.black),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            openBottomModalDisableDrag(
                                child: CostomUrlLauncher(
                              url:  medicationModel.medlineUrl??""
                                  "",
                            ));
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: SvgPicture.asset(
                                  "assets/icons/medicine_info_icon.svg")),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      // color: Colors.blueGrey,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              // color: Colors.red,
                              child: Row(
                                children: [
                                  Text(
                                    "Start date: ",
                                    style: Styles.PoppinsRegular(
                                      fontSize: ApplicationSizing.constSize(10),
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      medicationModel.startDate ?? "",
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "End date: ",
                                    style: Styles.PoppinsRegular(
                                      fontSize: ApplicationSizing.constSize(10),
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      medicationModel.stopDate ?? "",
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
                        ],
                      ),
                    )
                  ],
                ),
              )),
          Expanded(
              flex: 1,
              child: Container(
                  // color: Colors.pink,
                  child: Column(
                children: [
                  Text(
                    medicationModel.dose ?? "5",
                    style: Styles.PoppinsRegular(
                        fontWeight: FontWeight.w500,
                        fontSize: ApplicationSizing.constSize(12)),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Dose",
                    style: Styles.PoppinsRegular(
                        fontWeight: FontWeight.w500,
                        fontSize: ApplicationSizing.constSize(14),
                        color: appColor),
                  ),
                  medicationModel.status == null || medicationModel.status == ""
                      ? Container()
                      : Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: appColor),
                          child: Text(
                            medicationModel.status ?? "",
                            style: Styles.PoppinsRegular(
                                fontWeight: FontWeight.w500,
                                fontSize: ApplicationSizing.constSize(7),
                                color: whiteColor),
                          ),
                        ),
                ],
              ))),
        ],
      ),
    );
  }
}
