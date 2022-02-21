import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:twochealthcare/services/dio_services/dio_services.dart';

class PSettingsService{
  ProviderReference? _ref;
  DioServices? _dioServices;
  AuthServices? _authServices;
  PSettingsService({ProviderReference? ref}){
    _ref = ref;
    initService();
  }
  initService(){
    _authServices = _ref!.read(authServiceProvider);
    _dioServices = _ref!.read(dioServicesProvider);
  }

 Future<bool> checkIsBlueBottonConnected()async{
    bool isConnect = false;
   String appUserId = await _authServices!.getCurrentAppUserId();
    try{
      Response? response  = await _dioServices?.dio?.get(BlueButton.checkBlueButton+"/${appUserId}");
      if(response?.statusCode == 200){
        isConnect = true;
      }else{
        isConnect = false;
      }
      return isConnect;
    }catch(e){
      return isConnect;
    }
  }
  blueButtonAutherizations()async{
   //  bool isConnect = false;
   // String appUserId = await _authServices!.getCurrentAppUserId();
   try{
     Response? response  = await _dioServices?.dio?.get(BlueButton.blueButtonOAuthredirect);
     if(response?.statusCode == 200){
       return response;
     }else{
       return null;
     }
   }catch(e){
     return null;
   }
  }

}