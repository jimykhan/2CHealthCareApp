import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twochealthcare/common_widgets/alert_loader.dart';
import 'package:twochealthcare/common_widgets/app_bar_components/back_button.dart';
import 'package:twochealthcare/common_widgets/buttons/icon_button.dart';
import 'package:twochealthcare/common_widgets/custom_appbar.dart';
import 'package:twochealthcare/common_widgets/input_field/custom_text_field.dart';
import 'package:twochealthcare/common_widgets/no_data_inlist.dart';
import 'package:twochealthcare/common_widgets/page_with_floating_button.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/view_models/home_vm.dart';
import 'package:twochealthcare/view_models/rpm_vm/rpm_patients_vm.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/components/patient_filter.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/components/patient_list.dart';
import 'package:twochealthcare/views/open_bottom_modal.dart';
class RpmPatients extends HookWidget {
  RpmPatients({Key? key}) : super(key: key);
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    HomeVM homeVM = useProvider(homeVMProvider);
    RpmPatientsVM rpmPatientsVM = useProvider(rpmPatientsVMProvider);
    useEffect(
          () {
        homeVM.resetHome();
        rpmPatientsVM.isloading = true;
        rpmPatientsVM.patientListPageNumber = 1;
        rpmPatientsVM.chronicCarePatients = null;
        rpmPatientsVM.getRpmPatients();
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
          leadingIcon: CustomBackButton(),
          color1: Colors.white,
          color2: Colors.white,
          hight: ApplicationSizing.convert(70),
          parentContext: context,
        ),
      ),
      body: _body(rpmPatientsVM: rpmPatientsVM, homeVM: homeVM),
    );
  }

  _body({required RpmPatientsVM rpmPatientsVM, required HomeVM homeVM}) {
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
                      onchange: rpmPatientsVM.onSearch,
                      onSubmit: (val) {},
                      hints: "Search Patients",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SqureIconButton(onClick: () {
                    openBottomModal(child: PatientsFilter(onChange: rpmPatientsVM.setCareProviderFilter,
                      filterSelected: rpmPatientsVM.careFacilitorId,));
                  }),
                ],
              ),
            ),
            Expanded(
              child: PageWithFloatingButton(
                  container: Column(
                    children: [
                      Expanded(
                        child: ((rpmPatientsVM.chronicCarePatients?.patientsList!
                            .length ==
                            0 ||
                            rpmPatientsVM.chronicCarePatients == null) && !(rpmPatientsVM.isloading))
                            ? NoData()
                            : PatientList(
                          scrollController: rpmPatientsVM.scrollController,
                          lastIndexLoading: rpmPatientsVM.newPageLoading,
                          patientsList: rpmPatientsVM
                              .chronicCarePatients?.patientsList ??
                              [],
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
        (rpmPatientsVM.isloading || homeVM.homeScreenLoading)
            ? AlertLoader()
            : Container(),
      ],
    );
  }
}
