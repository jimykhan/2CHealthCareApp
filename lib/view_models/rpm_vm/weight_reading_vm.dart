import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twochealthcare/models/modalities_models/gb_reading_model.dart';
import 'package:twochealthcare/models/rpm_models/weight_reading_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:twochealthcare/services/rpm_services/rpm_service.dart';
import 'package:twochealthcare/util/data_format.dart';
import 'package:twochealthcare/view_models/rpm_vm/tab_and_calender_vm.dart';

class WeightReadingVM extends ChangeNotifier{
  double weightMaxLimit = 100;
  List<WeightReadingModel> weightReadings = [];
  bool weightReadingLoading = true;
  AuthServices? _authService;
  // BGReadingService? _bGReadingService;
  RpmService? _rpmService;
  TabAndCalenderVM? _tabAndCalenderVM;
  ProviderReference? _ref;

  WeightReadingVM({ProviderReference? ref}){
    _ref = ref;
    initService();
  }
  initService(){
    _authService = _ref!.read(authServiceProvider);
    _rpmService = _ref!.read(rpmServiceProvider);
    _tabAndCalenderVM = _ref!.read(tabAndCalenderVMProvider);
    _tabAndCalenderVM!.newDateRange.listen((value) {
      if(value.modality == "WT"){
        getWeightReading(startDate: value.startDate, endDate: value.endDate);
      }
    });

  }
  initialState({required int readingMonth, required int readingYear}){
    _tabAndCalenderVM!.initialState(readingMonth: readingMonth, readingYear: readingYear,modality: "WT");
    DateTime startDate = DateTime(readingYear,readingMonth,1);
    DateTime endDate = DateTime(readingYear,readingMonth,countMonthDays(year: readingYear,month: readingMonth));
    getWeightReading(startDate: startDate,endDate: endDate);
  }
  getWeightReading({DateTime? startDate, DateTime? endDate})async{
    int id  = await _authService!.getCurrentUserId();
    setweightReadingLoading(true);
    var res = await _rpmService?.getWeightReading(currentUserId: id,
        startDate: startDate,endDate: endDate);
    if(res is List){
      weightReadings = [];
      res.forEach((element){
        weightReadings.add(element);
      });
      weightReadings.forEach((element) {
        if(weightMaxLimit < element.weightValue!){
          weightMaxLimit = element.weightValue!;
        }
      });
      setweightReadingLoading(false);
    }
    else{
      weightReadings = [];
      setweightReadingLoading(false);
    }
    setweightReadingLoading(false);

  }
  setweightReadingLoading(bool f){
    weightReadingLoading = f;
    notifyListeners();
  }
}