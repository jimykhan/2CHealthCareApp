import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/patient_profile_service.dart';
import 'package:twochealthcare/services/rpm_services/cgm_services.dart';
import 'package:twochealthcare/services/settings_services/p_settings_services/p_settings_service.dart';
import 'package:twochealthcare/util/data_format.dart';

class PSettingsViewModel extends ChangeNotifier{
  bool getBlueButtonUrlLoading = false;
  bool isBlueButtonConnected = false;
  bool loadingSettings = false;
  ProviderReference? _ref;
  /// Services
  PSettingsService? _pSettingsService;
  CGMService? _cgmService;

  /// Services


  /// DexCom
  bool isDexComConnect = false;
  bool getDexComUrlLoading = false;
  /// DexCom

  initState(){
    isBlueButtonConnected = false;
    getBlueButtonUrlLoading = false;
    getDexComUrlLoading = false;
    loadingSettings  = true;
  }

  PSettingsViewModel({ProviderReference? ref}){
    _ref = ref;
    initService();
  }

  initService(){
    _pSettingsService = _ref?.read(pSettingsServiceProvider);
    _cgmService = _ref?.read(cgmServiceProvider);
  }
  setGetBlueButtonUrlLoading(check){
    getBlueButtonUrlLoading = check;
    notifyListeners();
  }

  setGetDexComUrlLoading(check){
    getDexComUrlLoading = check;
    notifyListeners();
  }

  setLoadingSetting(check){
    loadingSettings = check;
    notifyListeners();
  }

  checkPatientDeviceState() async {
    try{
      await checkIsBlueBottonConnected();
      await checkIsDexComConnected();
      setLoadingSetting(false);
      notifyListeners();
    }catch(ex){
      setLoadingSetting(false);
      notifyListeners();
    }

  }

  checkIsBlueBottonConnected()async{
    isBlueButtonConnected  = await _pSettingsService?.checkIsBlueBottonConnected()?? false;
    // if(response){
    //   isBlueButtonConnected = true;
    // }else{
    //   isBlueButtonConnected = false;
    // }
  }

  checkIsDexComConnected() async{
    isDexComConnect = await _cgmService?.checkDexComAuthByPatientId()?? false;
    print(isDexComConnect);
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

  dexComAutherizations()async{
    setGetDexComUrlLoading(true);
    var response  = await _cgmService?.dexcomAutherizations();
    if(response != null && response is String){
      setGetDexComUrlLoading(false);
      launchURL(url: response);
    }else{
      setGetDexComUrlLoading(false);
    }
  }


}