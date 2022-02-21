import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/profile_service.dart';
import 'package:twochealthcare/services/settings_services/p_settings_services/p_settings_service.dart';

class PSettingsViewModel extends ChangeNotifier{
  bool isBlueButtonConnected = false;
  ProviderReference? _ref;
  PSettingsService? _pSettingsService;
  PSettingsViewModel({ProviderReference? ref}){
    _ref = ref;
    initService();
  }
  initService(){
    _pSettingsService = _ref?.read(pSettingsServiceProvider);
  }
  checkIsBlueBottonConnected()async{
    isBlueButtonConnected = false;
    bool response  = await _pSettingsService?.checkIsBlueBottonConnected()?? false;
    if(response){
      isBlueButtonConnected = true;
    }else{
      isBlueButtonConnected = false;
    }
    notifyListeners();
  }
  initState(){
    isBlueButtonConnected = false;
  }
  blueButtonAutherizations()async{
    var response  = await _pSettingsService?.blueButtonAutherizations();
    if(response != null){
      // launchURL("");
    }else{

    }
  }
}