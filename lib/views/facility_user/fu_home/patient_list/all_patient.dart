import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/common_widgets/alert_loader.dart';
import 'package:twochealthcare/common_widgets/app_bar_components/back_button.dart';
import 'package:twochealthcare/common_widgets/bottom_bar.dart';
import 'package:twochealthcare/common_widgets/buttons/icon_button.dart';
import 'package:twochealthcare/common_widgets/custom_appbar.dart';
import 'package:twochealthcare/common_widgets/custom_drawer.dart';
import 'package:twochealthcare/common_widgets/input_field/custom_text_field.dart';
import 'package:twochealthcare/common_widgets/no_data_inlist.dart';
import 'package:twochealthcare/common_widgets/page_with_floating_button.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/view_models/auth_vm/login_vm.dart';
import 'package:twochealthcare/view_models/facility_user_view_model/all_patient_view_model.dart';
import 'package:twochealthcare/view_models/facility_user_view_model/home/fu_home_view_model.dart';
import 'package:twochealthcare/view_models/home_vm.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/components/patient_filter.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/components/patient_list.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/patient_summary/components/custom_icon_button.dart';
import 'package:twochealthcare/views/open_bottom_modal.dart';

class AllPatient extends HookWidget {
  AllPatient({Key? key}) : super(key: key);
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    // LoginVM loginVM = useProvider(loginVMProvider);
    HomeVM homeVM = useProvider(homeVMProvider);
    // FUHomeViewModel fuHomeViewModel = useProvider(fuHomeVMProvider);
    AllPatientVM allPatientVM = useProvider(fuAllPatientVM);

    // ApplicationRouteService applicationRouteService =
    // useProvider(applicationRouteServiceProvider);
    // FirebaseService firebaseService = useProvider(firebaseServiceProvider);
    useEffect(
      () {
        homeVM.resetHome();
        allPatientVM.isloading = true;
        allPatientVM.patientListPageNumber = 1;
        allPatientVM.patientsForDashboard = null;
        allPatientVM.getPatientsForDashboard();
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
          facilityIcon: true,
          leadingIcon: CustomBackButton(),
          color1: Colors.white,
          color2: Colors.white,
          hight: ApplicationSizing.convert(70),
          parentContext: context,
        ),
      ),
      body: _body(allPatientVM: allPatientVM, homeVM: homeVM),
    );
  }

  _body({required AllPatientVM allPatientVM, required HomeVM homeVM}) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              padding: EdgeInsets.only(bottom: 24),
              // height: 80,
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      checkFocus: (val){},
                      onchange: allPatientVM.onSearch,
                      onSubmit: (val) {},
                      hints: "Search Patients",
                    ),
                  ),
                  // SizedBox(width: 5,),
                  // SqureIconButton(onClick: () {
                  //   openBottomModal(
                  //       child: PatientsFilter()
                  //   );
                  // }),
                ],
              ),
            ),
            Expanded(
              child: PageWithFloatingButton(
                  container: Column(
                children: [
                  Expanded(
                    child: ((allPatientVM.patientsForDashboard?.patientsList!.length == 0 || allPatientVM.patientsForDashboard == null) && !(allPatientVM.isloading))
                        ? NoData()
                        : PatientList(
                            scrollController: allPatientVM.scrollController,
                            lastIndexLoading: allPatientVM.newPageLoading,
                            patientsList: allPatientVM
                                    .patientsForDashboard?.patientsList ??
                                [],
                          ),
                  ),
                ],
              )),
            ),
          ],
        ),
        (allPatientVM.isloading || homeVM.homeScreenLoading)
            ? AlertLoader()
            : Container(),
      ],
    );
  }
}
