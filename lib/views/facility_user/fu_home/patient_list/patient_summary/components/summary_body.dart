import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
    FUPatientSummaryVM _fuPatientSummaryVM = useProvider(fUPatientSummaryVMProvider);
    useEffect(
          () {
        print("init call of Patient Summary");
        Future.microtask(() async {
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
          Container(
            padding: EdgeInsets.symmetric(vertical: 20,horizontal: 15),
            decoration: BoxDecoration(
              border: Border.all(
                color: fontGrayColor.withOpacity(0.3),
              ),
              borderRadius: BorderRadius.circular(15)
            ),
            child: Column(
              children: [
                keyValue(key: "Phone No.",value: _fuPatientSummaryVM.summaryPatientsModel?.primaryPhoneNumber??""),
                keyValue(key: "Secondary No.",value: _fuPatientSummaryVM.summaryPatientsModel?.primaryPhoneNumber??""),
                keyValue(key: "Date of Birth",value: _fuPatientSummaryVM.summaryPatientsModel?.dateOfBirth??""),
              ],
            ),
          )
        ],
      ),
    );
  }

  keyValue({required String key,required String value}){
    return Container(
      padding: EdgeInsets.only(bottom: 5,top: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: fontGrayColor.withOpacity(0.3)
          )
        )
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: appColorSecondary.withOpacity(0.3),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(key,style: Styles.PoppinsRegular(
              color: appColorSecondary,
              fontSize: 14
            ),),
          ),

        ],
      ),
    );
  }
}
