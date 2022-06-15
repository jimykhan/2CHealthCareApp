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
import 'package:twochealthcare/models/rpm_models/rpm_logs_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/view_models/ccm_vm/ccm_logs_vm.dart';
import 'package:twochealthcare/view_models/rpm_vm/rpm_log_vm.dart';
import 'package:twochealthcare/views/ccm_view/add_ccm_encounter.dart';
import 'package:twochealthcare/views/open_bottom_modal.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:twochealthcare/views/rpm_view/add_rpm_encounter.dart';
class RpmLogsView extends HookWidget {
  int patientId;
  RpmLogsView({required this.patientId,Key? key}) : super(key: key);


  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    RpmLogsVM rpmLogsVM = useProvider(rpmLogsVMProvider);

    useEffect(
          () {
        rpmLogsVM.initScreen(patientId: patientId);
        Future.microtask(() async {
           rpmLogsVM.getRpmLogsByPatientId(patientid: patientId);
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
            text: "Rpm Logs",
          ),
          leadingIcon: CustomBackButton(),
          color1: Colors.white,
          color2: Colors.white,
          hight: ApplicationSizing.convert(70),
          parentContext: context,
          trailingIcon: AddButton(
            onClick: () {
              openBottomModal(
                  child: AddRPMEncounter(
                patientId: patientId,
              ));
          },),
        ),
      ),
      body:_body(rpmLogsVM: rpmLogsVM),
    );
  }
  _body(
      {required RpmLogsVM rpmLogsVM}) {
    return Container(
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                MonthYearPickerButton(
                  onClick: rpmLogsVM.monthYear,
                  buttonText: rpmLogsVM.currentLogsDateView,
                ),
                ApplicationSizing.verticalSpacer(n: 10),
                (!rpmLogsVM.loading &&
                    rpmLogsVM.rpmLogs.length == 0)
                    ? NoData()
                    : Container(
                  child: ListView.separated(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (context, index) {
                       return  EncouterTile(
                           providerName: rpmLogsVM.rpmLogs[index].facilityUserName,
                           date: rpmLogsVM.rpmLogs[index].encounterDate,
                           startTime: rpmLogsVM.rpmLogs[index].startTime,
                           endTime: rpmLogsVM.rpmLogs[index].endTime,
                           duration: rpmLogsVM.rpmLogs[index].duration,
                           serviceType: rpmLogsVM.rpmLogs[index].rpmServiceTypeString,
                           notes: rpmLogsVM.rpmLogs[index].note,
                         onEdit: () => rpmLogsVM.EditEncounter(rpmEncounter: rpmLogsVM.rpmLogs[index],patientId: patientId),
                       );
                      },
                      separatorBuilder: (context, index) {
                        return Container(
                          height: 10,
                        );
                      },
                      itemCount:
                      rpmLogsVM.rpmLogs.length ),
                ),
                ApplicationSizing.verticalSpacer(),
              ],
            ),
            rpmLogsVM.loading ? AlertLoader() : Container(),
          ],
        ),
      ),
    );
  }


}


