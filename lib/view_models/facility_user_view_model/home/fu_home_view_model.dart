import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/models/facility_user_models/dashboard_patients/dashboard_patient_summary.dart';
import 'package:twochealthcare/models/facility_user_models/dashboard_patients/patients_for_dashboard.dart';
import 'package:twochealthcare/models/facility_user_models/facilityModel/facility_model.dart';
import 'package:twochealthcare/models/user/current_user.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/facility_user_services/facility_service.dart';
import 'package:twochealthcare/services/shared_pref_services.dart';

class FUHomeViewModel extends ChangeNotifier{
  int currentFacilityId = 0;
  DashboardPatientSummary? dashboardPatientSummary;
  List<FacilityModel> facilities = [];
  ProviderReference? _ref;
  FacilityService? facilityService;
  int dashboardSummaryMonth = DateTime.now().month;
  int dashboardSummaryYear = DateTime.now().year;
  bool isloading = true;
  SharedPrefServices? _sharedPrefServices ;
  FUHomeViewModel({ProviderReference? ref}){
    _ref = ref;
    initService();
  }
  initService(){
    facilityService = _ref!.read(facilityServiceProvider);
    _sharedPrefServices = _ref!.read(sharedPrefServiceProvider);
  }
  setLoading(check){
    isloading = check;
    notifyListeners();
  }

  patientServicesummary({int? month,int? year}) async{
    int facilityId = await _sharedPrefServices!.getFacilityId();
    currentFacilityId = facilityId;
    var res = await facilityService?.patientServicesummary(facilityId : facilityId, month: dashboardSummaryMonth,year: dashboardSummaryYear);
    if(res!=null && res is DashboardPatientSummary){
      dashboardPatientSummary = res;
      setLoading(false);
    }else{
      setLoading(false);
    }
  }

  getFacilitiesByUserId() async{
    var res = await facilityService?.getFacilitiesByUserId();
    if(res!=null){
      facilities = [];
      res.forEach((element) {
        facilities.add(element);
      });
    }else{
    }
  }

  switchFacility(facilityId)async{
    Navigator.pop(applicationContext!.currentContext!);
    print("facility Id ${facilityId}");
    setLoading(true);
    var res = await facilityService?.switchFacility(facilityId : facilityId);
    patientServicesummary();
  }

}