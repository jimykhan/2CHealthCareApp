import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twochealthcare/common_widgets/alert_loader.dart';
import 'package:twochealthcare/common_widgets/bottom_bar.dart';
import 'package:twochealthcare/common_widgets/custom_appbar.dart';
import 'package:twochealthcare/common_widgets/custom_drawer.dart';
import 'package:twochealthcare/common_widgets/input_field/custom_text_field.dart';
import 'package:twochealthcare/common_widgets/app_bar_components/drawer_menu_button.dart';
import 'package:twochealthcare/common_widgets/no_data_inlist.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/view_models/auth_vm/login_vm.dart';
import 'package:twochealthcare/view_models/facility_user_view_model/home/fu_home_view_model.dart';
import 'package:twochealthcare/view_models/home_vm.dart';
import 'package:twochealthcare/views/facility_user/fu_home/home_screen_components/all_facility.dart';
import 'package:twochealthcare/views/facility_user/fu_home/home_screen_components/change_facility_tile.dart';
import 'package:twochealthcare/views/facility_user/fu_home/home_screen_components/service_tile.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/all_patient.dart';
import 'package:twochealthcare/views/open_bottom_modal.dart';

import '../../../main.dart';

class FUHome extends HookWidget {
  FUHome({Key? key}) : super(key: key);
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    // LoginVM loginVM = useProvider(loginVMProvider);
    HomeVM homeVM = useProvider(homeVMProvider);
    FUHomeViewModel fuHomeViewModel = useProvider(fuHomeVMProvider);

    // ApplicationRouteService applicationRouteService =
    // useProvider(applicationRouteServiceProvider);
    // FirebaseService firebaseService = useProvider(firebaseServiceProvider);
    useEffect(
          () {
            homeVM.resetHome();
            fuHomeViewModel.loadingPatientList = true;
            fuHomeViewModel.patientListPageNumber = 1;
            fuHomeViewModel.getPatientsForDashboard();
        Future.microtask(() async {});
        return () {};
      },
      const [],
    );
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldkey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(ApplicationSizing.convert(80)),
        child: CustomAppBar(
          notifcationIcon: true,
          leadingIcon: InkWell(
            onTap: () {
              _scaffoldkey.currentState!.openDrawer();
            },
            child: DrawerMenuButton(),
          ),
          color1: Colors.white,
          color2: Colors.white,
          hight: ApplicationSizing.convert(80),
          parentContext: context,
          paddingLeft: 15,
        ),
      ),
      body: _body(fuHomeViewModel: fuHomeViewModel,homeVM: homeVM),
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
                  colors: [Color(0Xff4EAF48), Color(0xff60E558)])),
        ),
        onPressed: () {
        },
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

  _body({required FUHomeViewModel fuHomeViewModel,required HomeVM homeVM}){
    return Stack(
      children: [
        Container(
          child: fuHomeViewModel.patientsForDashboard?.patientsList!.length == 0 ? Column(
            children:  [
              NoData(),
            ],
          ):
          Column(
            children: [
              ChangeFacilityTile(onClick: () {
                openBottomModal(child: AllFacility());
              },),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                      applicationContext!.currentContext!,
                      PageTransition(
                          child: AllPatient(),
                          type: PageTransitionType.bottomToTop));
                },
                child:ServiceTile(),
              )
            ],
          )
        ),
        (fuHomeViewModel.loadingPatientList || homeVM.homeScreenLoading) ? AlertLoader() : Container(),
      ],
    );
  }

}