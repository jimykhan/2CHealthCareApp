import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:twochealthcare/common_widgets/CustomMonthYearPicker.dart';
import 'package:twochealthcare/constants/strings.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/models/rpm_models/rpm_logs_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/rpm_services/rpm_service.dart';
import 'package:twochealthcare/views/open_bottom_modal.dart';
import 'package:twochealthcare/views/rpm_view/add_rpm_encounter.dart';

class RpmLogsVM extends ChangeNotifier{
  int currentPatienId = 0;
  List<RpmLogModel> rpmLogs = [];
  DateTime? currentLogsDate;
  String currentLogsDateView = "Please Choose Date";
  RpmService? _rpmService;
  ProviderReference? _ref;
  bool loading = false;
  RpmLogsVM({ProviderReference? ref}){

    _ref = ref;
    initService();
  }
  initService(){
    _rpmService = _ref!.read(rpmServiceProvider);
  }
  initScreen({int? patientId}){
    currentPatienId = patientId??0;
    rpmLogs = [];
    currentLogsDate = null;
    currentLogsDateView = "Please Choose Date";
  }

  void EditEncounter({required RpmLogModel rpmEncounter,required int patientId}) {
    print("work");
    openBottomModal(
        child: AddRPMEncounter(
          patientId: patientId,
          rpmEncounter: rpmEncounter,
        ));
  }

  setLoading(check){
    loading = check;
    notifyListeners();
  }
  getRpmLogsByPatientId({int? patientid})async{
    setLoading(true);
    int month = 0;
    int year = 0;
    if(currentLogsDate != null){
      month = currentLogsDate!.month;
      year = currentLogsDate!.year;
    }
    var response =  await _rpmService?.getRpmLogsByPatientId(patientId: patientid,month: month,year: year);
    if(response != null && response is List<RpmLogModel>){
      rpmLogs = response;
    }
    setLoading(false);
  }
  monthYear(){
    return DatePicker.showPicker(applicationContext!.currentContext!,
        showTitleActions: true,
        pickerModel: CustomMonthPicker(
            currentTime: currentLogsDate?? DateTime.now(),
            minTime: DateTime(2018, 1, 1),
            maxTime: DateTime(2030, 1, 1),
            locale: LocaleType.en),
        onChanged: (date) {
          print('change $date');
        }, onConfirm: (date) {
          currentLogsDate = date;
          currentLogsDateView = Jiffy(date).format(Strings.MonthYear);
          getRpmLogsByPatientId(patientid: currentPatienId);
          notifyListeners();
          print('confirm $date');
        }
    );
  }

}