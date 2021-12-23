import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/models/profile_models/current_user_info_model.dart';
import 'package:twochealthcare/models/profile_models/paitent_care_providers_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:twochealthcare/services/profile_service.dart';
import 'package:twochealthcare/services/shared_pref_services.dart';

class ProfileVm extends ChangeNotifier{
  bool loading = true;
  CurrentUserInfo? currentUserInfo;
  List<PatientCareProvider> patientCareProvider = [];
  AuthServices? _authService;
  ProfileService? _profileService;
  SharedPrefServices? _sharedPrefServices;
  ProviderReference? _ref;

  ProfileVm({ProviderReference? ref}){
    _ref = ref;
    initService();
  }
  initService(){
    _authService = _ref!.read(authServiceProvider);
    _profileService = _ref!.read(profileServiceProvider);
    _sharedPrefServices = _ref!.read(sharedPrefServiceProvider);

  }
  setLoading(bool f){
    loading = f;
    notifyListeners();
  }

  Future<dynamic> getUserInfo() async {
    try{
      int userId = await _authService!.getCurrentUserId();
      setLoading(true);
      var res = await _profileService!.getUserInfo(currentUserId: userId);
      var res1 = await _profileService!.getCareProvider(currentUserId: userId);
      if(res1 is List<PatientCareProvider>){
        patientCareProvider = [];
        res1.forEach((element) {
          patientCareProvider.add(element);
        });
      }
      if(res is CurrentUserInfo){
        currentUserInfo = res;
        _sharedPrefServices!.setPatientInfo(res);
        setLoading(false);
      }else{
        setLoading(false);
      }
    }
    catch(e){
      setLoading(false);
      print(e.toString());
    }

  }

}