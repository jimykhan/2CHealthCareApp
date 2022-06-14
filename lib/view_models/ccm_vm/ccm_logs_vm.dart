import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:twochealthcare/common_widgets/CustomMonthYearPicker.dart';
import 'package:twochealthcare/constants/strings.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/models/ccm_model/ccm_logs_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/ccm_services/ccm_services.dart';
import 'package:twochealthcare/views/ccm_view/add_ccm_encounter.dart';
import 'package:twochealthcare/views/open_bottom_modal.dart';

class CcmLogsVM extends ChangeNotifier{
  int currentPatienId = 0;
  CcmLogs ccmlogs = CcmLogs()..ccmEncountersList = [];
  DateTime? currentLogsDate;
  String currentLogsDateView = "Please Choose Date";
  CcmService? _ccmService;
  ProviderReference? _ref;
  bool loading = false;
  CcmLogsVM({ProviderReference? ref}){

    _ref = ref;
    initService();
  }
  initService(){
    _ccmService = _ref!.read(ccmServiceProvider);
  }
  initScreen({int? patientId}){
    currentPatienId = patientId??0;
    ccmlogs.ccmEncountersList = [];
    currentLogsDate = null;
    currentLogsDateView = "Please Choose Date";
  }

  void EditEncounter({required CcmEncountersList ccmEncounters,required int patientId}) {
    print("work");
    openBottomModal(
        child: AddCCMEncounter(
          patientId: patientId,
          ccmmonthlyStatus: 2,
          ccmEncounters: ccmEncounters,
        ));
  }

  setLoading(check){
    loading = check;
    notifyListeners();
  }
  getCcmLogsByPatientId({int? patientid})async{
    setLoading(true);
    int month = 0;
    int year = 0;
    if(currentLogsDate != null){
      month = currentLogsDate!.month;
      year = currentLogsDate!.year;
    }
    var response =  await _ccmService?.getCcmLogsByPatientId(patientId: patientid,month: month,year: year);
    if(response != null && response is CcmLogs){
     ccmlogs = response;
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
          getCcmLogsByPatientId(patientid: currentPatienId);
          notifyListeners();
          print('confirm $date');
        }
    );
  }

}