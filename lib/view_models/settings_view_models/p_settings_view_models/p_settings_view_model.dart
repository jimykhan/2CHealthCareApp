import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/patient_profile_service.dart';
import 'package:twochealthcare/services/settings_services/p_settings_services/p_settings_service.dart';
import 'package:twochealthcare/util/data_format.dart';

class PSettingsViewModel extends ChangeNotifier{
  bool getBlueButtonUrlLoading = false;
  bool isBlueButtonConnected = false;
  bool loadingSettings = false;
  ProviderReference? _ref;
  PSettingsService? _pSettingsService;
  PSettingsViewModel({ProviderReference? ref}){
    _ref = ref;
    initService();
  }
  initService(){
    _pSettingsService = _ref?.read(pSettingsServiceProvider);
  }
  setGetBlueButtonUrlLoading(check){
    getBlueButtonUrlLoading = check;
    notifyListeners();
  }

  setLoadingSetting(check){
    loadingSettings = check;
    notifyListeners();
  }
  checkIsBlueBottonConnected()async{
    bool response  = await _pSettingsService?.checkIsBlueBottonConnected()?? false;
    if(response){
      isBlueButtonConnected = true;
    }else{
      isBlueButtonConnected = false;
    }
    setLoadingSetting(false);
    notifyListeners();
  }
  initState(){
    isBlueButtonConnected = false;
    getBlueButtonUrlLoading = false;
    loadingSettings  = true;
  }
  blueButtonAutherizations()async{
    setGetBlueButtonUrlLoading(true);
    var response  = await _pSettingsService?.blueButtonAutherizations();
    if(response != null){
      setGetBlueButtonUrlLoading(false);
       launchURL(url: response.data);
    }else{
      setGetBlueButtonUrlLoading(false);
    }
  }
}