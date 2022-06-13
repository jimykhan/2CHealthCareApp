import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:twochealthcare/common_widgets/app_bar_components/appbar_text_style.dart';
import 'package:twochealthcare/common_widgets/app_bar_components/back_button.dart';
import 'package:twochealthcare/common_widgets/buttons/add_button.dart';
import 'package:twochealthcare/common_widgets/custom_appbar.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/views/ccm_view/add_ccm_encounter.dart';
import 'package:twochealthcare/views/open_bottom_modal.dart';
class CcmLogsView extends HookWidget {
  int patientId;
  int ccmmonthlyStatus;
  CcmLogsView({required this.patientId,required this.ccmmonthlyStatus,Key? key}) : super(key: key);


  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {

    useEffect(
          () {

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
            text: "Ccm Logs",
          ),
          leadingIcon: CustomBackButton(),
          color1: Colors.white,
          color2: Colors.white,
          hight: ApplicationSizing.convert(70),
          parentContext: context,
          trailingIcon: AddButton(
            onClick: () {
              openBottomModal(
                  child: AddCCMEncounter(
                patientId: patientId,
                ccmmonthlyStatus: ccmmonthlyStatus,
              ));
          },),
        ),
      ),
      body: Container(),
    );
  }
}
