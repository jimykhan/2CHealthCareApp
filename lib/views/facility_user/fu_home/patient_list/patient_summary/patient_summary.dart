import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twochealthcare/common_widgets/app_bar_components/appbar_text_style.dart';
import 'package:twochealthcare/common_widgets/app_bar_components/back_button.dart';
import 'package:twochealthcare/common_widgets/custom_appbar.dart';
import 'package:twochealthcare/models/facility_user_models/dashboard_patients/patients_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/ccm_vm/ccm_logs_vm.dart';
import 'package:twochealthcare/view_models/facility_user_view_model/fu_patient_summary_veiw_models/fu_patient_summary_view_model.dart';
import 'package:twochealthcare/views/ccm_view/add_ccm_encounter.dart';
import 'package:twochealthcare/views/ccm_view/ccm_logs_view.dart';
import 'package:twochealthcare/views/rpm_view/add_rpm_encounter.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/patient_summary/components/custom_icon_button.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/patient_summary/components/sliderMenu.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/patient_summary/components/user_info_tile.dart';
import 'package:twochealthcare/views/open_bottom_modal.dart';

class PatientSummary extends HookWidget {
  PatientsModel patientsModel;
  PatientSummary({required this.patientsModel, Key? key}) : super(key: key);
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    FUPatientSummaryVM fuPatientSummaryVM =
        useProvider(fUPatientSummaryVMProvider);
    fuPatientSummaryVM.summaryPatientsModel = patientsModel;
    useEffect(
      () {
        fuPatientSummaryVM.onMenuChange(0);
        fuPatientSummaryVM.isLoading = false;
        Future.microtask(() async {});
        return () {};
      },
      const [],
    );
    return Scaffold(
      primary: false,
      backgroundColor: Colors.white,
      key: _scaffoldkey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(ApplicationSizing.convert(90)),
        child: CustomAppBar(
          centerWigets: AppBarTextStyle(
            text: "Patient Summary",
          ),
          leadingIcon: CustomBackButton(),
          color1: Colors.white,
          color2: Colors.white,
          hight: ApplicationSizing.convert(70),
          parentContext: context,
        ),
      ),
      body: Container(
        child: Column(
          children: [
            UserInfoTile(
              patientsModel: patientsModel,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: ApplicationSizing.horizontalMargin(),
                  vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: CustomIconButton(
                      onClick: () {
                        Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop,
                            child: CcmLogsView(
                                patientId: fuPatientSummaryVM.patientInfo?.id ?? 0,
                                ccmmonthlyStatus: fuPatientSummaryVM
                                        .patientInfo?.ccmMonthlyStatus ??
                                    0,
                            )));
                        // openBottomModal(
                        //     child: AddCCMEncounter(
                        //   patientId: fuPatientSummaryVM.patientInfo?.id ?? 0,
                        //   ccmmonthlyStatus: fuPatientSummaryVM
                        //           .patientInfo?.ccmMonthlyStatus ??
                        //       0,
                        // ));
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: CustomIconButton(
                      onClick: () {

                        openBottomModal(
                            child: AddRPMEncounter(
                          patientId: fuPatientSummaryVM.patientInfo?.id ?? 0,
                        ));
                      },
                      text: "RPM",
                      bgColor: appColorSecondary,
                      fontColor: whiteColor,
                    ),
                  ),
                ],
              ),
            ),
            SliderMenu(
              menu: fuPatientSummaryVM.patientSummaryMenuList,
              onMenuClick: fuPatientSummaryVM.onMenuChange,
            ),
            Expanded(
              child: SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: selectedBody(fuPatientSummaryVM)),
            )
          ],
        ),
      ),
    );
  }

  Widget selectedBody(FUPatientSummaryVM fuPatientSummaryVM) {
    Widget body = Container();
    fuPatientSummaryVM.patientSummaryMenuList.forEach((element) {
      if (element.isSelected) {
        body = element.body;
      }
    });
    return body;
  }
}
