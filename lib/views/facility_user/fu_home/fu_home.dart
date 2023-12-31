import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twochealthcare/common_widgets/alert_loader.dart';
import 'package:twochealthcare/common_widgets/app_bar_components/appbar_text_style.dart';
import 'package:twochealthcare/common_widgets/bottom_bar.dart';
import 'package:twochealthcare/common_widgets/custom_appbar.dart';
import 'package:twochealthcare/common_widgets/custom_drawer.dart';
import 'package:twochealthcare/common_widgets/app_bar_components/drawer_menu_button.dart';
import 'package:twochealthcare/common_widgets/no_data_inlist.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/view_models/application_package_vm.dart';
import 'package:twochealthcare/view_models/auth_vm/login_vm.dart';
import 'package:twochealthcare/view_models/facility_user_view_model/home/fu_home_view_model.dart';
import 'package:twochealthcare/view_models/home_vm.dart';
import 'package:twochealthcare/views/facility_user/fu_home/components/change_facility_tile.dart';
import 'package:twochealthcare/views/facility_user/fu_home/components/all_facility.dart';
import 'package:twochealthcare/views/facility_user/fu_home/components/service_tile.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/chronic_care.dart';
import 'package:twochealthcare/views/open_bottom_modal.dart';
import 'package:twochealthcare/views/rpm_view/rpm_patients.dart';

import '../../../main.dart';

class FUHome extends HookWidget {
  FUHome({Key? key}) : super(key: key);
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    LoginVM loginVM = useProvider(loginVMProvider);
    HomeVM homeVM = useProvider(homeVMProvider);
    FUHomeViewModel fuHomeViewModel = useProvider(fuHomeVMProvider);
    ApplicationPackageVM _applicationPackageVM = useProvider(applicationPackageVMProvider);
    // SharedPrefServices sharedPrefServices = useProvider(sharedPrefServiceProvider);

    // ApplicationRouteService applicationRouteService =
    // useProvider(applicationRouteServiceProvider);
    // FirebaseService firebaseService = useProvider(firebaseServiceProvider);
    useEffect(
      () {
        _applicationPackageVM.checkForUpdate();
        homeVM.resetHome();
        fuHomeViewModel.isloading = true;
        fuHomeViewModel.patientServicesummary();
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
            text: "Dashboard",
          ),
            facilityIcon: false,
          clickOnNotification: () {},
          notifcationIcon: false,
          leadingIcon: InkWell(
            onTap: () {
              _scaffoldkey.currentState!.openDrawer();
            },
            child: DrawerMenuButton(),
          ),
          color1: Colors.white,
          color2: Colors.white,
          hight: ApplicationSizing.convert(70),
          parentContext: context,
          paddingLeft: 15,
        ),
      ),
      body: _body(context,
          fuHomeViewModel: fuHomeViewModel, homeVM: homeVM, loginVM: loginVM),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        enableFeedback: false,
        child: Container(
          width: 60,
          height: 60,
          padding: EdgeInsets.all(15),
          child: SvgPicture.asset(
            "assets/icons/side_menu/home-icon.svg",
            height: ApplicationSizing.convert(25),
          ),
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0Xff4EAF48), Color(0xff388333)],
              )),
        ),
        onPressed: () {},
      ),
      bottomNavigationBar: BottomBar(
        selectedIndex: 0,
      ),
      drawer: Container(
        width: ApplicationSizing.convertWidth(250),
        child: CustomDrawer(),
      ),
    );
  }

  _body(context,
      {required FUHomeViewModel fuHomeViewModel,
      required HomeVM homeVM,
      required LoginVM loginVM}) {
    return Stack(
      children: [
        Container(
            child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            ChangeFacilityTile(
              onClick: () {
                openBottomModal(
                    child: AllFacility(
                  facilities: fuHomeViewModel.facilities,
                  selectedFacilityId: fuHomeViewModel.currentFacilityId,
                  changeFacility: fuHomeViewModel.switchFacility,
                ));
              },
              loginVM: loginVM,
            ),
            SizedBox(
              height: 15,
            ),
            fuHomeViewModel.dashboardPatientSummary == null
                ? Column(
                    children: [
                      NoData(),
                    ],
                  )
                : Column(
                    children: [
                      ServiceTile(
                        onclick: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: ChronicCare(),
                                  type: PageTransitionType.bottomToTop));
                        },
                        serviceName: "CCM",
                        total: fuHomeViewModel.dashboardPatientSummary
                                ?.ccmActivePatientsCount ??
                            0,
                        completed: fuHomeViewModel.dashboardPatientSummary
                                ?.ccmTimeCompletedPatientsCount ??
                            0,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ServiceTile(
                        onclick: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: RpmPatients(),
                                  type: PageTransitionType.bottomToTop));
                        },
                        serviceName: "RPM",
                        total: fuHomeViewModel.dashboardPatientSummary
                                ?.rpmActivePatientsCount ??
                            0,
                        completed: fuHomeViewModel.dashboardPatientSummary
                                ?.rpmTimeCompletedPatientsCount ??
                            0,
                        Tcompleted: fuHomeViewModel.dashboardPatientSummary
                                ?.rpmTransmissionCompletedPatientsCount ??
                            0,
                        isRpm: true,
                      ),
                    ],
                  ),
          ],
        )),
        (fuHomeViewModel.isloading) ? AlertLoader() : Container(),
      ],
    );
  }
}
