import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/common_widgets/appbar_text_style.dart';
import 'package:twochealthcare/common_widgets/back_button.dart';
import 'package:twochealthcare/common_widgets/custom_appbar.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/view_models/facility_user_view_model/fu_patient_summary_veiw_models/fu_patient_summary_view_model.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/patient_summary/components/sliderMenu.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/patient_summary/components/user_info_tile.dart';
class PatientSummary extends HookWidget {
  PatientSummary({Key? key}) : super(key: key);
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    // LoginVM loginVM = useProvider(loginVMProvider);
    // HomeVM homeVM = useProvider(homeVMProvider);
    FUPatientSummaryVM fuPatientSummaryVM = useProvider(fUPatientSummaryVMProvider);

    // ApplicationRouteService applicationRouteService =
    // useProvider(applicationRouteServiceProvider);
    // FirebaseService firebaseService = useProvider(firebaseServiceProvider);
    useEffect(
          () {
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
            centerWigets: AppBarTextStyle(
          text: "Patient Summary",
        ),
          leadingIcon: CustomBackButton(),
          color1: Colors.white,
          color2: Colors.white,
          hight: ApplicationSizing.convert(80),
          parentContext: context,
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              UserInfoTile(),
              ApplicationSizing.verticalSpacer(),
              SliderMenu(menu: fuPatientSummaryVM.patientSummaryMenuList,
              onMenuClick: fuPatientSummaryVM.onMenuChange,),
            ],
          ),
        ),
      ),
    );
  }
}
