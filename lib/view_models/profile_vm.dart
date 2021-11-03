import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/models/profile_models/current_user_info_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:twochealthcare/services/profile_service.dart';

class ProfileVm extends ChangeNotifier{
  bool loading = true;
  CurrentUserInfo? currentUserInfo;
  AuthServices? _authService;
  ProfileService? _profileService;
  ProviderReference? _ref;

  ProfileVm({ProviderReference? ref}){
    _ref = ref;
    initService();
  }
  initService(){
    _authService = _ref!.read(authServiceProvider);
    _profileService = _ref!.read(profileServiceProvider);

  }
  setLoading(bool f){
    loading = f;
    notifyListeners();
  }

  Future<dynamic> getUserInfo({int? currentUserId}) async {
    try{
      int userId = await _authService!.getCurrentUserId();
      setLoading(true);
      var res = await _profileService!.getUserInfo(currentUserId: userId);
      if(res is CurrentUserInfo){
        currentUserInfo = res;
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