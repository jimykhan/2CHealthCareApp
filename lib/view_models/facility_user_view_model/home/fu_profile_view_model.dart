import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/models/facility_user_models/dashboard_patients/patients_for_dashboard.dart';
import 'package:twochealthcare/models/facility_user_models/fu_profile_models/fu_profile_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/facility_user_services/home/fu_home_service.dart';
import 'package:twochealthcare/services/facility_user_services/home/fu_profile_service.dart';

class FUProfileVM extends ChangeNotifier{
  ProviderReference? _ref;
  FUProfileService? _fuProfileService;
  FUProfileModel? fuProfileModel;
  bool loadingProfile = false;
  FUProfileVM({ProviderReference? ref}){
    _ref = ref;
    initService();
  }
  initService(){
    _fuProfileService = _ref!.read(fuProfileServiceProvider);
  }
  setLoadingProfie(check){
    loadingProfile = check;
    notifyListeners();
  }
  getFuProfileInfo() async{
    setLoadingProfie(true);
    var res = await _fuProfileService?.getFuProfileInfo();
    if(res!=null){
      fuProfileModel = res as FUProfileModel?;
      setLoadingProfie(false);
    }else{
      setLoadingProfie(false);
    }
  }
}