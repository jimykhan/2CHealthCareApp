import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:twochealthcare/common_widgets/alert_loader.dart';
import 'package:twochealthcare/common_widgets/no_data_inlist.dart';
import 'package:twochealthcare/constants/validator.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/facility_user_view_model/fu_patient_summary_veiw_models/fu_patient_summary_view_model.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/patient_summary/components/headline_text_style.dart';

class SummaryBody extends HookWidget {
  SummaryBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FUPatientSummaryVM _fuPatientSummaryVM =
        useProvider(fUPatientSummaryVMProvider);
    useEffect(
      () {
        print("init call of Patient Summary");
        Future.microtask(() async {
          await _fuPatientSummaryVM.getPatientInfoById();
        });
        return () {};
      },
      const [],
    );
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: ApplicationSizing.horizontalMargin()),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeadLineTextStyle(
            text: "Patient Summary",
          ),
          SizedBox(
            height: 15,
          ),
          Stack(
            children: [
              _fuPatientSummaryVM.isLoading
                  ? AlertLoader(bottomMargin: 350)
                  : _fuPatientSummaryVM.patientInfo == null
                      ? NoData()
                      : Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 15),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: fontGrayColor.withOpacity(0.3),
                              ),
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            children: [
                              keyValue(
                                  key:  "Phone No.",
                                  value: mask.getMaskedString(_fuPatientSummaryVM
                                      .patientInfo?.homePhone ??
                                      "")),
                              keyValue(
                                  key: "Secondary No.",
                                  value: mask.getMaskedString(_fuPatientSummaryVM
                                      .patientInfo?.emergencyContactSecondaryPhoneNo ??
                                      "")),
                              keyValue(
                                  key: "Date of Birth",
                                  value: _fuPatientSummaryVM
                                          .patientInfo?.dateOfBirth ??
                                      ""),
                              keyValue(
                                  key:  "Billing Provider",
                                  value: _fuPatientSummaryVM
                                      .patientInfo?.billingProviderName ??
                                      ""),
                              keyValue(
                                  key:  "Care Provider",
                                  value: _fuPatientSummaryVM
                                      .patientInfo?.careFacilitatorName ??
                                      ""),
                              keyValue(
                                  key:  "Insurance Plan",
                                  value: _fuPatientSummaryVM
                                      .patientInfo?.insurancePlanName ??
                                      ""),
                            ],
                          ),
                        )
            ],
          ),
        ],
      ),
    );
  }

  keyValue({required String key, required String value}) {
    return Container(
      padding: EdgeInsets.only(bottom: 10, top: 10),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: fontGrayColor.withOpacity(0.3)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
            decoration: BoxDecoration(
              color: Color.fromRGBO(70, 141, 255, 0.27),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              key,
              style:
                  Styles.PoppinsRegular(color: Color(0xff002F73), fontSize: 14),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                value,
                style:
                    Styles.PoppinsRegular(color: Color(0xff4EAF48), fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
