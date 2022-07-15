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
import 'package:twochealthcare/view_models/facility_user_view_model/chronic_care_view_model.dart';
import 'package:twochealthcare/view_models/facility_user_view_model/home/fu_home_view_model.dart';
import 'package:twochealthcare/view_models/home_vm.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/components/patient_filter.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/components/patient_list.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/patient_summary/components/custom_icon_button.dart';
import 'package:twochealthcare/views/open_bottom_modal.dart';

class ChronicCare extends HookWidget {
  ChronicCare({Key? key}) : super(key: key);
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    HomeVM homeVM = useProvider(homeVMProvider);
    ChronicCareVM chronicCareVM = useProvider(fuChronicCareVMProvider);
    // ApplicationRouteService applicationRouteService =
    // useProvider(applicationRouteServiceProvider);
    // FirebaseService firebaseService = useProvider(firebaseServiceProvider);
    useEffect(
      () {
        homeVM.resetHome();
        chronicCareVM.isloading = true;
        chronicCareVM.patientListPageNumber = 1;
        chronicCareVM.chronicCarePatients = null;
        chronicCareVM.getPatients2();
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
      body: _body(chronicCareVM: chronicCareVM, homeVM: homeVM),
    );
  }

  _body({required ChronicCareVM chronicCareVM, required HomeVM homeVM}) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.only(bottom: 24),
              // height: 80,
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      checkFocus: (val){},
                      onchange: chronicCareVM.onSearch,
                      onSubmit: (val) {},
                      hints: "Search Patients",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SqureIconButton(onClick: () {
                    openBottomModal(child: PatientsFilter(onChange: chronicCareVM.setCareProviderFilter,
                      filterSelected: chronicCareVM.careProviderId,));
                  }),
                ],
              ),
            ),
            Expanded(
              child: PageWithFloatingButton(
                  container: Column(
                children: [
                  Expanded(
                    child: ((chronicCareVM.chronicCarePatients?.patientsList!
                                    .length ==
                                0 ||
                            chronicCareVM.chronicCarePatients == null) && !(chronicCareVM.isloading))
                        ? NoData()
                        : PatientList(
                            scrollController: chronicCareVM.scrollController,
                            lastIndexLoading: chronicCareVM.newPageLoading,
                            patientsList: chronicCareVM
                                    .chronicCarePatients?.patientsList ??
                                [],
                          ),
                  ),
                ],
              )),
            ),
          ],
        ),
        (chronicCareVM.isloading || homeVM.homeScreenLoading)
            ? AlertLoader()
            : Container(),
      ],
    );
  }
}
