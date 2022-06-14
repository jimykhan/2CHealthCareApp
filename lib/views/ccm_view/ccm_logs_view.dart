import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twochealthcare/common_widgets/CustomMonthYearPicker.dart';
import 'package:twochealthcare/common_widgets/alert_loader.dart';
import 'package:twochealthcare/common_widgets/app_bar_components/appbar_text_style.dart';
import 'package:twochealthcare/common_widgets/app_bar_components/back_button.dart';
import 'package:twochealthcare/common_widgets/buttons/add_button.dart';
import 'package:twochealthcare/common_widgets/buttons/month_year_picker_button.dart';
import 'package:twochealthcare/common_widgets/custom_appbar.dart';
import 'package:twochealthcare/common_widgets/encounter_tile.dart';
import 'package:twochealthcare/common_widgets/no_data_inlist.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/view_models/ccm_vm/ccm_logs_vm.dart';
import 'package:twochealthcare/views/ccm_view/add_ccm_encounter.dart';
import 'package:twochealthcare/views/open_bottom_modal.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
class CcmLogsView extends HookWidget {
  int patientId;
  int ccmmonthlyStatus;
  CcmLogsView({required this.patientId,required this.ccmmonthlyStatus,Key? key}) : super(key: key);


  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    CcmLogsVM ccmLogsVM = useProvider(ccmLogsVMProvider);

    useEffect(
          () {
        ccmLogsVM.initScreen(patientId: patientId);
        Future.microtask(() async {
           ccmLogsVM.getCcmLogsByPatientId(patientid: patientId);
        });
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
      body:_body(ccmLogsVM: ccmLogsVM),
    );
  }
  _body(
      {required CcmLogsVM ccmLogsVM}) {
    return Container(
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                MonthYearPickerButton(
                  onClick: ccmLogsVM.monthYear,
                  buttonText: ccmLogsVM.currentLogsDateView,
                ),
                ApplicationSizing.verticalSpacer(n: 10),
                (!ccmLogsVM.loading &&
                    ccmLogsVM.ccmlogs.ccmEncountersList?.length == 0)
                    ? NoData()
                    : Container(
                  child: ListView.separated(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (context, index) {
                       return  EncouterTile(
                           providerName: ccmLogsVM.ccmlogs.ccmEncountersList![index].careProviderName,
                           date: ccmLogsVM.ccmlogs.ccmEncountersList![index].encounterDate,
                           startTime: ccmLogsVM.ccmlogs.ccmEncountersList![index].startTime,
                           endTime: ccmLogsVM.ccmlogs.ccmEncountersList![index].endTime,
                           duration: ccmLogsVM.ccmlogs.ccmEncountersList![index].duration,
                           serviceType: ccmLogsVM.ccmlogs.ccmEncountersList![index].ccmServiceType,
                           notes: ccmLogsVM.ccmlogs.ccmEncountersList![index].note,
                         onEdit: () => ccmLogsVM.EditEncounter(ccmEncounters: ccmLogsVM.ccmlogs.ccmEncountersList![index],patientId: patientId),
                       );
                      },
                      separatorBuilder: (context, index) {
                        return Container(
                          height: 10,
                        );
                      },
                      itemCount:
                      ccmLogsVM.ccmlogs.ccmEncountersList?.length ?? 0),
                ),
                ApplicationSizing.verticalSpacer(),
              ],
            ),
            ccmLogsVM.loading ? AlertLoader() : Container(),
          ],
        ),
      ),
    );
  }


}


