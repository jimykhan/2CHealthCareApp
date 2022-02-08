import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/common_widgets/alert_loader.dart';
import 'package:twochealthcare/common_widgets/back_button.dart';
import 'package:twochealthcare/common_widgets/bottom_bar.dart';
import 'package:twochealthcare/common_widgets/custom_appbar.dart';
import 'package:twochealthcare/common_widgets/custom_drawer.dart';
import 'package:twochealthcare/common_widgets/custom_text_field.dart';
import 'package:twochealthcare/common_widgets/no_data_inlist.dart';
import 'package:twochealthcare/common_widgets/page_with_floating_button.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/view_models/auth_vm/login_vm.dart';
import 'package:twochealthcare/view_models/facility_user_view_model/home/fu_home_view_model.dart';
import 'package:twochealthcare/view_models/home_vm.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/components/patient_list.dart';

import 'components/filter_button.dart';

class AllPatient extends HookWidget {
  AllPatient({Key? key}) : super(key: key);
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

          leadingIcon: CustomBackButton(),
          color1: Colors.white,
          color2: Colors.white,
          hight: ApplicationSizing.convert(80),
          parentContext: context,
        ),
      ),
      body: _body(fuHomeViewModel: fuHomeViewModel,homeVM: homeVM),
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
            PageWithFloatingButton(container:
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
                          onchange: (val){

                          },
                          onSubmit: (val){

                          },
                        ),
                      ),
                      SizedBox(width: 5,),
                      FilterButton(),
                    ],
                  ),
                ),
                Expanded(
                  child: PatientList(scrollController: fuHomeViewModel.scrollController, lastIndexLoading: fuHomeViewModel.newPageLoading, patientsList: fuHomeViewModel.patientsForDashboard?.patientsList??[],),
                ),
              ],
            )
            )
        ),
        (fuHomeViewModel.loadingPatientList || homeVM.homeScreenLoading) ? AlertLoader() : Container(),
      ],
    );
  }

}