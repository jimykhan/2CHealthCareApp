import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:twochealthcare/models/modalities_models/blood_pressure_reading_model.dart';
import 'package:twochealthcare/models/rpm_models/pulse_ox_reading_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:twochealthcare/services/rpm_services/blood_pressure_reading_service.dart';
import 'package:twochealthcare/services/rpm_services/rpm_service.dart';
import 'package:twochealthcare/util/data_format.dart';
import 'package:twochealthcare/view_models/rpm_vm/tab_and_calender_vm.dart';
class PulseOxReadingVM extends ChangeNotifier{
  double bloodOxygenMaxLimit = 100;
  double bloodHeartRateMaxLimit = 100;
  List<PulseOxReadingModel> pulseOxreadings = [];
  bool bOReadingLoading = true;

  AuthServices? _authService;
  TabAndCalenderVM? _tabAndCalenderVM;
  RpmService? _rpmService;
  ProviderReference? _ref;

  PulseOxReadingVM({ProviderReference? ref}){
    _ref = ref;
    initService();
  }
  initialState({required int readingMonth, required int readingYear}){
    _tabAndCalenderVM!.initialState(readingMonth: readingMonth, readingYear: readingYear,modality: "PO");
    DateTime startDate = DateTime(readingYear,readingMonth,1);
    DateTime endDate = DateTime(readingYear,readingMonth,countMonthDays(year: readingYear,month: readingMonth));
    getBloodOxReading(startDate: startDate,endDate: endDate);
  }
  initService(){
    _authService = _ref!.read(authServiceProvider);
    _rpmService = _ref!.read(rpmServiceProvider);
    _tabAndCalenderVM = _ref!.read(tabAndCalenderVMProvider);
    _tabAndCalenderVM!.newDateRange.listen((value) {
      if(value.modality == "PO"){
        getBloodOxReading(startDate: value.startDate, endDate: value.endDate);
      }
    });

  }

  getBloodOxReading({DateTime? startDate, DateTime? endDate})async{
    int id  = await _authService!.getCurrentUserId();
    setbOReadingLoading(true);
    var res = await _rpmService?.getPulseOxReading(currentUserId: id,
        startDate: startDate,endDate: endDate);
    if(res is List){
      pulseOxreadings = [];
      res.forEach((element){
        pulseOxreadings.add(element);
      });
      pulseOxreadings.forEach((element) {
        if(bloodOxygenMaxLimit < element.bloodOxygen!){
          bloodOxygenMaxLimit = element.bloodOxygen!;
        }
        if(bloodHeartRateMaxLimit < element.heartRate!){
          bloodHeartRateMaxLimit = element.heartRate!;
        }
      });
      setbOReadingLoading(false);
    }else{
      pulseOxreadings = [];
      setbOReadingLoading(false);
    }
    setbOReadingLoading(false);

  }

  setbOReadingLoading(bool f){
    bOReadingLoading = f;
    notifyListeners();
  }

}