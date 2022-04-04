import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/models/facility_user_models/dashboard_patients/patients_for_dashboard.dart';
import 'package:twochealthcare/models/facility_user_models/fu_profile_models/fu_profile_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/facility_user_services/facility_service.dart';

class FUProfileVM extends ChangeNotifier{
  ProviderReference? _ref;
  FacilityService? _facilityService;
  FUProfileModel? fuProfileModel;
  bool loadingProfile = false;
  FUProfileVM({ProviderReference? ref}){
    _ref = ref;
    initService();
  }
  initService(){
    _facilityService = _ref!.read(facilityServiceProvider);
  }
  setLoadingProfie(check){
    loadingProfile = check;
    notifyListeners();
  }
  getFuProfileInfo() async{
    setLoadingProfie(true);
    var res = await _facilityService?.getFuProfileInfo();
    if(res!=null){
      fuProfileModel = res as FUProfileModel?;
      setLoadingProfie(false);
    }else{
      setLoadingProfie(false);
    }
  }


}